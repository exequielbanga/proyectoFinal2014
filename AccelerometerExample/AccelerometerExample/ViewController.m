//
//  ViewController.m
//  AccelerometerExample
//
//  Created by Jonathan Exequiel Banga on 30/04/14.
//  Copyright (c) 2014 Jonathan Exequiel Banga. All rights reserved.
//

#import "ViewController.h"
#import "GiroscopeAndAccelerometerData.h"
#import <CoreMotion/CoreMotion.h>

#define kSamplingTimeInterval .5

@interface ViewController ()
@property(nonatomic,strong)CMMotionManager *motionManager;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation ViewController

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
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.data = [NSMutableArray new];
    [self loadMotionManager];
    [self startProccessingData];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
