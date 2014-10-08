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

@interface ResultadoRutina : Rutina

@property(nonatomic,assign)CGFloat resultado; //0..1
@property(nonatomic,strong)NSMutableArray *resultadoEjercicios;

- (instancetype)initWithRutina:(Rutina *)rutina;
- (instancetype)initMock;

@end
