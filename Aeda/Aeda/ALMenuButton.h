//
//  ALMenuButton.h
//  Allianz
//
//  Created by Matías Ginart on 7/29/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALMenuButton : UIButton

@property (nonatomic, strong) UILabel* firstLineLabel;
@property (nonatomic, strong) UILabel* secondLineLabel;

- (void)setIconImage:(UIImage*)iconImage;

@end
