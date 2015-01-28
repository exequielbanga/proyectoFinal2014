//
//  Utils.m
//  Allianz
//
//  Created by Created by Exequiel Banga on 5/11/14.
//  Copyright (c) 2014 Exequiel Banga. All rights reserved.
//

#import "Utils.h"
#import <UIKit/UIKit.h>
#define kTermsAndConditionsAcceptedPath @"/TermsAndConditionsAcceptedPath"
#define kiPhoneHelpPath @"/iPhoneHelpPath"
#define kiPhoneHelpMarketPath @"/kiPhoneHelpMarketPath"
#define kiPhoneHelpDollarPath @"/kiPhoneHelpDollarPath"

@implementation Utils

+ (NSArray*)arrayFromObject:(id)object {
    if ([object isKindOfClass:[NSArray class]]) {
        return object;
    } else if (object){
        return @[object];
    } else {
        return @[];
    }
}

+ (BOOL)termsAndConditionsAccepted{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];

    return [[NSFileManager defaultManager] fileExistsAtPath:[documentsDirectory stringByAppendingString:kTermsAndConditionsAcceptedPath]];
}

+ (void)acceptTermsAndConditions{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    
    [NSKeyedArchiver archiveRootObject:@"Accepted" toFile:[documentsDirectory stringByAppendingString:kTermsAndConditionsAcceptedPath]];
}

+ (BOOL)showiPhoneHelpWithPath:(NSString *)path{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[documentsDirectory stringByAppendingString:path]]) {
        [NSKeyedArchiver archiveRootObject:@"Showed" toFile:[documentsDirectory stringByAppendingString:path]];
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)showiPhoneHelp{
    return [self showiPhoneHelpWithPath:kiPhoneHelpPath];
}

+ (BOOL)showiPhoneHelpMarket{
    return [self showiPhoneHelpWithPath:kiPhoneHelpMarketPath];
}

+ (BOOL)showiPhoneHelpDollar{
    return [self showiPhoneHelpWithPath:kiPhoneHelpDollarPath];
}

+ (UIFont *)boldFont:(UIFont *)font{

    NSString *fontName = font.fontName;
    NSString *boldFontName = [fontName stringByAppendingString:@"-Bold"];
    UIFont *boldFont = [UIFont fontWithName:boldFontName size:font.pointSize];
    if(boldFont) return boldFont;
    boldFontName = [fontName stringByAppendingString:@"-BoldMT"];
    boldFont = [UIFont fontWithName:boldFontName size:font.pointSize];
    return boldFont;
}

@end
