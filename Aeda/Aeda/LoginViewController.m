//
//  LoginViewController.m
//  Allianz
//
//  Created by Matías Ginart on 7/24/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "LoginViewController.h"
#import "UIColor+ALColor.h"
#import "ALToolbar.h"
#import "LoginService.h"
#import "User.h"
#import "UserManager.h"

@interface LoginViewController () <UITextFieldDelegate>
@property (nonatomic, strong) LoginService* loginService;
@end

@implementation LoginViewController

#pragma mark - UIViewController cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    ALToolbar* alToolbarUserName = [ALToolbar toolbarWithSize:CGSizeMake(self.view.frame.size.width, 44) doneTappedBlock:^(ALToolbar *toolbar){
        [self.passwordTextField resignFirstResponder];
        [self.usernameTextField resignFirstResponder];
    } nextTappedBlock:^(ALToolbar *toolbar){
        [self.passwordTextField becomeFirstResponder];
    }];
    ALToolbar* alToolbarUserPass = [ALToolbar toolbarWithSize:CGSizeMake(self.view.frame.size.width, 44) doneTappedBlock:^(ALToolbar *toolbar){
        [self.passwordTextField resignFirstResponder];
        [self login];
    }];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 7) {
        self.passwordTextField.tintColor = [UIColor ALLightGrayColor];
    }
    self.passwordTextField.textColor = [UIColor ALLightGrayTextColor];
    self.passwordTextField.inputAccessoryView = alToolbarUserPass;

    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 7) {
        self.usernameTextField.tintColor = [UIColor ALBlueColor];
    }
    self.usernameTextField.textColor = [UIColor ALBlueColor];
    self.usernameTextField.inputAccessoryView = alToolbarUserName;

    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.copyrightLabel.frame.origin.y + self.copyrightLabel.frame.size.height + 10);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

//    [self.loginService cancel];
//    [self.forgotPasswordService cancel];
}

#pragma mark - Actions

- (IBAction)login {
    NSString* username = self.usernameTextField.text;
    NSString* password = self.passwordTextField.text;

    if (username.length == 0 || password.length == 0) {
        [self showError:@"Usuario o password incorrectos"];
        return;
    }

    [self showLoadingMessage];
    self.loginService = [[LoginService alloc] init];
    [self.loginService authenticateWithUsername:username password:password finishedBlock:^(NSObject *response, NSError *error) {
        [self hideLoadingMessage];
        if (error) {
//            [self showError:[error userInfo][kErrorValue]];
        } else {
//            User* anUser = ((NSArray*)response)[0];
//            [UserManager setCurrentUser:anUser];
            [self success];
        }
    }];

}

- (IBAction)makeRegistration {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/pages/Soluci%C3%B3n-para-Auto-Entrenamiento-Deportivo-Amateur/913175838711058"]];
}

- (IBAction)forgotPassword {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/pages/Soluci%C3%B3n-para-Auto-Entrenamiento-Deportivo-Amateur/913175838711058"]];
}

- (void)success
{
    [self.delegate loginViewController:self disappearedWithSuccess:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)back{
    [self dismissViewControllerAnimated:YES completion:^(){
        [self.delegate loginViewController:self disappearedWithSuccess:NO];
    }];
}

#pragma mark - UIKeyboard

- (void)keyboardWillShow:(NSNotification*)notification {
    CGRect keyboardBounds = CGRectNull;
	[[notification.userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey] getValue:&keyboardBounds];
    
	UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardBounds.size.height, 0.0);
	self.scrollView.contentInset = contentInsets;
	self.scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)keyboardWillHide:(NSNotification*)notification {
	UIEdgeInsets contentInsets = UIEdgeInsetsZero;
	self.scrollView.contentInset = contentInsets;
	self.scrollView.scrollIndicatorInsets = contentInsets;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.usernameTextField) {
        [self.passwordTextField becomeFirstResponder];
    } else {
        [self.passwordTextField resignFirstResponder];
        [self login];
    }
    return YES;
}

@end
