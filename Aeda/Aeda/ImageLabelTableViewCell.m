//
//  ImageLabelTableViewCell.m
//  Allianz
//
//  Created by Matías Ginart on 8/12/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "ImageLabelTableViewCell.h"
#import "UIColor+ALColor.h"
#import "UIFont+ALFonts.h"

@implementation ImageLabelTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.label.textColor = [UIColor ALBlueColor];
    self.label.font = [UIFont allianzSansWithSize:18];
}

- (void)setLabelText:(NSString *)text {
    self.label.text = text;

    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1);
}

@end
