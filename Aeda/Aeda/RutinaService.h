//
//  RutinaService.h
//  Aeda
//
//  Created by Jonathan Banga on 7/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "RestService.h"

@interface RutinaService : RestService

- (void)getRutinasWithBlock:(ServiceBlock)block;
- (void)getRutinasHoyWithBlock:(ServiceBlock)block;

@end
