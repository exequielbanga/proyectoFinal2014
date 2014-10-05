//
//  TitleTextViewTableViewCell.h
//  Allianz
//
//  Created by Jonathan Banga on 15/8/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCPlaceholderTextView.h"

@interface TitleTextViewTableViewCell : UITableViewCell
@property(nonatomic,assign)NSString *title;
@property(nonatomic,assign)NSString *detail;
@property(nonatomic,assign)BOOL linkDetectors;
@end
