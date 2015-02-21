//
//  MisDatosService.m
//  Aeda
//
//  Created by Jonathan Banga on 28/1/15.
//  Copyright (c) 2015 Solbest. All rights reserved.
//

#import "MisDatosService.h"
#import "MisDatosParser.h"

@implementation MisDatosService

- (RestMethod)method {
    return RestMethodGET;
}

- (BOOL)isAuthenticated{
    return NO;
}

- (Class)parserClass {
    return [MisDatosParser class];
}

- (void)getMisDatosWithBlock:(ServiceBlock)block {
    self.path = @"MisDatos.json";
    
    [self requestWithServiceBlock:block];
}

@end
