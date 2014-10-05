//
//  LoginViewController.h
//  Allianz
//
//  Created by Matías Ginart on 7/24/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "IPhoneRootViewController.h"

#define kMensajesLeidosNotification @"MensajesLeidosNotification"

@class LoginViewController;
@protocol LoginViewControllerDelegate <NSObject>
-(void)loginViewController:(LoginViewController*)viewController disappearedWithSuccess:(BOOL)success;
@end


@interface LoginViewController : IPhoneRootViewController

@property (nonatomic, weak) IBOutlet UITextField* usernameTextField;
@property (nonatomic, weak) IBOutlet UITextField* passwordTextField;
@property (nonatomic, weak) IBOutlet UIScrollView* scrollView;
@property (nonatomic, weak) IBOutlet UILabel* copyrightLabel;
@property (nonatomic, weak) IBOutlet UIButton* loginButton;
@property (nonatomic, weak) IBOutlet UIButton* registerButton;
@property (nonatomic, weak) IBOutlet UIButton* forgotPasswordButton;
@property (nonatomic, weak) id<LoginViewControllerDelegate> delegate;

- (IBAction)login;

- (IBAction)makeRegistration;

- (IBAction)forgotPassword;

@end
