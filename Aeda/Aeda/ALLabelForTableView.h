//
//  ALFooterLabelView.h
//  Allianz
//
//  Created by Matías Ginart on 8/2/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALLabelForTableView : UIView

@property (nonatomic, strong) IBOutlet UILabel* textLabel;

+ (ALLabelForTableView*)footerView;

- (void)setText:(NSString*)text;

@end
