//
//  ResultadoRutina.m
//  Aeda
//
//  Created by Jonathan Banga on 5/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "ResultadoRutina.h"
#import "Rutina.h"
#import "Ejercicio.h"

@implementation ResultadoRutina

- (instancetype)initMock{
    self = [self init];
    if (self) {
        self.rutina = [[Rutina alloc] initMock];
        
        self.resultado = .6 + (arc4random()%40)/100.0;
        
        self.detalleResultados = [NSMutableDictionary new];
        for (Ejercicio *ejercicio in self.rutina.ejercicios) {
            NSMutableArray *resultados = [NSMutableArray new];
            for (NSInteger i = 0; i < ejercicio.repeticiones.count; i++) {
                [resultados addObject:@(80+arc4random()%20)];
            }
        }
    }
    return self;
}


@end
