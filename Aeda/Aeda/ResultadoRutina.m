//
//  ResultadoRutina.m
//  Aeda
//
//  Created by Jonathan Banga on 5/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "ResultadoRutina.h"
#import "ResultadoSerie.h"
#import "ResultadoEjercicio.h"

@implementation ResultadoRutina

- (NSDictionary *)mappingDictionary{
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    [dictionary addEntriesFromDictionary:[super mappingDictionary]];
    [dictionary addEntriesFromDictionary:@{
                                           @"Ejercicios":@"ejerciciosFromArray",
                                           @"fecha":@"fechaFromString"
                                           }];
    return dictionary;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super initWithDictionary:dictionary];
    
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.ejercicios = [NSMutableArray new];
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
        self.usuarioRutinas = [rutina.usuarioRutinas copy];
        self.resultado = 0;
        
        self.ejercicios = [[rutina ejercicios]copy];
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

- (void)setEjerciciosFromArray:(NSArray *)array{
    self.ejercicios = [NSMutableArray new];
    for (NSDictionary *dict in array) {
        [self.ejercicios addObject:[[Ejercicio alloc]initWithDictionary:dict]];
    }
}

- (void)setFechaFromString:(NSString *)string{
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"YYYY-MM-dd";
    self.fecha = [formatter dateFromString:string];
}

- (CGFloat)resultado{
    CGFloat resultadoMaximo = 0;
    for (Ejercicio *ejercicio in self.ejercicios) {
        CGFloat resultadoEjercicio = 0;
        for (NSNumber *repeticion in ejercicio.repeticiones) {
            resultadoEjercicio += [repeticion floatValue];
        }
        resultadoMaximo += resultadoEjercicio;
    }
    
    CGFloat resultadoReal = 0;
    for (Ejercicio *ejercicio in self.ejercicios) {
        ResultadoEjercicio *resultadoEjercicio = [[ResultadoEjercicio alloc] initWithEjercicio:ejercicio];
        CGFloat resultadoSeries = 0;
        for (NSNumber *repeticion in resultadoEjercicio.resultadoRepeticiones) {
            resultadoSeries += [repeticion floatValue];
        }
        resultadoReal += resultadoSeries;
    }
    return resultadoReal/resultadoMaximo;
}

@end
