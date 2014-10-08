//
//  SesionRutina.m
//  Aeda
//
//  Created by Jonathan Banga on 7/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "SesionRutina.h"

@implementation SesionRutina

- (instancetype)initWithDictionary{
    self = [self init];
    return self;
}

- (instancetype)initMock{
    self = [self init];
    if (self) {
        self.dia = arc4random()%7;
        self.hora = [NSDate dateWithTimeIntervalSince1970:28800+arc4random()%50400];
    }
    return self;
}

- (NSComparisonResult)compare:(SesionRutina *)otraRutina{
    NSComparisonResult resultado = self.dia < otraRutina.dia ? NSOrderedAscending : self.dia == otraRutina.dia? NSOrderedSame: NSOrderedDescending;
    
    if (resultado == NSOrderedSame) {
        resultado = [self.hora compare:otraRutina.hora];
    }
    return resultado;
}

- (id)copyWithZone:(NSZone*)aZone {
    SesionRutina* sesion = [[[self class] allocWithZone:aZone] init];
    sesion.dia = self.dia;
    sesion.hora = [self.hora copy];
    
    return sesion;
}


@end
