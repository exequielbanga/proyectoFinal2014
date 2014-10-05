//
//  SHAuthenticationViewController.h
//  Spacehold
//
//  Created by Jonathan Banga on 11/6/14.
//  Copyright (c) 2014 Sergio. All rights reserved.
//

#import "IPhoneRootViewController.h"

@class ALAuthenticationViewController;
@protocol ALAuthenticationViewControllerDelegate <NSObject>
@optional
- (void)authenticationViewControllerUserLogged:(ALAuthenticationViewController *)authenticationViewController;
- (void)authenticationViewControllerUserNotLogged:(ALAuthenticationViewController *)authenticationViewController;
@end

@interface ALAuthenticationViewController : IPhoneRootViewController
@property(nonatomic,weak)id<ALAuthenticationViewControllerDelegate>authDelegate;
//Make the service calls here
- (void)userLoged;
//Handle the fact that the user cancelled the login
- (void)userNotLoged;
@end
