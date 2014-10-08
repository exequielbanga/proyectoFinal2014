//
//  Ejercicio.m
//  Aeda
//
//  Created by Jonathan Banga on 5/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "Ejercicio.h"

@implementation Ejercicio

- (instancetype)initMock{
    self = [self init];
    if (self) {
        self.nombre = @"Bíceps Mancuerna";
        self.detalle = @"Agarrá una pesa y hacete macho. Luego, una vez vencido el temor al fracaso, comenzarás a realizar el ejercicio como los grandes maestros de las mancuernas. Una y otra vez hasta que te sangren los músculos.";
        self.repeticiones = [[NSArray alloc] initWithObjects:@15,@15,@12, nil];
        self.tiemposEntreRepeticiones = [[NSArray alloc] initWithObjects:@30,@30, nil];
        self.pesos = [[NSArray alloc] initWithObjects:@2,@2,@3, nil];
        self.tiempo = 300;
    }
    return self;
}

- (id)copyWithZone:(NSZone*)aZone {
    Ejercicio* ejercicio = [[[self class] allocWithZone:aZone] init];
    ejercicio.nombre = [self.nombre copy];
    ejercicio.detalle = [self.detalle copy];
    ejercicio.repeticiones = [self.repeticiones copy];
    ejercicio.tiemposEntreRepeticiones = [self.tiemposEntreRepeticiones copy];
    ejercicio.pesos = [self.pesos copy];
    ejercicio.tiempo = self.tiempo;
    
    return ejercicio;
}

@end
