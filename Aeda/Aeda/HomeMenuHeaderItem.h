//
//  HomeMenuHeaderItem.h
//  Allianz
//
//  Created by Matías Ginart on 8/9/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeMenuHeaderItem : NSObject

@property (nonatomic, copy) NSString* imageName;
@property (nonatomic, copy) NSString* firstText;
@property (nonatomic, copy) NSString* secondText;
@property (nonatomic, weak) id target;
@property (nonatomic) SEL selector;

+ (HomeMenuHeaderItem*)itemWithImageName:(NSString*)imageName firstText:(NSString*)firstText secondText:(NSString*)secondText;

@end
