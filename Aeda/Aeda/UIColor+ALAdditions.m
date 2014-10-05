//
// UIColor+MLAdditions.m
// MercadoLibre
//
// Created by Matías Ginart on 5/28/14.
// Copyright (c) 2014 MercadoLibre - Mobile Apps. All rights reserved.
//

#import "UIColor+ALAdditions.h"

@implementation UIColor (ALAdditions)

- (UIColor *)lighterColor
{
	CGFloat h, s, b, a;
	if ([self getHue:&h saturation:&s brightness:&b alpha:&a]) {
		return [UIColor colorWithHue:h
		                  saturation:s
		                  brightness:MIN(b * 1.3, 1.0)
		                       alpha:a];
	}
	return nil;
}

- (UIColor *)darkerColor
{
	CGFloat h, s, b, a;
	if ([self getHue:&h saturation:&s brightness:&b alpha:&a]) {
		return [UIColor colorWithHue:h
		                  saturation:s
		                  brightness:b * 0.75
		                       alpha:a];
	}
	return nil;
}

@end
