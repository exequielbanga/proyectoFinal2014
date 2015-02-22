//
//  EjercicioParser.m
//  Aeda
//
//  Created by Jonathan Banga on 22/2/15.
//  Copyright (c) 2015 Solbest. All rights reserved.
//

#import "EjercicioParser.h"
#import "Ejercicio.h"

@implementation EjercicioParser

- (NSString *)keyPathToResponse{
    return @"content";
}

- (Class)responseObjectsClass{
    return [Ejercicio class];
}

@end
