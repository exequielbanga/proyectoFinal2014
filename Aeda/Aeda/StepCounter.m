//
//  StepCounter.m
//  Aeda
//
//  Created by Jonathan Banga on 8/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "StepCounter.h"
#import "GiroscopeAndAccelerometerData.h"
#import <CoreMotion/CoreMotion.h>

#define kSamplingTimeInterval .5

@interface StepCounter()
@property(nonatomic,strong)CMMotionManager *motionManager;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,strong)NSMutableArray *buffer;
@property(nonatomic,assign)BOOL processing;
@end

@implementation StepCounter

+ (instancetype)sharedStepCounter{
    static id _sharedSingleton = nil;
    if (_sharedSingleton == nil){
        _sharedSingleton = [[self alloc] init];
    }
    return _sharedSingleton;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.data = [NSMutableArray new];
        self.buffer = [NSMutableArray new];
        [self loadMotionManager];
        self.processing = NO;
    }
    return self;
}

- (void)start{
    while (self.processing) {
        [self.delegate stepCounterDidRecogniceStep:self];
        [self performSelector:@selector(start) withObject:nil afterDelay:1.5];
    }
}

- (void)stop{
    self.processing = NO;
}


- (void)loadMotionManager{
    self.motionManager = [CMMotionManager new];
    
    [self.motionManager setGyroUpdateInterval:kSamplingTimeInterval];
    [self.motionManager setAccelerometerUpdateInterval:kSamplingTimeInterval];
    [self.motionManager setDeviceMotionUpdateInterval:kSamplingTimeInterval];
}

- (void)startProccessingData{
    [self.motionManager startGyroUpdates];
    [self.motionManager startAccelerometerUpdates];
    [self.motionManager startDeviceMotionUpdates];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:kSamplingTimeInterval target:self selector:@selector(takeSample) userInfo:nil repeats:YES];
}


- (void)takeSample{
    GiroscopeAndAccelerometerData *newData = [GiroscopeAndAccelerometerData new];
    newData.acceleration = self.motionManager.accelerometerData.acceleration;
    newData.rotation = self.motionManager.gyroData.rotationRate;
    [self.data addObject:newData];
    [self.buffer insertObject:@(newData.acceleration.x) atIndex:0];
    if (self.buffer.count > 10) {
        [self.buffer removeLastObject];
    }
}


@end
