//
//  iPhoneRootViewController.m
//  Allianz
//
//  Created by Matías Ginart on 7/24/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "IPhoneRootViewController.h"
#import "UIColor+ALColor.h"

@interface IPhoneRootViewController ()

@end

@implementation IPhoneRootViewController

+ (instancetype)alloc{
    NSString *className = NSStringFromClass([self class]);
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if ([NSClassFromString([className stringByAppendingString:@"iPad"]) class]) {
            className = [className stringByAppendingString:@"iPad"];
            return [NSClassFromString(className) alloc];
        }
    }
    return [super alloc];
}

- (BOOL)mustShowHomeMenu {
    return UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad;
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.barTintColor = [UIColor ALBlueColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    NSUInteger numberOfControllersToRoot = 2;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ) {
        numberOfControllersToRoot = 1;
    }
    if (self.navigationController && self.navigationController.viewControllers.count == numberOfControllersToRoot) {
        if ([self mustShowHomeMenu]) {
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Open Side Icon"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
        }
    } else {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Back Icon Navigation"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (BOOL)mustShowMenuButton {
    return YES;
}

- (void)goBack {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        if (self.navigationController.viewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
//            [(UISplitViewController *)self.navigationController.parentViewController hide]
        }
    }
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end
