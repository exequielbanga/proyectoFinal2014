//
//  ResultadoEjercicioView.m
//  Aeda
//
//  Created by Jonathan Banga on 6/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "ResultadoEjercicioView.h"
#import "ResultadoRepeticionView.h"
#import "Barra.h"

#define kXOffset 10
#define kYOffset 5
#define kBarraSize 40
#define kIconoSize 25


@interface ResultadoEjercicioView()<BarraDelegate>
@property (nonatomic,strong) UILabel *titulo;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UILabel *completado;
@property (nonatomic,strong) NSMutableArray *ejercicios;
@property (nonatomic,strong) NSMutableArray *ejerciciosOriginales;
@property (nonatomic,strong) NSMutableArray *tiempos;
@property (nonatomic,strong) NSMutableArray *tiemposOriginales;
@end

@implementation ResultadoEjercicioView
- (void)internalInitialization{
    self.backgroundColor = [UIColor clearColor];
    
    self.titulo = [[UILabel alloc] initWithFrame:CGRectMake(kXOffset, 0, self.frame.size.width - kXOffset*2, 44)];
    self.titulo.font = [UIFont boldSystemFontOfSize:17];
    self.titulo.textColor = [UIColor whiteColor];
    [self addSubview:self.titulo];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.titulo.frame.origin.y + self.titulo.frame.size.height, self.frame.size.width, self.frame.size.height - (self.titulo.frame.origin.y + self.titulo.frame.size.height))];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    
    self.completado = [[UILabel alloc] initWithFrame:CGRectMake(kXOffset, self.scrollView.frame.size.height - 20, self.frame.size.width, 20)];
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

//- (void)fillWithResultadoEjercicio:(ResultadoEjercicio *)resultadoEjercicio{
//    self.titulo.text = resultadoEjercicio.nombre;
//    
//
//    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    [self.scrollView addSubview:self.completado];
//
//    CGFloat xOffset = self.completado.frame.size.width + kXOffset*2;
//    
//    NSUInteger tag = 0;
//    
//    self.ejercicios = [NSMutableArray new];
//    self.ejerciciosOriginales = [NSMutableArray new];
//    self.tiempos = [NSMutableArray new];
//    self.tiemposOriginales = [NSMutableArray new];
//    
//    for (NSInteger i = 0; i < resultadoEjercicio.resultadoRepeticiones.count; i++) {
//        NSNumber *repeticion = resultadoEjercicio.resultadoRepeticiones[i];
//        NSNumber *repeticionOriginal = resultadoEjercicio.repeticiones[i];
//        [self.ejercicios addObject:repeticion];
//        [self.ejerciciosOriginales addObject:repeticionOriginal];
//        
//        //Creo la barra del ejercicio
//        //Icono
//        UIImageView *icono;
//        if ([[[UIDevice currentDevice] systemVersion] floatValue] > 7) {
//            icono = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"Mis_Rutinas"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
//            icono.tintColor = [UIColor whiteColor];
//        }else{
//            icono = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Mis_Rutinas"]];
//        }
//        icono.contentMode = UIViewContentModeScaleAspectFit;
//        icono.frame = CGRectMake(xOffset + (kBarraSize - kIconoSize)/2, 0, kIconoSize, kIconoSize);
//        [self.scrollView addSubview:icono];
//
//        //Barra
//        Barra *barra = [[Barra alloc]initWithFrame:CGRectMake(xOffset, icono.frame.size.height + kYOffset, kBarraSize, self.scrollView.frame.size.height - icono.frame.size.height - kYOffset)];
//        barra.tag = tag;
//        tag ++;
//        barra.mode = BarraModoVertical;
//        barra.delegate = self;
//        if (repeticion.integerValue < repeticionOriginal.integerValue) {
//            [barra setValorAnimated:@([repeticion floatValue]/[repeticionOriginal floatValue])];
//        }else{
//            [barra setValorAnimated:@([repeticionOriginal floatValue]/[repeticion floatValue])];
//        }
//        barra.showsText = NO;
//        barra.text = [NSString stringWithFormat:@"%d/%d",[repeticion intValue],[repeticionOriginal intValue]];
//        [self.scrollView addSubview:barra];
//
//        //Actualizo el offset
//        xOffset = barra.frame.origin.x + barra.frame.size.width + kXOffset;
//        
//        //Si no es la última barra agrego tiempo de reposo
//        if (i < resultadoEjercicio.resultadoTiemposEntreRepeticiones.count) {
//            NSNumber *pausa = resultadoEjercicio.resultadoTiemposEntreRepeticiones[i];
//            NSNumber *pausaOriginal = resultadoEjercicio.tiemposEntreRepeticiones[i];
//            
//            [self.tiempos addObject:pausa];
//            [self.tiemposOriginales addObject:pausaOriginal];
//
//            //Icono
//            UIImageView *icono;
//            if ([[[UIDevice currentDevice] systemVersion] floatValue] > 7) {
//                icono = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"clock"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
//                icono.tintColor = [UIColor whiteColor];
//            }else{
//                icono = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"clock"]];
//            }
//            icono.contentMode = UIViewContentModeScaleAspectFit;
//            icono.frame = CGRectMake(xOffset + (kBarraSize - kIconoSize)/2, 0, kIconoSize, kIconoSize);
//            [self.scrollView addSubview:icono];
//
//            //Barra
//            Barra *barraPausa = [[Barra alloc]initWithFrame:CGRectMake(xOffset, icono.frame.size.height + kYOffset, kBarraSize,  self.scrollView.frame.size.height - icono.frame.size.height - kYOffset)];
//            barraPausa.tag = tag;
//            tag ++;
//            barraPausa.showsText = NO;
//            barraPausa.tolerancia = kTolerancia;
//            barraPausa.mode = BarraModoVertical;
//            barraPausa.delegate = self;
//            if (pausa.integerValue < pausaOriginal.floatValue) {
//                [barraPausa setValorAnimated:@([pausa floatValue]/[pausaOriginal floatValue])];
//            }else{
//                [barraPausa setValorAnimated:@([pausaOriginal floatValue]/[pausa floatValue])];
//                barraPausa.resaltar = YES;
//            }
//            barraPausa.text = [NSString stringWithFormat:@"%d/%d",[pausa intValue],[pausaOriginal intValue]];
//            [self.scrollView addSubview:barraPausa];
//            xOffset = barraPausa.frame.origin.x + barraPausa.frame.size.width + kXOffset;
//        }
//    }
//    self.scrollView.contentSize = CGSizeMake(xOffset, 0);
//}

- (void)mostrarDetalleValor:(NSNumber *)valor esperado:(NSNumber *)valorEsperado modo:(ResultadoRepeticionViewModo)modo{
    ResultadoRepeticionView *view = [[ResultadoRepeticionView alloc] initWithFrame:CGRectMake(0, kYOffset, self.frame.size.width, self.frame.size.height - kYOffset*2)];
    view.valor = valor;
    view.valorEsperado = valorEsperado;
    view.modo = modo;
    [self addSubview:view];
}

#pragma Barra Delegate
- (void)barraWasTapped:(Barra *)barra{
    
    NSNumber *valor;
    NSNumber *valorOriginal;
    if (barra.tag%2) {// Tiempo
        valor = self.tiempos[(barra.tag/2)];
        valorOriginal = self.tiemposOriginales[(barra.tag/2)];
    }else{//Ejercicio
        valor = self.ejercicios[(barra.tag/2)];
        valorOriginal = self.ejerciciosOriginales[(barra.tag/2)];
    }
    [self mostrarDetalleValor:valor esperado:valorOriginal modo:barra.tag%2];
}

@end
