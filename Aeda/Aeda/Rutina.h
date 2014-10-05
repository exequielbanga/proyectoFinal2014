//
//  Rutina.h
//  Aeda
//
//  Created by Jonathan Banga on 5/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Rutina : NSObject
@property(nonatomic,strong)NSString *nombre;
@property(nonatomic,strong)NSString *detalle;
@property(nonatomic,strong)NSArray  *ejercicios;

- (instancetype)initMock;

@end
