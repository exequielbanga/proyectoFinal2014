//
//  EntryMessageViewController.h
//  Allianz
//
//  Created by Matías Ginart on 8/23/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "ALAuthenticationViewController.h"
#import "RutinaServicePosta.h"

@interface RutinasListViewController : ALAuthenticationViewController

@property (nonatomic) BOOL isEntryListing;
@property (nonatomic, strong) NSArray *tableData;
@property (nonatomic, strong) RutinaServicePosta* service;

- (void)reloadData;

@end
