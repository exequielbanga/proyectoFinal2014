//
//  EntryMessageViewController.h
//  Allianz
//
//  Created by Matías Ginart on 8/23/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "ALAuthenticationViewController.h"

@interface RutinasListViewController : ALAuthenticationViewController

@property (nonatomic) BOOL isEntryListing;
@property (nonatomic, strong) NSArray *tableData;

- (void)reloadData;

@end
