//
//  DetalleRutinaService.h
//  Aeda
//
//  Created by Jonathan Banga on 22/2/15.
//  Copyright (c) 2015 Solbest. All rights reserved.
//

#import "RestService.h"
#import "Rutina.h"

@interface EjerciciosRutinaService : RestService

- (void)getEjerciciosForRutina:(Rutina *)rutina WithBlock:(ServiceBlock)block;

@end
