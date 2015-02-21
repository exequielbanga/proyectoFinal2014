//
//  RutinaServicePosta.h
//  Aeda
//
//  Created by Jonathan Banga on 21/2/15.
//  Copyright (c) 2015 Solbest. All rights reserved.
//

#import "RestService.h"

@interface RutinaServicePosta : RestService

- (void)getRutinasWithBlock:(ServiceBlock)block;

@end
