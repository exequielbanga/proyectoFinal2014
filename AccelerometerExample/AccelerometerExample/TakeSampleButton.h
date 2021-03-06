//
//  TakeSampleButton.h
//  AccelerometerExample
//
//  Created by Jonathan Exequiel Banga on 13/05/14.
//  Copyright (c) 2014 Jonathan Exequiel Banga. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TakeSampleButton : UILabel
- (void)setTargetForBeginTouch:(NSObject *)target selector:(SEL)selector;
- (void)setTargetForEndTouch:(NSObject *)target selector:(SEL)selector;
@end
