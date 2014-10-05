//
//  ALViewController.m
//  Allianz
//
//  Created by Matías Ginart on 7/26/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "ALViewController.h"
#import "MBProgressHUD.h"
#import "UIColor+ALColor.h"
#import <QuartzCore/QuartzCore.h>

@interface ALViewController ()
@property (nonatomic, strong) MBProgressHUD* loadingHUD;
@end

@implementation ALViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    NSString *nibName = nibNameOrNil;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        if ([[NSBundle mainBundle] pathForResource:[nibNameOrNil stringByAppendingString:@"iPad"] ofType:@"nib"]) {
            nibName = [nibNameOrNil stringByAppendingString:@"iPad"];
        }
    }
    
    self = [super initWithNibName:nibName bundle:nibBundleOrNil];
    return self;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self hideLoadingMessage];
}

- (void)showError:(NSString*)errorString delegate:(id<UIAlertViewDelegate>)delegate{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    alert.delegate = delegate;
    [alert show];
}

- (void)showError:(NSString*)errorString {
    [[[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
}

- (void)showLoadingMessage {
    if (!self.loadingHUD) {
        self.loadingHUD = [[MBProgressHUD alloc] initWithView:self.view];
        self.loadingHUD.labelText = @"Cargando";
        self.loadingHUD.color = [UIColor ALBlueColor];
        self.loadingHUD.removeFromSuperViewOnHide = YES;
    }

    [self.view addSubview:self.loadingHUD];
    [self.loadingHUD show:YES];
}

- (void)hideLoadingMessage {
    [self.loadingHUD hide:YES];
}

@end
