//
//  ButtonsTableViewCell.m
//  Allianz
//
//  Created by Jonathan Banga on 28/8/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "ButtonsTableViewCell.h"
#define KXOffset .5
#define KYOffset 5
@interface ButtonsTableViewCell()
@end

@implementation ButtonsTableViewCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.lineSeparatorWidth = KXOffset;
        self.lineSeparatorColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.lineSeparatorWidth = KXOffset;
        self.lineSeparatorColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
    }
    return self;
}

- (void)updateFrames{
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat buttonWidth = (self.contentView.frame.size.width - (self.buttons.count+1)*self.lineSeparatorWidth) / self.buttons.count;
    for (NSInteger i = 0; i < self.buttons.count; i++) {
        UIButton *aButton = self.buttons[i];
        aButton.frame = CGRectMake(self.lineSeparatorWidth + (buttonWidth + self.lineSeparatorWidth)*i, KYOffset, buttonWidth, self.contentView.frame.size.height - 2*KYOffset);
        [self.contentView addSubview:aButton];
        if (self.lineSeparatorWidth && i!=self.buttons.count-1) {
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(aButton.frame.origin.x+aButton.frame.size.width, 0, self.lineSeparatorWidth, self.contentView.frame.size.height)];
            line.backgroundColor = self.lineSeparatorColor;
            [self.contentView addSubview:line];
        }
    }
}

- (void)setButtons:(NSArray *)buttons{
    _buttons = buttons;
    [self updateFrames];
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self updateFrames];
}

- (void)setLineSeparatorColor:(UIColor *)lineSeparatorColor{
    _lineSeparatorColor = lineSeparatorColor;
    [self updateFrames];
}

- (void)setLineSeparatorWidth:(CGFloat)lineSeparatorWidth{
    _lineSeparatorWidth = lineSeparatorWidth;
    [self updateFrames];
}

@end
