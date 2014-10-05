//
//  LoginParser.m
//  Allianz
//
//  Created by Matías Ginart on 7/25/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "LoginParser.h"
#import "User.h"

@implementation LoginParser

- (NSString *)keyPathToResponse{
    return @"soapenv:Envelope.soapenv:Body.opc:AuthenticateResponseEBM.opc:DataArea.opc:AuthenticateResponse";
}

- (Class)responseObjectsClass{
    return [User class];
}

- (NSError *)errorFromDictionary:(NSDictionary *)dictionary {
    NSError* errorToReturn = [super errorFromDictionary:dictionary];
    if (!errorToReturn) {
        NSDictionary* errorData = dictionary[@"soapenv:Envelope"][@"soapenv:Body"][@"opc:AuthenticateResponseEBM"];
        if (errorData) {
            NSString* possibleErrorCode = errorData[@"ebm:ErrorCode"][@"text"];
            NSString* possibleErrorMessage = errorData[@"ebm:ReturnMessage"][@"text"];
            if (possibleErrorCode && possibleErrorMessage) {
                errorToReturn = [NSError errorWithDomain:@"Error" code:400 userInfo:@{kErrorCode : possibleErrorCode, kErrorValue: possibleErrorMessage}];
            }
        }
    }
    return errorToReturn;
}

@end
