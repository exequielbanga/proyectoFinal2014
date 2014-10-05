//
//  ALToolbar.m
//  Allianz
//
//  Created by Matías Ginart on 7/25/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "ALToolbar.h"
#import "UIColor+ALColor.h"

@implementation ALToolbar

+ (ALToolbar*)createToolbarWithSize:(CGSize)size {
    ALToolbar* toolbar = [[ALToolbar alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    toolbar.barStyle = UIBarStyleDefault;
    toolbar.translucent = NO;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 7) {
        toolbar.barTintColor = [UIColor ALBlueColor];
        toolbar.tintColor = [UIColor whiteColor];
    }
    return toolbar;
}

+ (ALToolbar*)toolbarWithSize:(CGSize)size doneTappedBlock:(AlToolbarDonePressed)block {
    ALToolbar* toolbar = [self createToolbarWithSize:size];
    toolbar.donePressedBlock = block;

    UIBarButtonItem* flexibleBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem* doneButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Listo" style:UIBarButtonItemStyleDone target:toolbar action:@selector(donePressed)];
    toolbar.items = @[flexibleBarButtonItem, doneButtonItem];
    return toolbar;
}

+ (ALToolbar*)toolbarWithSize:(CGSize)size doneTappedBlock:(AlToolbarDonePressed)block nextTappedBlock:(AlToolbarNextPressed)nextBlock{
    ALToolbar* toolbar = [self createToolbarWithSize:size];
    toolbar.donePressedBlock = block;
    toolbar.nextPressedBlock = nextBlock;
    
    UIBarButtonItem* flexibleBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem* doneButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Listo" style:UIBarButtonItemStyleDone target:toolbar action:@selector(donePressed)];
    UIBarButtonItem* nextButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Siguiente" style:UIBarButtonItemStyleDone target:toolbar action:@selector(nextPressed)];
    toolbar.items = @[flexibleBarButtonItem, nextButtonItem, doneButtonItem];
    return toolbar;
}

+ (ALToolbar*)toolbarWithSize:(CGSize)size doneTappedBlock:(AlToolbarDonePressed)block cancelTappedBlock:(AlToolbarNextPressed)cancelBlock {
    ALToolbar* toolbar = [self createToolbarWithSize:size];
    toolbar.donePressedBlock = block;
    toolbar.cancelPressedBlock = cancelBlock;

    UIBarButtonItem* cancelButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancelar" style:UIBarButtonItemStyleDone target:toolbar action:@selector(cancelPressed)];
    UIBarButtonItem* flexibleBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem* doneButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Listo" style:UIBarButtonItemStyleDone target:toolbar action:@selector(donePressed)];
    toolbar.items = @[cancelButtonItem, flexibleBarButtonItem, doneButtonItem];
    return toolbar;
}

+ (ALToolbar*)toolbarWithSize:(CGSize)size doneTappedBlock:(AlToolbarDonePressed)block cancelTappedBlock:(AlToolbarCancelPressed)cancelBlock nextTappedBlock:(AlToolbarNextPressed)nextBlock{
    ALToolbar* toolbar = [self createToolbarWithSize:size];
    toolbar.donePressedBlock = block;
    toolbar.cancelPressedBlock = cancelBlock;
    toolbar.nextPressedBlock = nextBlock;
    
    UIBarButtonItem* cancelButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancelar" style:UIBarButtonItemStyleDone target:toolbar action:@selector(cancelPressed)];
    UIBarButtonItem* flexibleBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem* doneButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Listo" style:UIBarButtonItemStyleDone target:toolbar action:@selector(donePressed)];
    UIBarButtonItem* nextButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Siguiente" style:UIBarButtonItemStyleDone target:toolbar action:@selector(nextPressed)];
    toolbar.items = @[cancelButtonItem, flexibleBarButtonItem, nextButtonItem, doneButtonItem];
    return toolbar;
}

- (void)donePressed {
    if (self.donePressedBlock) {
        self.donePressedBlock(self);
    }
}

- (void)cancelPressed {
    if (self.cancelPressedBlock) {
        self.cancelPressedBlock(self);
    }
}

- (void)nextPressed {
    if (self.nextPressedBlock) {
        self.nextPressedBlock(self);
    }
}

@end
