//
//  Ejercicio.h
//  Aeda
//
//  Created by Jonathan Banga on 5/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ejercicio : NSObject
@property(nonatomic,strong)NSString         *nombre;
@property(nonatomic,strong)NSString         *detalle;
@property(nonatomic,assign)NSTimeInterval   tiempo;

@property(nonatomic,strong)NSArray          *repeticiones;
@property(nonatomic,strong)NSArray          *tiemposEntreRepeticiones;

//Un array con los pesos para cada repetición
@property(nonatomic,strong)NSArray          *pesos;

- (instancetype)initMock;

@end
