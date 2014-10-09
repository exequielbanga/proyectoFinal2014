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

@property(nonatomic,strong)NSMutableArray          *resultadoRepeticiones;
@property(nonatomic,strong)NSMutableArray          *resultadoTiemposEntreRepeticiones;
@property(nonatomic,strong)NSMutableArray          *resultadoPesos;

@property(nonatomic,assign)BOOL completado;

- (instancetype)initWithEjercicio:(Ejercicio *)ejercicio;

@end
