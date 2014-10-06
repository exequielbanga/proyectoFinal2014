//
//  ResultadoRepeticionView.m
//  Aeda
//
//  Created by Jonathan Banga on 6/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "ResultadoRepeticionView.h"
#import "Barra.h"
#import "UIColor+ALColor.h"
#import "Ejercicio.h"

#define kXOffset 10
#define kBarraSize 30

@interface ResultadoRepeticionView()
@property (nonatomic,strong)UILabel *titulo;
@property (nonatomic,strong)UILabel *detalle;
@property (nonatomic,strong)Barra *barra;
@property (nonatomic,strong)UIButton *boton;

@end

@implementation ResultadoRepeticionView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.layer.cornerRadius = 20;
        self.layer.borderWidth = kXOffset/2;
        self.layer.borderColor = [[UIColor whiteColor] CGColor];
    
        self.backgroundColor = [[UIColor ALBlueColor] colorWithAlphaComponent:.95];
        self.modo = ResultadoRepeticionViewModoEjercicio;
        self.titulo = [[UILabel alloc] initWithFrame:CGRectMake(kXOffset, 0, self.frame.size.width - kXOffset*2, 44)];
        self.titulo.font = [UIFont systemFontOfSize:17];
        self.titulo.textColor = [UIColor whiteColor];
        [self addSubview:self.titulo];
        self.detalle = [[UILabel alloc] initWithFrame:CGRectMake(kBarraSize + kXOffset*2, self.titulo.frame.size.height, self.frame.size.width - kBarraSize - kXOffset*3, self.frame.size.height - self.titulo.frame.size.height)];
        self.detalle.numberOfLines = 0;
        self.detalle.textColor = [UIColor whiteColor];
        [self addSubview:self.detalle];
        self.barra = [[Barra alloc] initWithFrame:CGRectMake(kXOffset, self.titulo.frame.size.height - kXOffset, kBarraSize, self.frame.size.height - self.titulo.frame.size.height - kXOffset)];
        self.barra.mode = BarraModoVertical;
        self.barra.showsText = NO;
        [self addSubview:self.barra];
        
        self.boton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.boton.frame = self.bounds;
        [self.boton addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.boton];
    }
    return self;
}
- (void)setModo:(ResultadoRepeticionViewModo)modo{
    _modo = modo;
    [self updateViews];
}
- (void)setValor:(NSNumber *)valor{
    _valor = valor;
    [self updateViews];
}
- (void)setValorEsperado:(NSNumber *)valorEsperado{
    _valorEsperado = valorEsperado;
    [self updateViews];
}

- (void)updateViews{
    if (self.valor.intValue !=0 && self.valorEsperado.intValue !=0) {
        switch (self.modo) {
            case ResultadoRepeticionViewModoEjercicio:
                self.barra.tolerancia = 0;

                self.titulo.text = @"Repetición de ejercicio";
                if ([self.valor isEqual:self.valorEsperado]) {
                    self.detalle.text = [NSString stringWithFormat:@"¡Muy bien! Hiciste las %d repeticiones.",[self.valor intValue]];
                }else{
                    self.detalle.text = [NSString stringWithFormat:@"Hiciste %d repeticiones, cuando deberías haber hecho %d.",[self.valor intValue],[self.valorEsperado intValue]];
                }
                break;
            case ResultadoRepeticionViewModoTiempo:
                self.barra.tolerancia = kTolerancia;
                self.titulo.text = @"Tiempo de descanzo";
                if ([self.barra.valor isEqual:@1]) {
                    self.detalle.text = [NSString stringWithFormat:@"¡Muy bien! Descanzaste aproximadamente los %d segundos necesarios.",[self.valor intValue]];
                }else{
                    self.detalle.text = [NSString stringWithFormat:@"Descansaste %d segundos, cuando deberías haber descansado %d.",[self.valor intValue],[self.valorEsperado intValue]];
                }
                break;
        }
        if (self.valorEsperado.intValue >= self.valor.intValue) {
            self.barra.valor = @(self.valor.floatValue / self.valorEsperado.floatValue);
            self.barra.resaltar = NO;
        }else{
            self.barra.valor = @(self.valorEsperado.floatValue / self.valor.floatValue);
            self.barra.resaltar = YES;
            [self.barra setValorAnimated:self.barra.valor];
        }
    }
}

- (void)exit{
    [UIView animateWithDuration:.3 animations:^{
        self.alpha = 0;
    }completion:^(BOOL completition){
        [self removeFromSuperview];
        self.alpha = 1;
    }];
}

@end
