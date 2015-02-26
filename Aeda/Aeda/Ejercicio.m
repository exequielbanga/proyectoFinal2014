//
//  Ejercicio.m
//  Aeda
//
//  Created by Jonathan Banga on 5/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "Ejercicio.h"
#import "ResultadoSerie.h"

@implementation Ejercicio

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.completado = NO;
    }
    return self;
}

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

    NSMutableArray *pausas = [NSMutableArray arrayWithCapacity:[ejercicioRutina[@"series"]integerValue]-1];
    for (NSInteger i = 1; i < [ejercicioRutina[@"series"]integerValue]; i++) {
//TOTO        [pausas addObject:@([ejercicioRutina[@"tiempo_pausa"]integerValue])];
        [pausas addObject:@(3)];
    }
    self.tiemposEntreRepeticiones = [NSArray arrayWithArray:pausas];
}

- (void)setHistorialEjerciciosFromArray:(NSArray *)array{
    self.historialEjercicios = [NSMutableArray new];
    for (NSDictionary *dict in array) {
        ResultadoSerie *resultado = [[ResultadoSerie alloc]initWithDictionary:dict];
        resultado.idEjercicio = self.idEjercicio;
        [self.historialEjercicios addObject:resultado];
    }
}

- (void)setIdEjercicio:(NSString *)idEjercicio{
    _idEjercicio = idEjercicio;
    for (ResultadoSerie *resultado in self.historialEjercicios) {
        resultado.idEjercicio = self.idEjercicio;
    }
}

@end
