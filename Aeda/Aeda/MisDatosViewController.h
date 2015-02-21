//
//  MisDatosViewController.h
//  Allianz
//
//  Created by Jonathan Banga on 15/8/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "ALAuthenticationViewController.h"
#import "User.h"

@class MutableOrderedDictionary;

@interface MisDatosViewController : ALAuthenticationViewController

@property(nonatomic,strong) User *persona;

//To Subclasses
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)MutableOrderedDictionary *tableData;

- (NSString *)emptyFieldDescription;

@end
