//
//  TitleTextViewTableViewCell.m
//  Allianz
//
//  Created by Jonathan Banga on 15/8/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "TitleTextViewTableViewCell.h"
#import "UIFont+ALFonts.h"
#import "UIColor+ALColor.h"

@interface TitleTextViewTableViewCell()
@property(nonatomic,weak)   IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet GCPlaceholderTextView* textView;
@end

@implementation TitleTextViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.font = [UIFont allianzSansWithSize:17];
    self.titleLabel.textColor = [UIColor ALRedColor];
    
    self.textView.font = [UIFont allianzSansLightWithSize:17];
    self.textView.textColor = [UIColor ALBlueColor];
}

- (void)setDetail:(NSString *)detail{
    self.textView.text = detail;
}
- (void)setTitle:(NSString *)title{
    self.titleLabel.text = title;
}

- (NSString *)detail{
    return self.textView.text;
}
- (NSString *)title{
    return self.titleLabel.text;
}

- (void)setLinkDetectors:(BOOL)linkDetectors{
    if (linkDetectors) {
        self.textView.dataDetectorTypes = UIDataDetectorTypeAll;
    }else{
        self.textView.dataDetectorTypes = UIDataDetectorTypeNone;
    }
}

- (BOOL)linkDetectors{
    return self.textView.dataDetectorTypes == UIDataDetectorTypeAll;
}

@end
