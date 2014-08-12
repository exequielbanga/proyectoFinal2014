//
//  TakeSampleButton.m
//  AccelerometerExample
//
//  Created by Jonathan Exequiel Banga on 13/05/14.
//  Copyright (c) 2014 Jonathan Exequiel Banga. All rights reserved.
//

#import "TakeSampleButton.h"
@interface TakeSampleButton()
@property(nonatomic,strong)NSObject *startTarget;
@property(nonatomic,strong)NSObject *endTarget;
@property(nonatomic)SEL startSelector;
@property(nonatomic)SEL endSelector;
@end

@implementation TakeSampleButton

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setTargetForBeginTouch:(id)target selector:(SEL)selector{
    self.startTarget = target;
    self.startSelector = selector;
}
- (void)setTargetForEndTouch:(id)target selector:(SEL)selector{
    self.endTarget = target;
    self.endSelector = selector;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    if (self.startTarget) {
        [self.startTarget performSelector:self.startSelector withObject:nil afterDelay:0];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];
    if (self.endTarget) {
        [self.endTarget performSelector:self.endSelector withObject:nil afterDelay:0];
    }
}

@end
