//
//  ResultadoEjercicioView.m
//  Aeda
//
//  Created by Jonathan Banga on 6/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "ResultadoEjercicioView.h"
#import "Barra.h"

#define kOffset 10
#define kBarraSize 40


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
    
    self.completado = [[UILabel alloc] initWithFrame:CGRectMake(0, self.scrollView.frame.size.height - 20, self.frame.size.width, 20)];
    self.completado.textColor = [UIColor whiteColor];
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
        Barra *barra = [[Barra alloc]initWithFrame:CGRectMake(xOffset, 0, kBarraSize, self.scrollView.frame.size.height)];
        barra.mode = BarraModoVertical;
        
        if (repeticion.integerValue < repeticionOriginal.integerValue) {
            [barra setValorAnimated:@([repeticion floatValue]/[repeticionOriginal floatValue])];
        }else{
            [barra setValorAnimated:@([repeticionOriginal floatValue]/[repeticion floatValue])];
        }
        
        barra.percentText = [NSString stringWithFormat:@"%d/%d",[repeticion intValue],[repeticionOriginal intValue]];
        [self.scrollView addSubview:barra];

        //Actualizo el offset
        xOffset = barra.frame.origin.x + barra.frame.size.width + kOffset;
        
        //Si no es la última barra agrego tiempo de reposo
        if (i < resultadoEjercicio.resultadoTiemposEntreRepeticiones.count) {
            NSNumber *pausa = resultadoEjercicio.resultadoTiemposEntreRepeticiones[i];
            NSNumber *pausaOriginal = resultadoEjercicio.tiemposEntreRepeticiones[i];
            
            Barra *barraPausa = [[Barra alloc]initWithFrame:CGRectMake(xOffset, 0, kBarraSize,  self.scrollView.frame.size.height)];
            barraPausa.mode = BarraModoVertical;
            if (pausa.integerValue < pausaOriginal.floatValue) {
                [barraPausa setValorAnimated:@([pausa floatValue]/[pausaOriginal floatValue])];
            }else{
                [barraPausa setValorAnimated:@([pausaOriginal floatValue]/[pausa floatValue])];
            }
            barraPausa.percentText = [NSString stringWithFormat:@"%d/%d",[pausa intValue],[pausaOriginal intValue]];
            [self.scrollView addSubview:barraPausa];
            xOffset = barraPausa.frame.origin.x + barraPausa.frame.size.width + kOffset;
        }
    }
    self.scrollView.contentSize = CGSizeMake(xOffset, 0);
}

@end
