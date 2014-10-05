//
//  ALViewController.h
//  Allianz
//
//  Created by Matías Ginart on 7/26/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALViewController : UIViewController

- (void)showError:(NSString*)errorString;
- (void)showError:(NSString*)errorString delegate:(id<UIAlertViewDelegate>)delegate;

- (void)showLoadingMessage;

- (void)hideLoadingMessage;

@end
