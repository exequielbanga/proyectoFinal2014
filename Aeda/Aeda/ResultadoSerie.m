//
//  ResultadoEjercicio.m
//  Aeda
//
//  Created by Jonathan Banga on 6/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "ResultadoSerie.h"

@implementation ResultadoSerie

- (NSDictionary *)mappingDictionary{
    return @{
             @"id":@"idEjercicio",
             @"fecha_inicio":@"fecha",
             @"tiempo_ejercicio":@"tiempoEjercicio",
             @"tiempo_pausa":@"tiempoPausa",
             };
}

- (instancetype)initWithEjercicio:(Ejercicio *)ejercicio{
    self = [self init];
    if (self) {
        self.ejercicio = ejercicio;
        self.idEjercicio = [ejercicio.idEjercicio copy];
    }
    return self;
}

@end
