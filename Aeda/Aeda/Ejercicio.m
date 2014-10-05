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
        self.detalle = @"Agarrá una pesa y hacete macho";
        self.repeticiones = [[NSArray alloc] initWithObjects:@15,@15,@12, nil];
        self.tiemposEntreRepeticiones = [[NSArray alloc] initWithObjects:@30,@30, nil];
        self.pesos = [[NSArray alloc] initWithObjects:@2,@2,@3, nil];
    }
    return self;
}

@end
