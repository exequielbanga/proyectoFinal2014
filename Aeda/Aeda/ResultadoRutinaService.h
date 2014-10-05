//
//  ResultadoRutinaService.h
//  Aeda
//
//  Created by Jonathan Banga on 5/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "RestService.h"

@interface ResultadoRutinaService : RestService

- (void)getResultadoRutinasWithBlock:(ServiceBlock)block;

@end
