//
//  ALLoggedButton.m
//  Allianz
//
//  Created by Jonathan Banga on 28/8/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "ALLoggedButton.h"
#import "UIColor+ALColor.h"

#define kOffset 10
#define kLabelSize 17
#define kLabelXOffset 4
#define kLabelYOffset 8

@interface ALLoggedButton()
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)NSString *imageName;
@end

@implementation ALLoggedButton

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
    [self setBackgroundImage:nil forState:UIControlStateNormal];
    [self setImage:nil forState:UIControlStateNormal];
    
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kOffset,kOffset,self.frame.size.width-kOffset*2,self.frame.size.height-kOffset*2)];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.iconImageView];
    self.imageName = @"Profile";
}

- (void)fillIconImage:(UIImage*)iconImage {
    self.iconImageView.image = [iconImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 7) {
        self.iconImageView.tintColor = [UIColor whiteColor];
    }
}

- (void)updateFill{
    if (self.userLogged) {
        [self fillIconImage:[UIImage imageNamed:self.imageName]];
    }else{
        self.iconImageView.image = [UIImage imageNamed:self.imageName];
    }
}

- (void)setUserLogged:(BOOL)userLogged{
    _userLogged = userLogged;
    [self updateFill];
}

@end
