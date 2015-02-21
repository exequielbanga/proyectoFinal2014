//
//  MisDatosParser.m
//  Aeda
//
//  Created by Jonathan Banga on 21/2/15.
//  Copyright (c) 2015 Solbest. All rights reserved.
//

#import "MisDatosParser.h"
#import "User.h"

@implementation MisDatosParser

- (NSString *)keyPathToResponse{
    return nil;
}

- (Class)responseObjectsClass{
    return [User class];
}

@end
