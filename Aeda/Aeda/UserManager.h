//
//  UserManager.h
//  Allianz
//
//  Created by Matías Ginart on 7/26/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface UserManager : NSObject

+ (void)setCurrentUser:(User*)anUser;

+ (User*)getCurrentUser;

+ (void)save;

@end
