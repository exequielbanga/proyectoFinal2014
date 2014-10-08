//
//  Rutina.m
//  Aeda
//
//  Created by Jonathan Banga on 5/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "Rutina.h"
#import "Ejercicio.h"

@implementation Rutina

- (instancetype)initMock{
    self = [self init];
    if (self) {
        switch (arc4random()%5) {
            case 0:
                self.nombre = @"Brazos Inicial";
                break;
            case 1:
                self.nombre = @"Abdominales Intermedio";
                break;
            case 2:
                self.nombre = @"Aeróbico";
                break;
            case 3:
                self.nombre = @"Piernas";
                break;
            case 4:
                self.nombre = @"Boxeo";
                break;
        }
        
        self.sesion = [[SesionRutina alloc] initMock];
        
        self.detalle = @"Esta rutina es ideal para comenzar a trabajar los músculos de ambos brazos. Se recomienda realizarla como máximo dos veces a la semana.";
        self.detalleCorto = @"Esta rutina es ideal para comenzar a trabajar los músculos de ambos brazos.";
        NSMutableArray *ejercicios = [NSMutableArray new];

        Ejercicio *ej1 = [[Ejercicio alloc] initMock];
        [ejercicios addObject:ej1];

        Ejercicio *ej2 = [[Ejercicio alloc] initMock];
        ej2.nombre = @"Tríceps";
        [ejercicios addObject:ej2];

        Ejercicio *ej3 = [[Ejercicio alloc] initMock];
        ej3.nombre = @"Patada de Burro";
        [ejercicios addObject:ej3];
        
        self.ejercicios = ejercicios;
    }
    return self;
}

- (id)copyWithZone:(NSZone*)aZone {
    Rutina* rutina = [[[self class] allocWithZone:aZone] init];
    rutina.nombre = [self.nombre copy];
    rutina.detalle = [self.detalle copy];
    rutina.detalleCorto = [self.detalleCorto copy];
    rutina.ejercicios = [self.ejercicios copy];
    rutina.fechas = [self.fechas copy];
    rutina.sesion = [self.sesion copy];

    return rutina;
}

@end
