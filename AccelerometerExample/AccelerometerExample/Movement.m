//
//  Movement.m
//  AccelerometerExample
//
//  Created by Jonathan Exequiel Banga on 13/05/14.
//  Copyright (c) 2014 Jonathan Exequiel Banga. All rights reserved.
//

#import "Movement.h"
#import "GiroscopeAndAccelerometerData.h"

@implementation Movement

- (instancetype)init{
    self = [super init];
    if (self) {
        self.data = [NSMutableArray new];
    }
    return self;
}

- (NSString *)description{
    NSMutableString *string = [NSMutableString new];
    for (GiroscopeAndAccelerometerData *data in self.data) {
        [string appendString:data.description];
    }
    [string appendString:@"\n"];
    return string;
}

- (NSString *)separatedDescription{
    NSMutableString *string = [NSMutableString new];
    for (GiroscopeAndAccelerometerData *data in self.data) {
        [string appendFormat:@"%@\n",data.description];
    }
    return string;
}


- (NSString *)rotationData{
    NSMutableString *string = [NSMutableString new];
    for (GiroscopeAndAccelerometerData *data in self.data) {
        [string appendString:[self applyCrazyFunctionTo:[data rotationDescription]]];
    }
    [string appendString:@"\n"];
    return string;
}

- (NSString *)accelerationData{
    NSMutableString *string = [NSMutableString new];
    for (GiroscopeAndAccelerometerData *data in self.data) {
        [string appendString:[self applyCrazyFunctionTo:[data accelerationDescription]]];
    }
    [string appendString:@"\n\n"];
    return string;
}

-(NSString *)applyCrazyFunctionTo:(NSString *)vector{
    NSString *vectorConPunto = [vector stringByReplacingOccurrencesOfString:@"," withString:@"."];
    NSArray *components = [vectorConPunto componentsSeparatedByString:@"/"];
    if (components.count!=3) {
        return @"";
    }
    
    float x = [components[0] floatValue];
    float y = [components[1] floatValue];
    float z = [components[2] floatValue];
    
    components = [[vectorConPunto stringByReplacingOccurrencesOfString:@"-" withString:@""] componentsSeparatedByString:@"/"];
    
    NSString *result = [NSString stringWithFormat:@"%@%.0f%@%.0f%@%.0f",(x<0)?@"0":@"1",[components[0] floatValue]*100000,(y<0)?@"0":@"1",[components[1] floatValue]*100000,(z<0)?@"0":@"1",[components[2] floatValue]*100000];
    
    return result;
}

- (double*)rotationScalars{
    double *scalars = (double *)malloc(sizeof(double)*self.data.count);
    
    double *aScalar = scalars;
    for (GiroscopeAndAccelerometerData *data in self.data) {
        NSString *string = [self applyCrazyFunctionTo:[data rotationDescription]];
        NSNumber *number = [[NSNumberFormatter new] numberFromString:string];
        *aScalar = [number doubleValue];
        aScalar++;
    }
    return scalars;
}

- (double*)accelerationScalars{
    double *scalars = (double *)malloc(sizeof(double)*self.data.count);
    
    double *aScalar = scalars;
    for (GiroscopeAndAccelerometerData *data in self.data) {
        double absoluteValue = sqrtl((data.acceleration.x*data.acceleration.x)+(data.acceleration.y*data.acceleration.y)+(data.acceleration.z*data.acceleration.z))-1;
        *aScalar = absoluteValue;
        aScalar++;
    }
    return scalars;
}


@end
