//
//  Ejercicio.h
//  Aeda
//
//  Created by Jonathan Banga on 5/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AEDAModel.h"

#define kTolerancia .2;

@interface Ejercicio : AEDAModel
@property(nonatomic,strong)NSString         *idEjercicio;
@property(nonatomic,strong)NSString         *nombre;
@property(nonatomic,strong)NSString         *detalle;
@property(nonatomic,assign)NSTimeInterval   tiempo;

@property(nonatomic,strong)NSArray          *repeticiones;
@property(nonatomic,strong)NSArray          *tiemposEntreRepeticiones;

@property(nonatomic,strong)NSMutableArray   *historialEjercicios;

//Negrada, no va aca
@property(nonatomic,assign)BOOL completado;


//Un array con los pesos para cada repetición
@property(nonatomic,strong)NSArray          *pesos;

- (void)setEjercicioRutina:(NSDictionary *)ejercicioRutina;

@end
