//
//  LoginService.h
//  Allianz
//
//  Created by Matías Ginart on 7/25/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "RestService.h"

@interface LoginService : RestService

- (void)authenticateWithUsername:(NSString*)username password:(NSString*)password finishedBlock:(ServiceBlock)block;

- (void)logoutWithFinishedBlock:(ServiceBlock)block;

@end
