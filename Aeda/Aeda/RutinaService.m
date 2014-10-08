//
//  RutinaService.m
//  Aeda
//
//  Created by Jonathan Banga on 7/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "RutinaService.h"
#import "Rutina.h"
@implementation RutinaService

- (void)getRutinasWithBlock:(ServiceBlock)block{
    block([NSArray arrayWithObjects:[[Rutina alloc]initMock],[[Rutina alloc]initMock],[[Rutina alloc]initMock],[[Rutina alloc]initMock],[[Rutina alloc]initMock],[[Rutina alloc]initMock],[[Rutina alloc]initMock],[[Rutina alloc]initMock],[[Rutina alloc]initMock],[[Rutina alloc]initMock],[[Rutina alloc]initMock],[[Rutina alloc]initMock],[[Rutina alloc]initMock],[[Rutina alloc]initMock],[[Rutina alloc]initMock],[[Rutina alloc]initMock],[[Rutina alloc]initMock],[[Rutina alloc]initMock],[[Rutina alloc]initMock], nil],nil);
}

- (void)getRutinasHoyWithBlock:(ServiceBlock)block{
    
    NSMutableArray *rutinas = [NSMutableArray new];
    while (rutinas.count < 3) {
        Rutina *nuevaRutina = [[Rutina alloc] initMock];
        BOOL agregar = YES;
        for (Rutina *rutina in rutinas) {
            if ([nuevaRutina.nombre isEqualToString:rutina.nombre]) {
                agregar = NO;
                break;
            }
        }
        if (agregar) {
            [rutinas addObject:nuevaRutina];
        }
    }
    block(rutinas,nil);
}

@end
