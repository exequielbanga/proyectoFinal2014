//
//  HeartRate.h
//  Aeda
//
//  Created by Jonathan Banga on 8/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeartRate : NSObject

@property(nonatomic,readonly)NSUInteger rate;
+(instancetype)sharedHeartRate;

@end
