//
//  ResultadoEjercicioView.m
//  Aeda
//
//  Created by Jonathan Banga on 6/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "ResultadoEjercicioView.h"
#import "Barra.h"

#define kOffset 5
#define kBarraSize 40
#define kTextoDetalleHeight 20


@interface ResultadoEjercicioView()
@property (nonatomic,strong) UILabel *titulo;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UILabel *completado;
@end

@implementation ResultadoEjercicioView
- (void)internalInitialization{
    self.backgroundColor = [UIColor clearColor];
    
    self.titulo = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
    self.titulo.font = [UIFont boldSystemFontOfSize:17];
    self.titulo.textColor = [UIColor whiteColor];
    [self addSubview:self.titulo];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.titulo.frame.origin.y + self.titulo.frame.size.height + kOffset, self.frame.size.width, self.frame.size.height - (self.titulo.frame.origin.y + self.titulo.frame.size.height + kOffset))];
    [self addSubview:self.scrollView];
    self.scrollView.backgroundColor = [UIColor orangeColor];
    
    self.completado = [[UILabel alloc] initWithFrame:CGRectMake(0, self.scrollView.frame.size.height - kTextoDetalleHeight, self.frame.size.width, kTextoDetalleHeight)];
    self.completado.textColor = [UIColor whiteColor];
    self.completado.backgroundColor = [UIColor redColor];
    self.completado.text = @"Completado:";
    [self.completado sizeToFit];
    [self.scrollView addSubview:self.completado];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self internalInitialization];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self internalInitialization];
    }
    return self;
}

- (void)fillWithResultadoEjercicio:(ResultadoEjercicio *)resultadoEjercicio{
    self.titulo.text = resultadoEjercicio.nombre;
    

    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.scrollView addSubview:self.completado];

    CGFloat xOffset = self.completado.frame.size.width + kOffset;
    for (NSInteger i = 0; i < resultadoEjercicio.resultadoRepeticiones.count; i++) {
        NSNumber *repeticion = resultadoEjercicio.resultadoRepeticiones[i];
        NSNumber *repeticionOriginal = resultadoEjercicio.repeticiones[i];
        
        //Creo la barra del ejercicio
        Barra *barra = [[Barra alloc]initWithFrame:CGRectMake(xOffset, 0, kBarraSize, self.scrollView.frame.size.height - kTextoDetalleHeight - kOffset)];
        barra.mode = BarraModoVertical;
        barra.showsPercent = NO;
        [barra setValorAnimated:@([repeticion floatValue]/[repeticionOriginal floatValue])];
        [self.scrollView addSubview:barra];

        //Actualizo el offset
        xOffset = barra.frame.origin.x + barra.frame.size.width + kOffset;
        
        //Si no es la última barra agrego tiempo de reposo
        if (i < resultadoEjercicio.resultadoTiemposEntreRepeticiones.count) {
            NSNumber *pausa = resultadoEjercicio.resultadoTiemposEntreRepeticiones[i];
            NSNumber *pausaOriginal = resultadoEjercicio.tiemposEntreRepeticiones[i];
            
            Barra *barraPausa = [[Barra alloc]initWithFrame:CGRectMake(xOffset, 0, kBarraSize,  self.scrollView.frame.size.height - kTextoDetalleHeight - kOffset)];
            barraPausa.mode = BarraModoVertical;
            barraPausa.showsPercent = NO;
            [barraPausa setValorAnimated:@([pausa floatValue]/[pausaOriginal floatValue])];
            [self.scrollView addSubview:barraPausa];
            xOffset = barraPausa.frame.origin.x + barraPausa.frame.size.width + kOffset;
        }
    }
    self.scrollView.contentSize = CGSizeMake(xOffset, 0);
}

@end
