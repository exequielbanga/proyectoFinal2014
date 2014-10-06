//
//  SeguimientoViewController
//  AllianzMisAsegurados
//
//  Created by Jonathan Banga on 3/10/14.
//  Copyright (c) 2014 RedBee. All rights reserved.
//

#import "SeguimientoViewController.h"
#import "ALButton.h"
#import "UIColor+ALColor.h"
#import "ResultadoRutinaTableViewCell.h"
#import "ResultadoRutinaService.h"
//#import "AseguradoViewController.h"

#define kCellIdentifier @"SeguimientoViewControllerCell"

@interface SeguimientoViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *tableData;
@property(nonatomic,strong)ResultadoRutinaService *service;

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

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor ALBlueColor];
}

- (void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"ResultadoRutinaTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kCellIdentifier];
    [self createTableHeader];
    [self createTableFooter];
    [self.view addSubview:self.tableView];
}

- (void)createTableHeader{
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

//Por mock, despues borrar
- (void)userNotLoged{
    [self callService];
}


#pragma mark - Service
- (void)callService{
    [self showLoadingMessage];
    if (!self.service) {
        self.service = [ResultadoRutinaService new];
    }
    [self.service getResultadoRutinasWithBlock:^(NSObject *response,NSError *error){
        [self hideLoadingMessage];
        if (error) {
            [self showError:@"Ah ocurrido un error, por favor intente mas tarde" delegate:self];
        }else{
            self.tableData = (NSArray *)response;
            [self.tableView reloadData];
        }
    }];
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
    ResultadoRutinaTableViewCell *cell = (ResultadoRutinaTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell fillWithResultadoRutina:(ResultadoRutina *)self.tableData[indexPath.row]];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    AseguradoViewController *viewController = [[AseguradoViewController alloc] initWithNibName:nil bundle:nil];
//    viewController.persona = self.tableData[indexPath.row];
//    [self.navigationController pushViewController:viewController animated:YES];
}

@end