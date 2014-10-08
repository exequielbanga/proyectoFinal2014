//
//  HeartRate.m
//  Aeda
//
//  Created by Jonathan Banga on 8/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "HeartRate.h"

@implementation HeartRate

+(instancetype)sharedHeartRate{
    static id _sharedSingleton = nil;
    if (_sharedSingleton == nil){
        _sharedSingleton = [[self alloc] init];
    }
    return _sharedSingleton;
}

- (NSUInteger)rate{
    return 110 + arc4random()%3;
}

@end
