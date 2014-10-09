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

#define kSamplingTimeInterval 1.0/50.0
#define kBufferSize 10

@interface StepCounter()
@property(nonatomic,strong)CMMotionManager *motionManager;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,strong)NSMutableArray *dataBuffer;
@property(nonatomic,assign)BOOL shouldSample;

@property(nonatomic,assign)NSUInteger currentMin;
@property(nonatomic,assign)NSUInteger countChanges;
@property(nonatomic,strong)NSDate *lastCountTime;


@end

@implementation StepCounter
#pragma mark - Initialization
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
        self.samplingTimeInterval = kSamplingTimeInterval;
        self.shouldSample         = NO;
        self.data                 = [NSMutableArray new];
        self.dataBuffer           = [NSMutableArray new];
        
        [self loadMotionManager];
        [self startProccessingData];
    }
    return self;
}

- (void)loadMotionManager{
    self.motionManager = [CMMotionManager new];
}

- (void)updateSampleRate{
    [self.motionManager setGyroUpdateInterval:self.samplingTimeInterval];
    [self.motionManager setAccelerometerUpdateInterval:self.samplingTimeInterval];
    [self.motionManager setDeviceMotionUpdateInterval:self.samplingTimeInterval];
}

- (void)startProccessingData{
    [self.motionManager startGyroUpdates];
    [self.motionManager startAccelerometerUpdates];
    [self.motionManager startDeviceMotionUpdates];
}


#pragma mark - Actions

- (void)start{
    self.shouldSample = YES;
    [self updateSampleRate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.samplingTimeInterval target:self selector:@selector(takeSample) userInfo:nil repeats:YES];
//    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(mock) userInfo:nil repeats:YES];
    [self takeSample];
}

- (void)mock{
    self.countReps ++;
    [self.delegate stepCounterDidRecogniceStep:self];
}

- (void)stop{
    [self.timer invalidate];
    self.shouldSample = NO;
    self.countReps = 0;
}

#pragma mark - Logic
- (void)takeSample{
    if (self.shouldSample) {
        GiroscopeAndAccelerometerData *newData = [GiroscopeAndAccelerometerData new];
        newData.acceleration = self.motionManager.accelerometerData.acceleration;
        newData.rotation = self.motionManager.gyroData.rotationRate;
        
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            
            if (self.dataBuffer.count == kBufferSize) {
                [self.dataBuffer removeLastObject]; // Ojo con esto pichón, de ultima comentalo
            }
            
            if (newData.acceleration.y != 0){ // Agregué este filtro porque si el buffer tiene ceros, no te das cuenta cuando se cambia de signo
                [self.dataBuffer insertObject:@(newData.acceleration.y) atIndex:0];
            }
            
            BOOL change = NO;
            if (self.dataBuffer.count == kBufferSize) {
                NSMutableArray *negativos = [NSMutableArray new];
                for (NSNumber *numero in self.dataBuffer) {
                    if ([numero floatValue]<0) {
                        [negativos addObject:numero];
                    }
                }
                if (negativos.count >= (self.dataBuffer.count*.3) && negativos.count <= (self.dataBuffer.count*.7)) {//Por ejemplo, si la cantidad de negativos está entre el 30% y el 70%
                    change = YES;
                }
            }
            
            if(change && [self.lastCountTime timeIntervalSinceNow]>1){
                self.countChanges++;
                if (self.countChanges % 2) {
                    self.countReps++;
                    self.lastCountTime = [NSDate date];
                    [self.delegate stepCounterDidRecogniceStep:self];
                }
                
                [self.dataBuffer removeAllObjects];
            }
        });
    }
}


@end
