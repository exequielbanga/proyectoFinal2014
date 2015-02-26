//
//  ResultadoEjercicio.h
//  Aeda
//
//  Created by Jonathan Banga on 6/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "AEDAModel.h"
#import "Ejercicio.h"

@interface ResultadoSerie : AEDAModel //Es el resultado de UNA SERIE del ejercicio

@property(nonatomic,strong)Ejercicio   *ejercicio;

@property(nonatomic,strong)NSString   *idEjercicio;
@property(nonatomic,strong)NSString   *fecha;
@property(nonatomic,strong)NSNumber   *tiempoEjercicio;
@property(nonatomic,strong)NSNumber   *tiempoPausa;

@property(nonatomic,strong)NSNumber   *repeticiones;
@property(nonatomic,strong)NSNumber   *serie;

@property(nonatomic,assign)BOOL completado;

- (instancetype)initWithEjercicio:(Ejercicio *)ejercicio;

@end
