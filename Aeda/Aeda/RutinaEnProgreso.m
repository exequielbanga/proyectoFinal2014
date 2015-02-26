//
//  RutinaEnProgreso.m
//  Aeda
//
//  Created by Jonathan Banga on 24/2/15.
//  Copyright (c) 2015 Solbest. All rights reserved.
//

#import "RutinaEnProgreso.h"
#import "ResultadoSerie.h"

@implementation RutinaEnProgreso

- (instancetype)initWithRutina:(Rutina *)rutina{
    self = [self init];
    if (self) {
        self.rutinaId = [rutina.rutinaId copy];
        self.nombre = [rutina.nombre copy];
        self.detalle = [rutina.detalle copy];
        self.detalleCorto = [rutina.detalleCorto copy];
        self.ejercicios = [rutina.ejercicios copy];
        self.usuarioRutinas = [rutina.usuarioRutinas copy];
        self.usuarioRutinas = [rutina.usuarioRutinas copy];
        
        for (Ejercicio *ejercicio in self.ejercicios) {
            ResultadoSerie *resultadoEjercicio = [[ResultadoSerie alloc] initWithEjercicio:ejercicio];
            [self.ejercicios addObject:resultadoEjercicio];
        }
    }
    return self;
}

@end
