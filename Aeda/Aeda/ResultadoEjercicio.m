//
//  ResultadoEjercicio.m
//  Aeda
//
//  Created by Jonathan Banga on 6/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "ResultadoEjercicio.h"

@implementation ResultadoEjercicio

- (instancetype)initMock{
    self = [super initMock];
    if (self) {
        self.resultadoTiempo = 323;
        self.resultadoRepeticiones = [[NSArray alloc] initWithObjects:@15,@12,@8, nil];
        self.resultadoTiemposEntreRepeticiones = [[NSArray alloc] initWithObjects:@34,@49, nil];
        self.resultadoPesos = [[NSArray alloc] initWithObjects:@2,@2,@3, nil];
    }
    return self;
}

@end
