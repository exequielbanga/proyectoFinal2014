//
//  ALButton.m
//
//
//  Created by Matias Ginart on 17/07/12.
//  Copyright (c) 2012 Casa. All rights reserved.
//

#import "ALButton.h"

@interface ALButton()
@property (nonatomic, strong) UIImageView* iconImageView;
@end

@implementation ALButton

- (void)initialice {
    UIImage *btnGrayImage = [UIImage imageNamed:@"btnGrayBlue.png"];
    btnGrayImage = [btnGrayImage stretchableImageWithLeftCapWidth:9 topCapHeight:0];
    [self setBackgroundImage:btnGrayImage forState:UIControlStateNormal];

    self.iconImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.iconImageView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
}

- (id)init {
    self = [super init];
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

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialice];
    }
    return self;
}

- (void)setIcon:(UIImage*)image {
    if (image) {
        // We insert it a little higher, due to the shadow of the background image
        self.iconImageView.frame = CGRectMake((self.frame.size.width - image.size.width)/2, (self.frame.size.height - image.size.height)/2 - 1, image.size.width, image.size.height);
        self.iconImageView.image = image;
        [self addSubview:self.iconImageView];
    } else {
        [self.iconImageView removeFromSuperview];
    }
}


@end
