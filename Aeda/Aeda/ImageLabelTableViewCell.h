//
//  ImageLabelTableViewCell.h
//  Allianz
//
//  Created by Matías Ginart on 8/12/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageLabelTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel* label;

- (void)setLabelText:(NSString*)text;

@end
