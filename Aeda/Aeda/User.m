//
//  User.m
//  Allianz
//
//  Created by Matías Ginart on 7/25/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "User.h"
#import "PDKeychainBindings.h"

#define kUserIdEncoder @"kUserIdEncoder"
#define kUserFirstname @"kUserFirstname"
#define kUserLastname @"kUserLastname"
#define kUserUsername @"kUserUsername"
#define kUserEmail @"kUserEmail"
#define kUserPassword @"kUserPassword"

@interface User () <NSCoding>
@end

@implementation User

- (id)initWithDictionary:(NSDictionary*)dictionary {
    self = [super init];
    if (self) {
        self.userId = dictionary[@"opc:userId"];
        self.firstname = dictionary[@"opc:firstName"];
        self.lastname = dictionary[@"opc:lastName"];
        self.username = dictionary[@"opc:userName"];
        self.email = dictionary[@"opc:email"];
    }
    return self;
}

- (id)initMock{
    self = [super init];
    if (self) {
        self.userId = @"001";
        self.firstname = @"Chino";
        self.lastname = @"Maidana";
        self.username = @"ElChinitoGuaymayen";
        self.email = @"chino@maidana.com";
    }
    return self;
}


- (id)initWithCoder:(NSCoder*)coder {
    self = [super init];
    if (self) {
        self.userId = [coder decodeObjectForKey:kUserIdEncoder];
        self.firstname = [coder decodeObjectForKey:kUserFirstname];
        self.lastname = [coder decodeObjectForKey:kUserLastname];
        self.username = [coder decodeObjectForKey:kUserUsername];
        self.email = [coder decodeObjectForKey:kUserEmail];
        self.password = [[PDKeychainBindings sharedKeychainBindings] stringForKey:kUserPassword];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.userId forKey:kUserIdEncoder];
    [aCoder encodeObject:self.firstname forKey:kUserFirstname];
    [aCoder encodeObject:self.lastname forKey:kUserLastname];
    [aCoder encodeObject:self.username forKey:kUserUsername];
    [aCoder encodeObject:self.email forKey:kUserEmail];
    
    [[PDKeychainBindings sharedKeychainBindings] setString:self.password forKey:kUserPassword];
}

@end
