//
//  MisDatosViewController.m
//  Allianz
//
//  Created by Jonathan Banga on 15/8/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "MisDatosViewController.h"
#import "TitleTextViewTableViewCell.h"
#import "OrderedDictionary.h"
#import "MisDatosTableViewHeader.h"
#import "UIColor+ALColor.h"
#import "UIFont+ALFonts.h"
#import "ALButton.h"
#import "LoginService.h"
#import "MisDatosService.h"
#import "User.h"

#define kCellIdentifier @"MisDatosCell"
#define kDataTitle @"kDataTitle"
#define kDataValue @"kDataValue"
#define kDataCanInteract @"DataCanInteract"
#define kNoLinkDetector @"kNoLinkDetector"

@interface MisDatosViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)LoginService *loginService;
@end

@implementation MisDatosViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Mis Datos";
        [self createTableView];
    }
    return self;
}

- (void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"TitleTextViewTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kCellIdentifier];
    
    [self.view addSubview:self.tableView];
}

- (void)createTableFooter{
    CGFloat offset = 7;
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 60)];
    [footer setBackgroundColor:[UIColor whiteColor]];
    ALButton *button = [[ALButton alloc]initWithFrame:CGRectMake(offset,offset,footer.frame.size.width - 2*offset, footer.frame.size.height - 2*offset)];
    [button setTitle:@"Cerrar Sesión" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor ALBlueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:button];
    self.tableView.tableFooterView = footer;
}

- (void)callService{
    [self showLoadingMessage];
    [[MisDatosService new]getMisDatosWithBlock:^(NSArray *response,NSError *error){
        self.persona = (User *)response[0];
        [self hideLoadingMessage];
    }];
}

- (void)userLoged{
    [super userLoged];
    [self callService];
}

- (NSString *)emptyFieldDescription{
    return @"...";
}

- (void)addField:(NSString *)fieldName value:(NSString *)value section:(NSMutableArray *)section{
    if (value && ![value isEqual:[NSNull null]] && value.length) {
        [section addObject:@{kDataTitle:fieldName,kDataValue:value}];
    }else{
        [section addObject:@{kDataTitle:fieldName,kDataValue:[self emptyFieldDescription]}];
    }

}

- (void)fillTableData{
    self.tableData = [MutableOrderedDictionary new];
    
    NSMutableArray *datosPrincipales = [NSMutableArray new];
    
    [self addField:@"Nombre" value:self.persona.nombre section:datosPrincipales];
    [self addField:@"Apellido" value:self.persona.apellido section:datosPrincipales];
    [self addField:@"Email" value:self.persona.email section:datosPrincipales];
    [self addField:@"Fecha de nacimiento" value:self.persona.fecha_nacimiento section:datosPrincipales];
    [self addField:@"Peso" value:self.persona.peso section:datosPrincipales];
    [self addField:@"Sexo" value:self.persona.sexo section:datosPrincipales];
    [self.tableData setObject:datosPrincipales forKey:@"Datos Principales"];
    [self.tableView reloadData];
}

- (void)setPersona:(User*)persona{
    _persona = persona;
    [self fillTableData];
}

#pragma mark - TableView

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MisDatosTableViewHeader* header = [MisDatosTableViewHeader header];
    [header setText:self.tableData.allKeys[section]];
    header.textLabel.textColor = [UIColor ALBlueColor];
    header.textLabel.font = [UIFont allianzSansBoldWithSize:16];
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (void)logout{
    if (!self.loginService) {
        self.loginService = [LoginService new];
    }
    [self.loginService logoutWithFinishedBlock:^(NSObject *response, NSError *error){
        if (error) {
            [self showError:@"Por favor intente mas tarde"];
        }
        [self userNotLoged];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.tableData.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.tableData objectForKey:self.tableData.allKeys[section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TitleTextViewTableViewCell *cell = (TitleTextViewTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSArray *cellData = [self.tableData objectForKey:self.tableData.allKeys[indexPath.section]];
    cell.title = cellData[indexPath.row][kDataTitle];
    cell.detail = cellData[indexPath.row][kDataValue];
    if(cellData[indexPath.row][kNoLinkDetector]){
        cell.linkDetectors = ![cellData[indexPath.row][kNoLinkDetector]boolValue];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self userNotLoged];
}

@end

