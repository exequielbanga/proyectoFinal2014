//
//  ALNavigationViewController.m
//  Allianz
//
//  Created by Matías Ginart on 8/11/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "ALNavigationViewController.h"

@interface ALNavigationViewController ()

@end

@implementation ALNavigationViewController

- (NSUInteger)supportedInterfaceOrientations {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return UIInterfaceOrientationMaskAll;
    } else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

@end
