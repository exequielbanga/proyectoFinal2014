//
//  UIFont+ALFonts.m
//  Allianz
//
//  Created by Matías Ginart on 7/29/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "UIFont+ALFonts.h"

@implementation UIFont (ALFonts)

+ (UIFont*)allianzSansWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"AllianzSans" size:size];
}

+ (UIFont*)allianzSansItalicWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"AllianzSans-Italic" size:size];
}

+ (UIFont*)allianzSansBoldItalicWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"AllianzSans-BoldItalic" size:size];
}

+ (UIFont*)allianzSansBoldWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"AllianzSans-Bold" size:size];
}

+ (UIFont*)allianzSansLightWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"AllianzSans-Light" size:size];
}

+ (UIFont*)allianzSansLightItalicWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"AllianzSans-LightItalic" size:size];
}

+ (UIFont*)allianzSerifWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"AllianzSerif" size:size];
}

+ (UIFont*)allianzSerifItalicWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"AllianzSerif-Italic" size:size];
}

+ (UIFont*)allianzSerifLightWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"AllianzSerif-Light" size:size];
}

+ (UIFont*)allianzSerifLightItalicWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"AllianzSerif-LightItalic" size:size];
}

+ (UIFont*)allianzSerifBoldWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"AllianzSerif-Bold" size:size];
}

+ (UIFont*)allianzSerifBoldItalicWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"AllianzSerif-BoldItalic" size:size];
}

@end
