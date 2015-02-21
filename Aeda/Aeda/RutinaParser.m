//
//  RutinaParser.m
//  Aeda
//
//  Created by Jonathan Banga on 21/2/15.
//  Copyright (c) 2015 Solbest. All rights reserved.
//

#import "RutinaParser.h"
#import "Rutina.h"

@implementation RutinaParser
- (NSString *)keyPathToResponse{
    return @"content";
}

- (Class)responseObjectsClass{
    return [Rutina class];
}
@end
