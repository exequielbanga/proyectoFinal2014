//
//  GiroscopeAndAccelerometerData.h
//  AccelerometerExample
//
//  Created by Jonathan Exequiel Banga on 13/05/14.
//  Copyright (c) 2014 Jonathan Exequiel Banga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

@interface GiroscopeAndAccelerometerData : NSObject

@property (nonatomic,assign)CMRotationRate rotation;
@property (nonatomic,assign)CMAcceleration acceleration;

- (NSString *)rotationDescription;
- (NSString *)accelerationDescription;

@end
