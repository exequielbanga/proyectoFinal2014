//
//  MisDatosService.h
//  Aeda
//
//  Created by Jonathan Banga on 28/1/15.
//  Copyright (c) 2015 Solbest. All rights reserved.
//

#import "RestService.h"

@interface MisDatosService : RestService

- (void)getMisDatosWithBlock:(ServiceBlock)block;

@end
