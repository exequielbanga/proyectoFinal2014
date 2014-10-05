//
//  HomeMenuHeaderItem.m
//  Allianz
//
//  Created by Matías Ginart on 8/9/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "HomeMenuHeaderItem.h"

@implementation HomeMenuHeaderItem

+ (HomeMenuHeaderItem*)itemWithImageName:(NSString*)imageName firstText:(NSString*)firstText secondText:(NSString*)secondText {
    HomeMenuHeaderItem* menuItem = [[HomeMenuHeaderItem alloc] init];
    menuItem.imageName = imageName;
    menuItem.firstText = firstText;
    menuItem.secondText = secondText;
    return menuItem;
}

@end
