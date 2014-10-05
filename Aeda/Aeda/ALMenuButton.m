//
//  ALMenuButton.m
//  Allianz
//
//  Created by Matías Ginart on 7/29/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "ALMenuButton.h"
#import "UIFont+ALFonts.h"
#import "UIColor+ALAdditions.h"

@interface ALMenuButton ()
@property (nonatomic, strong) UIImageView* iconImageView;
@end

@implementation ALMenuButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialice];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialice];
    }
    return self;
}

- (void)initialice {
    self.backgroundColor = [UIColor clearColor];

    UIImage* backgroundImage = [UIImage imageNamed:@"Thumbnails Background"];
    [self setBackgroundImage:backgroundImage forState:UIControlStateNormal];

    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(17, 20, 48, 48)];
    self.iconImageView.tintColor = [UIColor whiteColor];
    [self addSubview:self.iconImageView];

    self.firstLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 84, self.frame.size.width - 20, 20)];
    self.firstLineLabel.backgroundColor = [UIColor clearColor];
    self.firstLineLabel.textColor = [UIColor whiteColor];
    self.firstLineLabel.font = [UIFont allianzSansWithSize:18];
    [self addSubview:self.firstLineLabel];

    self.secondLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 104, self.frame.size.width - 20, 20)];
    self.secondLineLabel.backgroundColor = [UIColor clearColor];
    self.secondLineLabel.textColor = [UIColor whiteColor];
    self.secondLineLabel.font = [UIFont allianzSansBoldWithSize:18];
    [self addSubview:self.secondLineLabel];

    [self addTarget:self action:@selector(isBeingTouched) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(isNotBeingTouched) forControlEvents:UIControlEventTouchCancel];
    [self addTarget:self action:@selector(isNotBeingTouched) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(isNotBeingTouched) forControlEvents:UIControlEventTouchUpOutside];
}

- (void)setIconImage:(UIImage*)iconImage {
    self.iconImageView.image = [iconImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

- (void)isBeingTouched {
    UIColor* newColor = [UIColor colorWithWhite:0.7f alpha:1];
    self.iconImageView.tintColor = newColor;
    self.firstLineLabel.textColor = newColor;
    self.secondLineLabel.textColor = newColor;
}

- (void)isNotBeingTouched {
    self.iconImageView.tintColor = [UIColor whiteColor];
    self.firstLineLabel.textColor = [UIColor whiteColor];
    self.secondLineLabel.textColor = [UIColor whiteColor];
}

@end
