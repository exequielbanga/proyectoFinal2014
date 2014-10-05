//
//  UIColor+ALColor.m
//  Allianz
//
//  Created by Matías Ginart on 7/24/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "UIColor+ALColor.h"

@implementation UIColor (ALColor)

+ (UIColor*)ALRedColorWithAlpha:(CGFloat)alpha {
    return [UIColor colorWithRed:205.f/255.f green:0 blue:78.f/255.f alpha:alpha];
}

+ (UIColor*)ALRedColor {
    return [UIColor ALRedColorWithAlpha:1];
}

+ (UIColor*)ALLightBlueColor {
    return [UIColor colorWithRed:164.f/255.f green:181.f/255.f blue:211.f/255.f alpha:1];
}

+ (UIColor*)ALBlueColor {
    return [UIColor colorWithRed:0.f/255.f green:55.f/255.f blue:129.f/255.f alpha:1];
}

+ (UIColor*)ALLightGrayColor {
    return [UIColor colorWithRed:204.f/255.f green:204.f/255.f blue:204.f/255.f alpha:1];
}

+ (UIColor*)ALLightGrayTextColor {
    return [UIColor colorWithRed:179.f/255.f green:179.f/255.f blue:179.f/255.f alpha:1];
}

+ (UIColor*)ALLilaColor {
        return [UIColor colorWithRed:239.f/255.f green:239.f/255.f blue:244.f/255.f alpha:1];
}

@end
