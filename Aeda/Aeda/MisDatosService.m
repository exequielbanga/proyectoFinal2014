//
//  MisDatosService.m
//  Aeda
//
//  Created by Jonathan Banga on 28/1/15.
//  Copyright (c) 2015 Solbest. All rights reserved.
//

#import "MisDatosService.h"

@implementation MisDatosService

- (RestMethod)method {
    return RestMethodGET;
}

- (BOOL)isAuthenticated{
    return NO;
}

- (Class)parserClass {
    return nil;
}

- (void)getMisDatosWithBlock:(ServiceBlock)block {
    self.path = @"MisDatos.json";
    
//    self.bodyParams = @{
//                        @"data[Usuario][username]":username,
//                        @"data[Usuario][password]":password
//                        };
    
    [self requestWithServiceBlock:block];
}

@end
