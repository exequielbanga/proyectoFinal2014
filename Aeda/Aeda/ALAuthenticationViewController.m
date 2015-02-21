//
//  SHAuthenticationViewController.m
//  Spacehold
//
//  Created by Jonathan Banga on 11/6/14.
//  Copyright (c) 2014 Sergio. All rights reserved.
//

#import "ALAuthenticationViewController.h"
#import "LoginViewController.h"
#import "UserManager.h"

@interface ALAuthenticationViewController ()<LoginViewControllerDelegate>
@property(nonatomic,strong)LoginViewController * login;
@end

@implementation ALAuthenticationViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([UserManager logged]) {
        [self userLoged];
    }else if (!self.login) {
        [self showLoginWithAnimation:YES];
    }
}
- (void)showLoginWithAnimation:(BOOL)animated{
    self.login = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    self.login.delegate = self;
    self.login.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:self.login animated:YES completion:nil];
}

-(void)loginViewController:(LoginViewController*)viewController disappearedWithSuccess:(BOOL)success{
    self.login = nil;
    if (success) {
        [self userLoged];
    }else{
        [self userNotLoged];
    }
}

- (void)userLoged{
    if ([self.authDelegate respondsToSelector:@selector(authenticationViewControllerUserLogged:)]) {
        [self.authDelegate authenticationViewControllerUserLogged:self];
    }
}


- (void)userNotLoged{
    if ([self.authDelegate respondsToSelector:@selector(authenticationViewControllerUserNotLogged:)]) {
        [self.authDelegate authenticationViewControllerUserNotLogged:self];
    }
}



@end