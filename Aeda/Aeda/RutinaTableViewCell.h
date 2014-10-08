//
//  RutinaTableViewCell.h
//  Aeda
//
//  Created by Jonathan Banga on 7/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Rutina.h"

@interface RutinaTableViewCell : UITableViewCell

@property (nonatomic,assign)BOOL showsTime;

- (void)fillWithRutina:(Rutina *)rutina;

@end
