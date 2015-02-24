//
//  Rutina.h
//  Aeda
//
//  Created by Jonathan Banga on 5/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SesionRutina.h"
#import "AEDAModel.h"

@interface Rutina : AEDAModel

@property(nonatomic,strong)NSString *nombre;
@property(nonatomic,strong)NSString *rutinaId;
@property(nonatomic,strong)NSString *detalle;
@property(nonatomic,strong)NSString *detalleCorto;
@property(nonatomic,strong)NSMutableArray  *ejercicios;
@property(nonatomic,strong)NSMutableArray *usuarioRutinas;

- (void)setUsuarioRutina:(NSDictionary *)dictionary;

@end
