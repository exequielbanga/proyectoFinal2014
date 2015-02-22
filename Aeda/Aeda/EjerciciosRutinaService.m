//
//  DetalleRutinaService.m
//  Aeda
//
//  Created by Jonathan Banga on 22/2/15.
//  Copyright (c) 2015 Solbest. All rights reserved.
//

#import "EjerciciosRutinaService.h"
#import "EjercicioParser.h"

@implementation EjerciciosRutinaService
- (RestMethod)method {
    return RestMethodGET;
}

- (Class)parserClass {
    return [EjercicioParser class];
}

- (void)getEjerciciosForRutina:(Rutina *)rutina WithBlock:(ServiceBlock)block {
    self.path = [NSString stringWithFormat:@"EjercicioRutinas/index/%@.json",rutina.rutinaId];
    
    [self requestWithServiceBlock:block];
}
@end
