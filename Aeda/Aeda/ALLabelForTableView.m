//
//  ALFooterLabelView.m
//  Allianz
//
//  Created by Matías Ginart on 8/2/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "ALLabelForTableView.h"
#import "UIFont+ALFonts.h"
#import "UIColor+ALColor.h"

@interface ALLabelForTableView()
@end

@implementation ALLabelForTableView

+ (ALLabelForTableView*)footerView {
    ALLabelForTableView* viewToReturn = [[NSBundle mainBundle] loadNibNamed:@"ALLabelForTableView" owner:self options:nil][0];
    return viewToReturn;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.textLabel.textColor = [UIColor ALLightGrayTextColor];
    self.textLabel.font = [UIFont allianzSansWithSize:16];
}

- (void)setText:(NSString*)text {
    self.textLabel.text = text;
    CGFloat height = [self systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

@end
