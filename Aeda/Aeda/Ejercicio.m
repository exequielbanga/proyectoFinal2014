//
//  Ejercicio.m
//  Aeda
//
//  Created by Jonathan Banga on 5/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "Ejercicio.h"

@implementation Ejercicio

- (NSDictionary *)mappingDictionary{
    return @{
             @"descripcion":@"detalle",
             };
}

- (void)setEjercicioRutina:(NSDictionary *)ejercicioRutina{
    NSMutableArray *repeticiones = [NSMutableArray arrayWithCapacity:[ejercicioRutina[@"series"]integerValue]];
    for (NSInteger i = 0; i < [ejercicioRutina[@"series"]integerValue]; i++) {
        [repeticiones addObject:@([ejercicioRutina[@"repeticiones"]integerValue])];
    }
    self.repeticiones = [NSArray arrayWithArray:repeticiones];

    NSMutableArray *pausas = [NSMutableArray arrayWithCapacity:[ejercicioRutina[@"series"]integerValue]];
    for (NSInteger i = 0; i < [ejercicioRutina[@"series"]integerValue]; i++) {
        [pausas addObject:@([ejercicioRutina[@"tiempo_pausa"]integerValue])];
    }
    self.tiemposEntreRepeticiones = [NSArray arrayWithArray:pausas];
}


@end
