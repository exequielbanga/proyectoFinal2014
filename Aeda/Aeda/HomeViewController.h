//
//  HomeViewController.h
//  Allianz
//
//  Created by Jonathan Banga on 28/7/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "IPhoneRootViewController.h"
#import "ALMenuButton.h"
#import "ALAuthenticationViewController.h"
#import "ALMessagesButton.h"

@interface HomeViewController : IPhoneRootViewController <UITableViewDataSource, UITableViewDelegate, ALAuthenticationViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UITableView* tableView;
@property (nonatomic, weak) IBOutlet ALMessagesButton* messagesButton;
@property (nonatomic, weak) IBOutlet ALLoggedButton *myProfileButton;

- (IBAction)showMessages;

@end
