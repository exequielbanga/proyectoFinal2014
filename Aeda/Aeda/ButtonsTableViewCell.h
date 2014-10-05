//
//  ButtonsTableViewCell.h
//  Allianz
//
//  Created by Jonathan Banga on 28/8/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.


//Component: The component receives an array of UIButtons and show them in its contentView. Adaps the frame of each button to fill all the screen.
//

#import <UIKit/UIKit.h>

@interface ButtonsTableViewCell : UITableViewCell
@property(nonatomic,strong)NSArray *buttons;
@property(nonatomic,assign)CGFloat lineSeparatorWidth;
@property(nonatomic,assign)UIColor* lineSeparatorColor;
@end
