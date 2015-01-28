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
@end

@implementation LoginService

- (RestMethod)method {
    return RestMethodPOST;
}

- (BOOL)isAuthenticated{
    return NO;
}

- (Class)parserClass {
    return [LoginParser class];
}

- (void)authenticateWithUsername:(NSString*)username password:(NSString*)password finishedBlock:(ServiceBlock)block {
    if (!username || !password) {
        block(nil, [NSError errorWithDomain:@"" code:400 userInfo:@{@"cause" : @"user_password_invalid"}]);
    }
    self.path = @"Usuarios/login.json";
    
    self.bodyParams = @{
    @"data[Usuario][username]":username,
    @"data[Usuario][password]":password
    };

    [self requestWithServiceBlock:block];
}

- (void)logoutWithFinishedBlock:(ServiceBlock)block{
    [UserManager setCurrentUser:nil];
    block(nil,nil);
}

@end
