//
//  RestService.m
//  Allianz
//
//  Created by Exequiel Banga on 5/11/14.
//  Copyright (c) 2014 Exequiel Banga. All rights reserved.
//

#import "RestService.h"
#import "AFNetworking.h"
#import "GenericParser.h"

#define kURI @"http://192.168.0.11/aeda/aeda_new/aeda/"
//#define kURI @"http://t9000277.ferozo.com/aeda/"
#define kCacheRootPath @"/"

@interface RestService()
@property (nonatomic, strong) AFHTTPRequestOperation* requestOperation;
@property (nonatomic, strong) GenericParser *parser;
@end

@implementation RestService

#pragma mark - Init

- (id)init {
    self = [super init];
    if (self) {
        self.isRunning = NO;
    }
    return self;
}

#pragma mark - Logic
// Se llamara a este metodo cuando todo haya terminado con code 2xx
- (NSObject*)requestSuccessWithResponseObject:(id)responseObject {
    self.parser = [[[self parserClass] alloc] init];
    [self.parser parse:responseObject];

    if (self.parser.error) {
        return self.parser.error;
    }else{
        return self.parser.resultObjects;
    }
}

// El username en caso de ser una llamada autenticada
- (NSString*)username {
    return nil;
}

// El password en caso de ser una llamada autenticada
- (NSString*)password {
    return nil;
}

// YES si es autenticada, NO en caso contrario
- (BOOL)isAuthenticated {
    return NO;
}

#pragma mark - Private

- (void)requestWithServiceBlock:(ServiceBlock)serviceBlock {
    //Si hay datos cacheados los devuelve
    if ([self hasChaceForService]) {
        serviceBlock([NSKeyedUnarchiver unarchiveObjectWithFile:[self cachePath]],nil);
    }
    if (![self hasChaceForService] || [self shouldUpdateCache]) {
        if ([self method] == RestMethodGET) {//Realiza la llamada
            [self makeGetWithServiceBlock:serviceBlock];
        } else if([self method] == RestMethodPOST) {
            [self makePostWithServiceBlock:serviceBlock];
        } else {
            [self makePutWithServiceBlock:serviceBlock];
        }
    }
}

- (void)makeGetWithServiceBlock:(ServiceBlock)serviceBlock {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    if ([self isAuthenticated]) {
//        User* currentUser = [UserManager getCurrentUser];
//        [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:[currentUser username]  password:[currentUser password]];
    }

    NSString* path = [NSString stringWithFormat:@"%@%@", (self.specificUri == nil)? kURI : self.specificUri, self.path];
    self.isRunning = YES;
    
//    self.requestOperation.responseSerializer = [AFJSONResponseSerializer serializer];

    self.requestOperation = [manager GET:path parameters:self.queryParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.isRunning = NO;
        
        NSArray* returnObject = (NSArray *)[self requestSuccessWithResponseObject:[NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil]];
        if (returnObject) {
            [self saveCache:returnObject];
        }
        if (serviceBlock) {
            serviceBlock(returnObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.isRunning = NO;
        // No es porque cancelamos el request, y si no hay cache
        if (serviceBlock && error.code != -999 && ![self hasChaceForService]) {
            serviceBlock(nil, error);
        }
    }];
}

- (void)makePostWithServiceBlock:(ServiceBlock)serviceBlock {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    
    if ([self isAuthenticated]) {
//        User* currentUser = [UserManager getCurrentUser];
//        [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:[currentUser username]  password:[currentUser password]];
    }

    self.isRunning = YES;
    NSString* path = [NSString stringWithFormat:@"%@%@", kURI, self.path];

    self.requestOperation = [manager POST:path parameters:self.bodyParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.isRunning = NO;
        NSArray* returnObject = (NSArray *)[self requestSuccessWithResponseObject:responseObject];
        if (returnObject) {
            [self saveCache:returnObject];
        }
        if (serviceBlock) {
            serviceBlock(returnObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.isRunning = NO;
        // No es porque cancelamos el request
        if (serviceBlock && error.code != -999) {
            serviceBlock(nil, error);
        }
    }];
}

- (void)makePutWithServiceBlock:(ServiceBlock)serviceBlock {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    
    if ([self isAuthenticated]) {
//        User* currentUser = [UserManager getCurrentUser];
//        [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:[currentUser username]  password:[currentUser password]];
    }
    
    self.isRunning = YES;
    NSString* path = [NSString stringWithFormat:@"%@%@", kURI, self.path];
    
    self.requestOperation = [manager PUT:path parameters:self.bodyParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.isRunning = NO;
        NSArray* returnObject = (NSArray *)[self requestSuccessWithResponseObject:responseObject];
        if (serviceBlock) {
            serviceBlock(returnObject, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.isRunning = NO;
        // No es porque cancelamos el request
        if (serviceBlock && error.code != -999) {
            serviceBlock(nil, error);
        }
    }];
}

- (void)invalidate {
    [self.requestOperation cancel];
    self.isRunning = NO;
}

- (void)dealloc {
    [self invalidate];
}

#pragma mark - Cache
-(BOOL)hasChaceForService{
    return NO;
//    return [[NSFileManager defaultManager] fileExistsAtPath:[self cachePath]];
}

- (NSString *)cachePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    
    return [documentsDirectory stringByAppendingFormat:@"%@%@-cache.dat",kCacheRootPath,[self.path stringByReplacingOccurrencesOfString:@"/" withString:@"-"]];
}

- (void)saveCache:(NSArray<NSCoding>*)object{
//    @synchronized([self class]){
//        [NSKeyedArchiver archiveRootObject:object toFile:[self cachePath]];
//    }
}

#pragma mark - To inherit

- (Class)parserClass{
    return [GenericParser class];
}

// El metodo rest: GET, POST, PUT, DELETE
- (RestMethod)method {
    return RestMethodGET;
}

- (BOOL)shouldUpdateCache{
    return YES;
}

@end
