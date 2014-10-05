//
//  RestService.m
//  Allianz
//
//  Created by Matías Ginart on 8/14/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "RestService.h"
#import "AFNetworking.h"
#import "UserManager.h"

//#define kURI @"http://argba-cctest:8080/api-stateless"
#define kURI @"http://contactcenter.miallianz.com.ar:9091/api-stateless"

@interface RestService()
@property (nonatomic, strong) AFHTTPRequestOperation* requestOperation;
@end

@implementation RestService


- (id)init {
    self = [super init];
    if (self) {
        self.isRunning = NO;
    }
    return self;
}

#pragma mark - To inherit

// El metodo rest: GET, POST, PUT, DELETE
- (RestMethod)method {
    return RestMethodGET;
}

// Se llamara a este metodo cuando todo haya terminado con code 2xx
- (NSObject*)requestSuccessWithResponseObject:(id)responseObject {
    return nil;
}

// El username en caso de ser una llamada autenticada
- (NSString*)username {
    return [[UserManager getCurrentUser] username];
}

// El password en caso de ser una llamada autenticada
- (NSString*)password {
    return [[UserManager getCurrentUser] password];
}

// YES si es autenticada, NO en caso contrario
- (BOOL)isAuthenticated {
    return YES;
}

#pragma mark - Private

- (void)requestWithServiceBlock:(ServiceBlock)serviceBlock {
    if ([self method] == RestMethodGET) {
        [self makeGetWithServiceBlock:serviceBlock];
    } else if([self method] == RestMethodPOST) {
        [self makePostWithServiceBlock:serviceBlock];
    } else {
        [self makePutWithServiceBlock:serviceBlock];
    }
}

- (void)makeGetWithServiceBlock:(ServiceBlock)serviceBlock {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];

    if ([self isAuthenticated]) {
        User* currentUser = [UserManager getCurrentUser];
        [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:[currentUser username]  password:[currentUser password]];
    }

    NSString* path = [NSString stringWithFormat:@"%@%@", kURI, self.path];
    NSLog(@"----------");
    NSLog(@"Service Method: GET");
    NSLog(@"Path: %@", path);
    NSLog(@"Query params: %@", self.queryParams);
    NSLog(@"----------");
    self.isRunning = YES;
    self.requestOperation = [manager GET:path parameters:self.queryParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.isRunning = NO;
        NSObject* returnObject = [self requestSuccessWithResponseObject:responseObject];
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

- (void)makePostWithServiceBlock:(ServiceBlock)serviceBlock {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    
    if ([self isAuthenticated]) {
        User* currentUser = [UserManager getCurrentUser];
        [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:[currentUser username]  password:[currentUser password]];
    }

    self.isRunning = YES;
    NSString* path = [NSString stringWithFormat:@"%@%@", kURI, self.path];

    self.requestOperation = [manager POST:path parameters:self.bodyParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.isRunning = NO;
        NSObject* returnObject = [self requestSuccessWithResponseObject:responseObject];
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
        User* currentUser = [UserManager getCurrentUser];
        [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:[currentUser username]  password:[currentUser password]];
    }
    
    self.isRunning = YES;
    NSString* path = [NSString stringWithFormat:@"%@%@", kURI, self.path];
    
    self.requestOperation = [manager PUT:path parameters:self.bodyParams success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.isRunning = NO;
        NSObject* returnObject = [self requestSuccessWithResponseObject:responseObject];
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

@end
