//
//  Movement.h
//  AccelerometerExample
//
//  Created by Jonathan Exequiel Banga on 13/05/14.
//  Copyright (c) 2014 Jonathan Exequiel Banga. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movement : NSObject

@property(nonatomic,strong)NSMutableArray *data;

- (NSString *)rotationData;
- (NSString *)accelerationData;
- (double*)rotationScalars;
- (double*)accelerationScalars;

- (NSString *)separatedDescription;

@end
