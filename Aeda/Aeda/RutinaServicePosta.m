//
//  RutinaServicePosta.m
//  Aeda
//
//  Created by Jonathan Banga on 21/2/15.
//  Copyright (c) 2015 Solbest. All rights reserved.
//

#import "RutinaServicePosta.h"
#import "RutinaParser.h"
@implementation RutinaServicePosta

- (RestMethod)method {
    return RestMethodGET;
}

- (Class)parserClass {
    return [RutinaParser class];
}

- (void)getRutinasWithBlock:(ServiceBlock)block {
    self.path = @"UsuarioRutinas.json";
    
    [self requestWithServiceBlock:block];
}
@end
