//
//  ResultadoEjercicio.h
//  Aeda
//
//  Created by Jonathan Banga on 6/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "Ejercicio.h"

@interface ResultadoEjercicio : Ejercicio

@property(nonatomic,assign)NSTimeInterval   resultadoTiempo;

@property(nonatomic,strong)NSArray          *resultadoRepeticiones;
@property(nonatomic,strong)NSArray          *resultadoTiemposEntreRepeticiones;
@property(nonatomic,strong)NSArray          *resultadoPesos;

@end
