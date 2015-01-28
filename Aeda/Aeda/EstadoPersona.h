//
//  EstadoPersona.h
//  Aeda
//
//  Created by Jonathan Banga on 10/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EstadoPersona : NSObject
@property(nonatomic,copy)NSNumber *objetivo;
@property(nonatomic,copy)NSString *detalleObjetivo;
@property(nonatomic,copy)NSNumber *fuerza;
@property(nonatomic,copy)NSNumber *resistencia;
@property(nonatomic,copy)NSNumber *flexibilidad;

- (instancetype)initMock;

@end
