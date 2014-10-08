//
//  ALStokreButton.m
//  Allianz
//
//  Created by Matías Ginart on 7/24/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "ALStrokeButton.h"
#import "UIColor+ALColor.h"
#import "UIColor+ALAdditions.h"
#import <QuartzCore/QuartzCore.h>

@implementation ALStrokeButton

- (void)initialice {
    self.layer.borderWidth = 1.5f;
    self.layer.borderColor = [UIColor ALRedColor].CGColor;
    [self setTitleColor:[UIColor ALRedColor] forState:UIControlStateNormal];
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

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (highlighted) {
        self.layer.borderColor = [UIColor ALRedColorWithAlpha:0.3f].CGColor;
    } else {
        self.layer.borderColor = [UIColor ALRedColor].CGColor;
    }
}

@end
