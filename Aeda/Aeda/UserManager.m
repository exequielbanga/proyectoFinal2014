//
//  UserManager.m
//  Allianz
//
//  Created by Matías Ginart on 7/26/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "UserManager.h"

#define kPath @"User.dat"

@implementation UserManager

User* currentUser;
BOOL logged;
+ (void)setLogged:(BOOL)_logged{
    logged = _logged;
}

+ (BOOL)logged{
    return logged;
}


+ (NSString*)filePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    return [documentsDirectory stringByAppendingPathComponent:kPath];
}

+ (void)cleanUser{
    @synchronized([self class]){
        NSString *fileName = [[self class] filePath];
        [NSKeyedArchiver archiveRootObject:nil toFile:fileName];
    }
}

+ (void)save {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized([self class]){
            NSString *fileName = [[self class] filePath];
            [NSKeyedArchiver archiveRootObject:[self getCurrentUser] toFile:fileName];
        }
    });
}

+ (void)setCurrentUser:(User*)anUser {
    currentUser = anUser;
    if (currentUser) {
        [self save];
    }else{
        [self cleanUser];
    }
}

+ (User*)getCurrentUser {
    if (!currentUser) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString* path = [self filePath];
        if([fileManager fileExistsAtPath:path]) {
            currentUser = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        }
    }
    return currentUser;
}

@end
