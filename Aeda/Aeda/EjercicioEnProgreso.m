//
//  EjercicioEnProgreso.m
//  Aeda
//
//  Created by Jonathan Banga on 22/2/15.
//  Copyright (c) 2015 Solbest. All rights reserved.
//

#import "EjercicioEnProgreso.h"

@implementation EjercicioEnProgreso

- (instancetype)initWithEjercicio:(Ejercicio *)ejercicio{
    self = [super init];
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
