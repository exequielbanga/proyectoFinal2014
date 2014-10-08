//
//  Rutina.h
//  Aeda
//
//  Created by Jonathan Banga on 5/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SesionRutina.h"

@interface Rutina : NSObject
@property(nonatomic,strong)NSString *nombre;
@property(nonatomic,strong)NSString *detalle;
@property(nonatomic,strong)NSString *detalleCorto;
@property(nonatomic,strong)NSArray  *ejercicios;
@property(nonatomic,strong)NSArray  *fechas;
@property(nonatomic,strong)SesionRutina *sesion;

- (instancetype)initMock;

@end
