//
//  ALSegmentedControl.h
//  Allianz
//
//  Created by Matías Ginart on 8/23/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALSegmentedControl : UIView

@property (nonatomic, weak) IBOutlet UIButton* firstButton;
@property (nonatomic, weak) IBOutlet UIButton* entryButton;
@property (nonatomic, weak) IBOutlet UIButton* sentButton;

+ (instancetype)view;

- (IBAction)buttonTouched:(id)sender;

- (void)showTwoButtons;

@end
