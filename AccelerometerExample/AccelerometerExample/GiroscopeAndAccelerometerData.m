//
//  GiroscopeAndAccelerometerData.m
//  AccelerometerExample
//
//  Created by Jonathan Exequiel Banga on 13/05/14.
//  Copyright (c) 2014 Jonathan Exequiel Banga. All rights reserved.
//

#import "GiroscopeAndAccelerometerData.h"

@implementation GiroscopeAndAccelerometerData

- (NSString *)description{
    return [NSString stringWithFormat:@"(%.2f,%.2f,%.2f)(%.2f,%.2f,%.2f);",self.rotation.x,self.rotation.y,self.rotation.z,self.acceleration.x,self.acceleration.y,self.acceleration.z];
}

- (NSString *)rotationDescription{
    NSString *string = [NSString stringWithFormat:@"%.4f/%.4f/%.4f;",self.rotation.x,self.rotation.y,self.rotation.z];
    return [string stringByReplacingOccurrencesOfString:@"." withString:@","];
}

- (NSString *)accelerationDescription{
    NSString *string = [NSString stringWithFormat:@"%.4f/%.4f/%.4f;",self.acceleration.x,self.acceleration.y,self.acceleration.z];
    return [string stringByReplacingOccurrencesOfString:@"." withString:@","];
}

@end
