//
//  ResultadoRutinaService.m
//  Aeda
//
//  Created by Jonathan Banga on 5/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "ResultadoRutinaService.h"
#import "ResultadoRutinaParser.h"

@implementation ResultadoRutinaService

- (RestMethod)method {
    return RestMethodGET;
}

- (Class)parserClass {
    return [ResultadoRutinaParser class];
}

- (void)getResultadoRutinasWithBlock:(ServiceBlock)block{
    self.path = @"HistorialEjercicioUsuario.json";
    [self requestWithServiceBlock:block];
}

@end
