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
@property(nonatomic,strong)UIButton *boton;
@end

@implementation Barra

- (void)internalInit{
    self.tolerancia = 0;
    self.clipsToBounds = YES;
    self.showsText = YES;
    self.resaltar = NO;
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
    
    self.boton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.boton addTarget:self action:@selector(touch) forControlEvents:UIControlEventTouchUpInside];
    self.boton.frame = self.bounds;
}

- (void)setDelegate:(id<BarraDelegate>)delegate{
    _delegate = delegate;
    if (self.delegate) {
        [self addSubview:self.boton];
    }else{
        [self.boton removeFromSuperview];
    }
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

- (void)setShowsText:(BOOL)showsText{
    _showsText = showsText;
    [self updateViews];
}
- (void)setText:(NSString *)text{
    _text = text;
    [self updateViews];
}

- (void)setResaltar:(BOOL)resaltar{
    _resaltar = resaltar;
    [self updateViews];
}

- (void)setValor:(NSNumber *)valor{
    if (fabs(1.0-valor.floatValue)<= self.tolerancia) {
        _valor = @1;
    }else{
        _valor = valor;
    }
    [self updateViews];
}

- (void)setValorAnimated:(NSNumber *)valor{
    [UIView animateWithDuration:kSpeed*[valor floatValue] animations:^{
        self.valor = valor;
    }completion:^(BOOL completed){
        if (self.resaltar) {
            self.backgroundColor = [UIColor redColor];
        }else{
            self.backgroundColor = [UIColor colorWithWhite:1 alpha:.15];
        }
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
            self.bar.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, 0);
            break;
    }
}

- (void)updateViews{
    self.bar.backgroundColor = [UIColor colorWithRed:1-[self.valor floatValue] green:[self.valor floatValue] blue:0 alpha:1];
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
    
    if (self.text) {
        self.label.text = self.text;
    }else{
        self.label.text = [NSString stringWithFormat:@"%2.0f%%",[self.valor floatValue]*100];
    }
    self.label.alpha = self.showsText?1:0;
}

- (void)touch{
    [self.delegate barraWasTapped:self];
}

@end
