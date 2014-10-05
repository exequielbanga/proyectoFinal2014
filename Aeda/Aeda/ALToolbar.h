//
//  ALToolbar.h
//  Allianz
//
//  Created by Matías Ginart on 7/25/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALToolbar;
typedef void (^AlToolbarDonePressed)(ALToolbar* toolbar);
typedef void (^AlToolbarCancelPressed)(ALToolbar* toolbar);
typedef void (^AlToolbarNextPressed)(ALToolbar* toolbar);

@interface ALToolbar : UIToolbar

@property (nonatomic, copy) AlToolbarDonePressed donePressedBlock;
@property (nonatomic, copy) AlToolbarDonePressed cancelPressedBlock;
@property (nonatomic, copy) AlToolbarNextPressed nextPressedBlock;

+ (ALToolbar*)toolbarWithSize:(CGSize)size doneTappedBlock:(AlToolbarDonePressed)block;

+ (ALToolbar*)toolbarWithSize:(CGSize)size doneTappedBlock:(AlToolbarDonePressed)block nextTappedBlock:(AlToolbarNextPressed)nextBlock;

+ (ALToolbar*)toolbarWithSize:(CGSize)size doneTappedBlock:(AlToolbarDonePressed)block cancelTappedBlock:(AlToolbarNextPressed)cancelBlock;

+ (ALToolbar*)toolbarWithSize:(CGSize)size doneTappedBlock:(AlToolbarDonePressed)block cancelTappedBlock:(AlToolbarCancelPressed)cancelBlock nextTappedBlock:(AlToolbarNextPressed)nextBlock;

@end
