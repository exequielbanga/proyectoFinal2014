//
//  ResultadoRutina.m
//  Aeda
//
//  Created by Jonathan Banga on 5/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "ResultadoRutina.h"
#import "Rutina.h"
#import "ResultadoEjercicio.h"

@implementation ResultadoRutina

- (instancetype)initMock{
    self = [super initMock];
    if (self) {
        self.resultado = (arc4random()%100)/100.0;
        
        self.resultadoEjercicios = [NSMutableArray new];
        for (NSInteger i = 0; i < self.ejercicios.count; i++) {
            [self.resultadoEjercicios addObject:[[ResultadoEjercicio alloc]initMock]];
        }
    }
    return self;
}


@end
