//
//  EstadoPersona.m
//  Aeda
//
//  Created by Jonathan Banga on 10/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "EstadoPersona.h"

@implementation EstadoPersona

- (instancetype)initMock{
    self = [self init];
    if (self) {
        self.fuerza = @((arc4random()%100)/100.0);
        self.resistencia = @((arc4random()%100)/100.0);
        self.flexibilidad = @((arc4random()%100)/100.0);
        self.objetivo = @((self.fuerza.floatValue + self.resistencia.floatValue + self.flexibilidad.floatValue)/4.0);
        self.detalleObjetivo = @"• Bajar 5Kg\n• Tonificar Músculos en general\n• Ganar Resistencia para correr 12.5K";
    }
    return self;
}

@end
