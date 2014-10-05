//
//  MisAseguradosViewController.m
//  AllianzMisAsegurados
//
//  Created by Jonathan Banga on 3/10/14.
//  Copyright (c) 2014 RedBee. All rights reserved.
//

#import "SeguimientoViewController.h"
#import "ALButton.h"
#import "UIColor+ALColor.h"
//#import "AseguradoTableViewCell.h"
//#import "AseguradoViewController.h"

#define kCellIdentifier @"MisAseguradosCellIdentifier"

@interface SeguimientoViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UISearchBarDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *tableData;
//@property(nonatomic,strong)CarteraService *service;
@property(nonatomic,strong)UISearchBar *searchBar;

@end

@implementation SeguimientoViewController

#pragma mark - Init stuff

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Mi Seguimiento";
        [self createTableView];
    }
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"AseguradoTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kCellIdentifier];
    [self createTableHeader];
    [self createTableFooter];
    [self.view addSubview:self.tableView];
}

- (void)createTableHeader{
    UISearchBar *header = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 44)];
    header.delegate = self;
    self.searchBar = header;
    self.tableView.tableHeaderView = header;
}

- (void)createTableFooter{
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 0)];
    footer.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = footer;
}

- (void)userLoged{
    [super userLoged];
    [self callService];
}

- (void)reloadData{
//    [self hideLoadingMessage];
//
//    self.tableData = [NSMutableArray new];
//    if (!self.searchBar.text.length) {
//        [self.tableData addObjectsFromArray:(NSArray *)self.service.response];
//    }else for (Asegurado *asegurado in (NSArray *)self.service.response) {
//        if ([self asegurado:asegurado matchWithDescription:self.searchBar.text]) {
//            [self.tableData addObject:asegurado];
//        }
//    }
//
//    [self.tableView reloadData];
}

#pragma mark - Service
- (void)callService{
//    [self showLoadingMessage];
//    if (!self.service) {
//        self.service = [CarteraService new];
//    }
//    [self.service getCartera];
}

- (void)serviceError:(NSNotification *)notification{
    [self hideLoadingMessage];
    [self showError:@"Por favor intente mas tarde." delegate:self];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self userNotLoged];
}

#pragma mark - Getters and Setters

#pragma mark - TableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    AseguradoTableViewCell *cell = (AseguradoTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    
//    [cell fillWithAsegurado:(Asegurado *)self.tableData[indexPath.row]];
//
    
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    AseguradoViewController *viewController = [[AseguradoViewController alloc] initWithNibName:nil bundle:nil];
//    viewController.persona = self.tableData[indexPath.row];
//    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - Searchbar
//- (BOOL)asegurado:(Asegurado *)asegurado matchWithDescription:(NSString *)description{
//    BOOL result = NO;
//    result = [[asegurado nombre] rangeOfString:description options:NSCaseInsensitiveSearch].location != NSNotFound;
//    if (!result) {
//        result = [[asegurado personaId] rangeOfString:description options:NSCaseInsensitiveSearch].location != NSNotFound;
//    }
//    return result;
//}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    self.searchBar.showsCancelButton = YES;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    self.searchBar.showsCancelButton = NO;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [self reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    searchBar.text = @"";
    [self reloadData];
}

@end