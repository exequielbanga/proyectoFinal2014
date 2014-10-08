//
//  ALSegmentedControl.m
//  Allianz
//
//  Created by Matías Ginart on 8/23/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "ALSegmentedControl.h"
#import "UIColor+ALColor.m"
#import "UIFont+ALFonts.h"

#define kInitialMaxButtons 3

@interface ALSegmentedControl ()
@property (nonatomic, strong) NSArray* allButtons;
@end

@implementation ALSegmentedControl

+ (instancetype)view {
    ALSegmentedControl* segmentedControl = [[NSBundle mainBundle] loadNibNamed:@"ALSegmentedControl" owner:nil options:nil][0];
    return segmentedControl;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.allButtons = @[self.firstButton,self.entryButton, self.sentButton];
    [self setBorderOfButton:self.firstButton];
    [self setBorderOfButton:self.entryButton];
    [self setBorderOfButton:self.sentButton];

    [self setSelectedAppereanceOfButton:self.firstButton];
    [self setNonselectedAppereanceOfButton:self.entryButton];
    [self setNonselectedAppereanceOfButton:self.sentButton];
}

- (IBAction)buttonTouched:(id)sender {
    for (UIButton* aButton in self.allButtons) {
        if (aButton == sender) {
            [self setSelectedAppereanceOfButton:aButton];
        } else {
            [self setNonselectedAppereanceOfButton:aButton];
        }
    }
}

- (void)setSelectedAppereanceOfButton:(UIButton*)button {
    button.backgroundColor = [UIColor ALRedColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont allianzSansWithSize:17];
}

- (void)setNonselectedAppereanceOfButton:(UIButton*)button {
    button.backgroundColor = [UIColor ALLightBlueColor];
    [button setTitleColor:[UIColor ALBlueColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont allianzSansWithSize:17];
}

- (void)setBorderOfButton:(UIButton*)aButton {
    aButton.layer.borderWidth = 0.5f;
    aButton.layer.borderColor = [UIColor grayColor].CGColor;
}

@end
