//
//  NSObject+NibCreator.m
//  Allianz
//
//  Created by Matías Ginart on 8/25/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "NSObject+NibCreator.h"

@implementation NSObject (NibCreator)

+ (instancetype)objectFromNib {
    NSString* className = NSStringFromClass([self class]);
    id objectToReturn = [[NSBundle mainBundle] loadNibNamed:className owner:nil options:nil][0];
    return objectToReturn;
}

@end
