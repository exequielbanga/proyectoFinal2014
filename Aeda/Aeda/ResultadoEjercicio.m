//
//  ResultadoEjercicio.m
//  Aeda
//
//  Created by Jonathan Banga on 6/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "ResultadoEjercicio.h"

@implementation ResultadoEjercicio

- (instancetype)init{
    self = [super init];
    if (self) {
        self.completado = NO;
        self.resultadoRepeticiones = [NSMutableArray new];
        self.resultadoTiemposEntreRepeticiones = [NSMutableArray new];
        self.resultadoPesos = [NSMutableArray new];
    }
    return self;
}

- (instancetype)initMock{
    self = [super initMock];
    if (self) {
        self.resultadoTiempo = 323;
        self.resultadoRepeticiones = [[NSMutableArray alloc] initWithObjects:@15,@12,@8, nil];
        self.resultadoTiemposEntreRepeticiones = [[NSMutableArray alloc] initWithObjects:@34,@49, nil];
        self.resultadoPesos = [[NSMutableArray alloc] initWithObjects:@2,@2,@3, nil];
    }
    return self;
}

- (instancetype)initWithEjercicio:(Ejercicio *)ejercicio{
    self = [self init];
    if (self) {
        self.nombre = [ejercicio.nombre copy];
        self.detalle = [ejercicio.detalle copy];
        self.tiempo = ejercicio.tiempo;
        self.repeticiones = [ejercicio.repeticiones copy];
        self.tiemposEntreRepeticiones = [ejercicio.tiemposEntreRepeticiones copy];
        self.pesos = [ejercicio.pesos copy];
    }
    return self;
}

@end
