//
//  Utils.h
//  Allianz
//
//  Created by Exequiel Banga on 5/11/14.
//  Copyright (c) 2014 Exequiel Banga. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIFont;

@interface Utils : NSObject

// Si object es NSArray, devuelve dicho objeto, sino, devuelve un array con ese objeto
+ (NSArray*)arrayFromObject:(id)object;
+ (BOOL)termsAndConditionsAccepted;
+ (void)acceptTermsAndConditions;
+ (BOOL)showiPhoneHelp;
+ (BOOL)showiPhoneHelpMarket;
+ (BOOL)showiPhoneHelpDollar;
+ (UIFont*)boldFont:(UIFont*)font;
@end
