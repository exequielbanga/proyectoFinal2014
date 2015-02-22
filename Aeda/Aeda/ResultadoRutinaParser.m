//
//  ResultadoRutinaParser.m
//  Aeda
//
//  Created by Jonathan Banga on 22/2/15.
//  Copyright (c) 2015 Solbest. All rights reserved.
//

#import "ResultadoRutinaParser.h"
#import "ResultadoRutina.h"

@implementation ResultadoRutinaParser
- (NSString *)keyPathToResponse{
    return @"content";
}

- (Class)responseObjectsClass{
    return [ResultadoRutina class];
}
@end
