//
//  RutinaEnProgreso.h
//  Aeda
//
//  Created by Jonathan Banga on 24/2/15.
//  Copyright (c) 2015 Solbest. All rights reserved.
//

#import "Rutina.h"

@interface RutinaEnProgreso : Rutina
@property(nonatomic,strong)NSMutableArray *resultadoEjercicios;


- (instancetype)initWithRutina:(Rutina *)rutina;

@end
