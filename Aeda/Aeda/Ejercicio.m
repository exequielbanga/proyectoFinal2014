//
//  Ejercicio.m
//  Aeda
//
//  Created by Jonathan Banga on 5/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "Ejercicio.h"
#import "ResultadoEjercicio.h"

@implementation Ejercicio

- (NSDictionary *)mappingDictionary{
    return @{
             @"descripcion":@"detalle",
             @"id":@"idEjercicio",
             @"HistorialEjercicios":@"historialEjerciciosFromArray",
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

- (void)setHistorialEjerciciosFromArray:(NSArray *)array{
    self.historialEjercicios = [NSMutableArray new];
    for (NSDictionary *dict in array) {
        ResultadoEjercicio *resultado = [[ResultadoEjercicio alloc]initWithDictionary:dict];
        resultado.idEjercicio = self.idEjercicio;
        [self.historialEjercicios addObject:resultado];
    }
}

- (void)setIdEjercicio:(NSString *)idEjercicio{
    _idEjercicio = idEjercicio;
    for (ResultadoEjercicio *resultado in self.historialEjercicios) {
        resultado.idEjercicio = self.idEjercicio;
    }
}

@end
