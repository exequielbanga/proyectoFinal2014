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
#import "ResultadoRutinaViewController.h"
#import "OrderedDictionary.h"
#import "EstadoPersonaView.h"

#define kCellIdentifier @"SeguimientoViewControllerCell"

@interface SeguimientoViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property(nonatomic,strong)EstadoPersona *estado;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *tableData;
@property(nonatomic,strong)ResultadoRutinaService *service;
@property(nonatomic,strong)MutableOrderedDictionary *sorteredTableData;
@property(nonatomic,assign)BOOL porDia;

@end

@implementation SeguimientoViewController

#pragma mark - Init stuff

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Mi Seguimiento";
        self.porDia = YES;
        [self createTableView];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor ALBlueColor];
}

- (void)createTableView{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
//    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"ResultadoRutinaTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kCellIdentifier];
    [self createTableFooter];
    [self.view addSubview:self.tableView];
}

- (void)createTableHeader{
    EstadoPersonaView *view = [EstadoPersonaView view];
    [view fillWithEstadoPersona:self.estado];
    [view.segmentedControl.firstButton addTarget:self action:@selector(setPorDia) forControlEvents:UIControlEventTouchUpInside];
    [view.segmentedControl.entryButton addTarget:self action:@selector(setPorRutina) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView.tableHeaderView = view;
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

#pragma mark - Logic
- (void)setPorDia{
    self.porDia = YES;
    [self reloadData];
}
- (void)setPorRutina{
    self.porDia = NO;
    [self reloadData];
}

- (NSDate *)dayForDate:(NSDate *)date{
    NSDateComponents* dayComponents = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:date];
    dayComponents.hour = 0;
    dayComponents.minute = 0;
    
    return [[NSCalendar currentCalendar] dateFromComponents:dayComponents];
}

- (void)reloadData{
    //Ordeno por sesion
    self.tableData = [self.tableData sortedArrayUsingComparator:^(ResultadoRutina *rutina1,ResultadoRutina *rutina2){
        return [rutina1 compare:rutina2];
    }];
    //Corte de control
    self.sorteredTableData = [MutableOrderedDictionary new];
    for (ResultadoRutina *rutina in self.tableData) {
        if (self.porDia) {
            if(!self.sorteredTableData[[self dayForDate:rutina.fecha]]){
                [self.sorteredTableData setObject:[NSMutableArray new] forKey:[self dayForDate:rutina.fecha]];
            }
            [self.sorteredTableData[[self dayForDate:rutina.fecha]] addObject:rutina];
        }else{
            if(!self.sorteredTableData[rutina.nombre]){
                [self.sorteredTableData setObject:[NSMutableArray new] forKey:rutina.nombre];
            }
            [self.sorteredTableData[rutina.nombre] addObject:rutina];
        }
    }
    
    [self.tableView reloadData];
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
            [self reloadData];
        }
    }];
    //Estado
    self.estado = [[EstadoPersona alloc] initMock];
    [self createTableHeader];
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
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.porDia) {
        NSDateFormatter *dateformatter = [NSDateFormatter new];
        dateformatter.dateFormat = @"dd/MM/YYYY";
        return [dateformatter stringFromDate:self.sorteredTableData.allKeys[section]];
    }else{
        return self.sorteredTableData.allKeys[section];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sorteredTableData.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.sorteredTableData objectForKey:self.sorteredTableData.allKeys[section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ResultadoRutinaTableViewCell *cell = (ResultadoRutinaTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ResultadoRutina *rutina = [self.sorteredTableData objectForKey:self.sorteredTableData.allKeys[indexPath.section]][indexPath.row];
    cell.showDate = !self.porDia;
    [cell fillWithResultadoRutina:rutina];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ResultadoRutinaViewController *viewController = [[ResultadoRutinaViewController alloc] initWithNibName:nil bundle:nil];
    ResultadoRutina *rutina = [self.sorteredTableData objectForKey:self.sorteredTableData.allKeys[indexPath.section]][indexPath.row];
    viewController.resultadoRutina = rutina;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end