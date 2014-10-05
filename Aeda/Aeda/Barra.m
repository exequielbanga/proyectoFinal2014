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
#define kSpeed 2

@interface Barra()
@property(nonatomic,strong)UIView *bar;
@end

@implementation Barra

- (void)internalInit{
    self.backgroundColor = [UIColor clearColor];
    self.bar = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:self.bar];
    self.mode = BarraModoHorizontal;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self internalInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self internalInit];
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    switch (self.mode) {
        case BarraModoHorizontal:
            self.bar.layer.cornerRadius = self.frame.size.height*kRadiusPercentage;
            break;
        case BarraModoVertical:
            self.bar.layer.cornerRadius = self.frame.size.width*kRadiusPercentage;
            break;
    }
}

- (void)setValor:(NSNumber *)valor{
    _valor = valor;
    self.bar.backgroundColor = [UIColor colorWithRed:1-[valor floatValue] green:[valor floatValue] blue:0 alpha:1];
    switch (self.mode) {
        case BarraModoHorizontal:
            self.bar.frame = CGRectMake(0, 0, self.frame.size.width * [self.valor floatValue], self.frame.size.height);
            break;
        case BarraModoVertical:
            self.bar.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height  * [self.valor floatValue]);
            break;
    }
}

- (void)setValorAnimated:(NSNumber *)valor{
    [UIView animateWithDuration:kSpeed*[valor floatValue] animations:^{
        self.valor = valor;
    }];
}

- (void)setMode:(BarraModo)mode{
    _mode = mode;
    self.frame = self.frame;
    switch (self.mode) {
        case BarraModoHorizontal:
            self.bar.frame = CGRectMake(0, 0, 0, self.frame.size.height);
            break;
        case BarraModoVertical:
            self.bar.frame = CGRectMake(0, 0, self.frame.size.width, 0);
            break;
    }
}

@end
