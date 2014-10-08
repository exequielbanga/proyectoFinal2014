//
//  EntryMessageViewController.m
//  Allianz
//
//  Created by Matías Ginart on 8/23/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "RutinasListViewController.h"
#import "RutinaService.h"
#import "RutinaTableViewCell.h"
#import "LoadingNextPageView.h"
#import "RutinaViewController.h"
#import "UIColor+ALColor.h"
#import "RestService.h"

#define kCellIdentifier @"kCellIdentifierRutina"

@interface RutinasListViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView* tableView;
@property (nonatomic, strong) RutinaService* service;

@end

@implementation RutinasListViewController

#pragma mark - ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.service = [[RutinaService alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor ALLilaColor];
    self.tableView.backgroundColor = [UIColor ALLilaColor];

    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView registerNib:[UINib nibWithNibName:@"RutinaTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kCellIdentifier];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if (!self.isMovingToParentViewController) {
        [self callService];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self.service invalidate];
}

#pragma mark - Service

- (void)callService {
    // Debemos o no llamar al servicio?
    if (!self.tableData.count) {
        [self showLoadingMessage];
        
        [self.service getRutinasWithBlock:^(NSObject *response, NSError *error) {
            [self hideLoadingMessage];
            if (error) {
                [self showError:@"No se pueden obtener las rutinas en este momento. Reintente más tarde"];
            } else {
                self.tableData = (NSArray *)response;
                [self reloadData];
            }
        }];
    }
}

#pragma mark - Paginador

- (void)reloadData {
    [self.tableView reloadData];
}

#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableData.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RutinaTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    [cell fillWithRutina:self.tableData[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    RutinaViewController* rutinaViewController = [[RutinaViewController alloc] initWithNibName:nil bundle:nil];
    [rutinaViewController setRutina:self.tableData[indexPath.row]];
    [self.navigationController pushViewController:rutinaViewController animated:YES];
}

@end
