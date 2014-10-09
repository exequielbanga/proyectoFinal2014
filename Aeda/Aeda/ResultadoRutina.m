//
//  ResultadoRutina.m
//  Aeda
//
//  Created by Jonathan Banga on 5/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "ResultadoRutina.h"
#import "ResultadoEjercicio.h"

@implementation ResultadoRutina


- (instancetype)init{
    self = [super init];
    if (self) {
        self.resultadoEjercicios = [NSMutableArray new];
    }
    return self;
}

- (instancetype)initMock{
    self = [super initMock];
    if (self) {
        self.resultado = (arc4random()%100)/100.0;
        
        self.resultadoEjercicios = [NSMutableArray new];
        for (NSInteger i = 0; i < self.ejercicios.count; i++) {
            [self.resultadoEjercicios addObject:[[ResultadoEjercicio alloc]initMock]];
        }
    }
    return self;
}

- (instancetype)initWithRutina:(Rutina *)rutina{
    self = [self init];
    if (self) {
        self.nombre = [rutina.nombre copy];
        self.detalle = [rutina.detalle copy];
        self.detalleCorto = [rutina.detalleCorto copy];
        self.ejercicios = [rutina.ejercicios copy];
        self.fechas = [rutina.fechas copy];
        self.sesion = [rutina.sesion copy];
        self.resultado = 0;
        
        for (Ejercicio *ejercicio in self.ejercicios) {
            ResultadoEjercicio *resultadoEjercicio = [[ResultadoEjercicio alloc] initWithEjercicio:ejercicio];
            [self.resultadoEjercicios addObject:resultadoEjercicio];
        }
    }
    return self;
}


@end
