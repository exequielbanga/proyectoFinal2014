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

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super initWithDictionary:dictionary];
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.resultadoEjercicios = [NSMutableArray new];
    }
    return self;
}

- (instancetype)initWithRutina:(Rutina *)rutina{
    self = [self init];
    if (self) {
        self.rutinaId = [rutina.rutinaId copy];
        self.nombre = [rutina.nombre copy];
        self.detalle = [rutina.detalle copy];
        self.detalleCorto = [rutina.detalleCorto copy];
        self.ejercicios = [rutina.ejercicios copy];
        self.usuarioRutinas = [rutina.usuarioRutinas copy];
//        self.fechas = [rutina.fechas copy];
//        self.sesion = [rutina.sesion copy];
        self.resultado = 0;
        
        for (Ejercicio *ejercicio in self.ejercicios) {
            ResultadoEjercicio *resultadoEjercicio = [[ResultadoEjercicio alloc] initWithEjercicio:ejercicio];
            [self.resultadoEjercicios addObject:resultadoEjercicio];
        }
    }
    return self;
}

- (NSComparisonResult)compare:(ResultadoRutina *)otraRutina{
    NSComparisonResult result;
    switch ([self.fecha compare:otraRutina.fecha]) {
        case NSOrderedAscending:
            result = NSOrderedDescending;
            break;
        case NSOrderedDescending:
            result = NSOrderedAscending;
            break;
        default:
            result = NSOrderedSame;
            break;
    }
    return result;
}


@end
