//
//  ResultadoEjercicio.h
//  Aeda
//
//  Created by Jonathan Banga on 6/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "AEDAModel.h"
#import "Ejercicio.h"

@interface ResultadoEjercicio : AEDAModel //Es el resultado de UNA SERIE del ejercicio

@property(nonatomic,strong)Ejercicio   *ejercicio;

@property(nonatomic,strong)NSString   *idEjercicio;
@property(nonatomic,assign)NSString   *fecha;
@property(nonatomic,assign)NSNumber   *tiempoEjercicio;
@property(nonatomic,assign)NSNumber   *tiempoPausa;

@property(nonatomic,strong)NSNumber   *repeticiones;
@property(nonatomic,strong)NSNumber   *serie;

@property(nonatomic,assign)BOOL completado;

- (instancetype)initWithEjercicio:(Ejercicio *)ejercicio;

@end
