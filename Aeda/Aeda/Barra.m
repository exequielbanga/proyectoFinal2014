//
//  Barra.m
//  Aeda
//
//  Created by Jonathan Banga on 5/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "Barra.h"
#import <QuartzCore/QuartzCore.h>

#define kRadiusPercentage 0.2

@implementation Barra

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    switch (self.mode) {
        case BarraModoHorizontal:
//            self.layer.cornerRadius =
            break;
        case BarraModoVertical:
        
            break;
    }
}

@end
