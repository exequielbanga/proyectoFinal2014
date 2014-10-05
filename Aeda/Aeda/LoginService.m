//
//  LoginService.m
//  Allianz
//
//  Created by Matías Ginart on 7/25/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "LoginService.h"
#import "LoginParser.h"
#import "UserManager.h"
#import "User.h"

@interface LoginService()
@property (nonatomic, copy) NSString* username;
@property (nonatomic, copy) NSString* password;
@end

@implementation LoginService

- (void)authenticateWithUsername:(NSString*)username password:(NSString*)password finishedBlock:(ServiceBlock)block {
    if (!username || !password) {
        block(nil, [NSError errorWithDomain:@"" code:400 userInfo:@{@"cause" : @"user_password_invalid"}]);
    }
    self.username = username;
    self.password = password;
//    [self startWithBlock:block];
}

- (NSString*)serviceURL{
    return @"https://wbs.allianzonline.com.ar:9443/Infra/CSMService/Externo/Operaciones/OpCSMServiceExtReqABCS";
}

- (Class)parserClass {
    return [LoginParser class];
}

- (void)changeMessage:(NSMutableString*)message {
    [message replaceOccurrencesOfString:@"@1@" withString:self.username options:NSCaseInsensitiveSearch range:NSMakeRange(0, message.length)];
    [message replaceOccurrencesOfString:@"@2@" withString:self.password options:NSCaseInsensitiveSearch range:NSMakeRange(0, message.length)];
}

- (void)parseData:(NSString *)data {
//    [super parseData:data];
//    if ([self.response isKindOfClass:[NSArray class]] && [(NSArray*)self.response count] > 0) {
//        NSArray* array = (NSArray*)self.response;
//        User* user = array[0];
//        user.password = self.password;
//    }
}


- (void)logoutWithFinishedBlock:(ServiceBlock)block{
    [UserManager setCurrentUser:nil];
    block(nil,nil);
}


@end
