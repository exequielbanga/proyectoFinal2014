//
//  MisDatosTableViewHeader.h
//  Allianz
//
//  Created by Jonathan Banga on 28/8/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALLabelForTableView.h"

@interface MisDatosTableViewHeader : ALLabelForTableView

@property (nonatomic, strong) IBOutlet UILabel* textLabel;

+ (MisDatosTableViewHeader*)header;

@end
