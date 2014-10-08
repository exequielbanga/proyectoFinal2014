//
//  ALFillButton.m
//  Allianz
//
//  Created by Matías Ginart on 7/24/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "ALFillButton.h"
#import "UIColor+ALColor.h"
#import "UIColor+ALAdditions.h"

@implementation ALFillButton

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // VER PORQUE NO FUNCAAAAA
        //[self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (highlighted) {
        self.backgroundColor = [[UIColor ALRedColor] darkerColor];
    } else {
        self.backgroundColor = [UIColor ALRedColor];
    }
}

@end
