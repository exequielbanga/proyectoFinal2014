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

@end
