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
@property(nonatomic,strong)UILabel*label;
@end

@implementation Barra

- (void)internalInit{
    self.showsPercent = YES;
    self.backgroundColor = [UIColor colorWithWhite:1 alpha:.15];
    self.bar = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:self.bar];
    self.mode = BarraModoHorizontal;
    
    self.label = [[UILabel alloc] initWithFrame:self.bounds];
    self.label.minimumScaleFactor = .5;
    self.label.font = [UIFont systemFontOfSize:14];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.alpha = 0;
    [self addSubview:self.label];
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
            self.layer.cornerRadius = self.frame.size.height*kRadiusPercentage;
            break;
        case BarraModoVertical:
            self.bar.layer.cornerRadius = self.frame.size.width*kRadiusPercentage;
            self.layer.cornerRadius = self.frame.size.width*kRadiusPercentage;
            break;
    }
}

- (void)setShowsPercent:(BOOL)showsPercent{
    _showsPercent = showsPercent;
    self.valor = self.valor;
}
- (void)setPercentText:(NSString *)percentText{
    _percentText = percentText;
    self.valor = self.valor;
}

- (void)setValor:(NSNumber *)valor{
    _valor = valor;
    self.bar.backgroundColor = [UIColor colorWithRed:1-[valor floatValue] green:[valor floatValue] blue:0 alpha:1];
    switch (self.mode) {
        case BarraModoHorizontal:
            self.bar.frame = CGRectMake(0, 0, self.frame.size.width * [self.valor floatValue], self.frame.size.height);
            self.label.frame = CGRectMake(5, 0, self.frame.size.width, self.frame.size.height);
            break;
        case BarraModoVertical:
            self.bar.frame = CGRectMake(0, self.frame.size.height - (self.frame.size.height  * [self.valor floatValue]), self.frame.size.width, self.frame.size.height  * [self.valor floatValue]);
            self.label.frame = CGRectMake(0,self.frame.size.height - 25,self.frame.size.width,25);
            break;
    }

    if (self.percentText) {
        self.label.text = self.percentText;
    }else{
        self.label.text = [NSString stringWithFormat:@"%2.0f%%",[self.valor floatValue]*100];
    }
    self.label.alpha = self.showsPercent?1:0;
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
