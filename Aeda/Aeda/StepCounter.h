//
//  StepCounter.h
//  Aeda
//
//  Created by Jonathan Banga on 8/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StepCounter;
@protocol StepCounterDelegate <NSObject>
- (void)stepCounterDidRecogniceStep:(StepCounter *)stepCounter;
@end

@interface StepCounter : NSObject
@property(nonatomic,strong)id<StepCounterDelegate>delegate;
+ (instancetype)sharedStepCounter;

- (void)start;
- (void)stop;

@end
