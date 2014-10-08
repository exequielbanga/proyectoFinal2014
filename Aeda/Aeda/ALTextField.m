//
//  ALTextField.m
//  Allianz
//
//  Created by Matías Ginart on 7/24/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "ALTextField.h"

@implementation ALTextField

- (void)initialice {
    self.borderStyle = UITextBorderStyleNone;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 2;
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

- (void)tintColorDidChange {
    [super tintColorDidChange];
    self.layer.borderColor = self.tintColor.CGColor;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 10, 10);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 10, 10);
}

@end
