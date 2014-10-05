//
//  ResultadoRutina.h
//  Aeda
//
//  Created by Jonathan Banga on 5/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Rutina.h"

@interface ResultadoRutina : NSObject

@property(nonatomic,strong)Rutina *rutina;
@property(nonatomic,assign)CGFloat resultado; //0..1

//Diccionario con clave: ejercicio, valor: array con resultado por repetición
@property(nonatomic,strong)NSMutableDictionary *detalleResultados;

- (instancetype)initMock;

@end
