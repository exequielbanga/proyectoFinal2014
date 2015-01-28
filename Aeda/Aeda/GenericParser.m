//
//  GenericParser.m
//
//  Created by Exequiel Banga on 5/11/14.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GenericParser.h"
#import "Utils.h"

@implementation GenericParser

- (id)init {
    self = [super init];
    if (self) {
        self.resultObjects = [NSMutableArray array];
    }
    return self;
}

- (void)parse:(id)responseObject {
    NSError *error = [self errorFromResponse:responseObject];
    if (error) {
        self.error = error;
    }else{
        [self parseResponse:responseObject];
    }
}

- (NSString *)keyPathToResponse{
    // Abstract method
    return nil;
}

- (Class)responseObjectsClass{
    // Abstract method
    return nil;
}

- (void)parseResponse:(id)response{
    NSArray* allObjectsDictionaries;
    if ([response isKindOfClass:[NSDictionary class]]) {
        allObjectsDictionaries = [Utils arrayFromObject:[(NSDictionary *)response valueForKeyPath:[self keyPathToResponse]]];
    }else{
        allObjectsDictionaries = (NSArray *)response;
    }
    for (NSDictionary* objectData in allObjectsDictionaries) {
        [self.resultObjects addObject:[[[self responseObjectsClass] alloc] initWithDictionary:objectData]];
    }
}

- (NSError *)errorFromResponse:(id)responseObject{
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *fault = [(NSDictionary *)responseObject valueForKeyPath:@"path.to.error"];
        if (fault) {
            // setear el error
        }
    }
    return self.error;
}

@end
