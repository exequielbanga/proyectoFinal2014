//
//  RutinasListByDayViewController.m
//  Aeda
//
//  Created by Jonathan Banga on 7/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "RutinasListByDayViewController.h"
#import "OrderedDictionary.h"
#import "RutinaTableViewCell.h"
#import "RutinaViewController.h"

#define kCellIdentifier @"kCellIdentifierRutina"

@interface RutinasListByDayViewController()
@property(nonatomic,strong)MutableOrderedDictionary *sorteredTableData;
@end

@implementation RutinasListByDayViewController

- (void)reloadData {
    //Ordeno por sesion
//    self.tableData = [self.tableData sortedArrayUsingComparator:^(Rutina *rutina1,Rutina *rutina2){
//        return [rutina1.sesion compare:rutina2.sesion];
//    }];
//    //Corte de control
//    self.sorteredTableData = [MutableOrderedDictionary new];
//    for (Rutina *rutina in self.tableData) {
//        if(!self.sorteredTableData[@(rutina.sesion.dia)]){
//            [self.sorteredTableData setObject:[NSMutableArray new] forKey:@(rutina.sesion.dia)];
//        }
//        [self.sorteredTableData[@(rutina.sesion.dia)] addObject:rutina];
//    }
    
    [super reloadData];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title;
    
    switch ([self.sorteredTableData.allKeys[section] intValue]) {
        case SesionRutinaDiaLunes:
            title = @"Lunes";
            break;
        case SesionRutinaDiaMartes:
            title = @"Martes";
            break;
        case SesionRutinaDiaMiercoles:
            title = @"Miércoles";
            break;
        case SesionRutinaDiaJueves:
            title = @"Jueves";
            break;
        case SesionRutinaDiaViernes:
            title = @"Viernes";
            break;
        case SesionRutinaDiaSabado:
            title = @"Sábado";
            break;
        case SesionRutinaDiaDomingo:
            title = @"Domingo";
            break;
    }
    return title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sorteredTableData[self.sorteredTableData.allKeys[section]] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sorteredTableData.allKeys.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RutinaTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell fillWithRutina:self.sorteredTableData[self.sorteredTableData.allKeys[indexPath.section]][indexPath.row]];
    cell.showsTime = YES;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RutinaViewController* rutinaViewController = [[RutinaViewController alloc] initWithNibName:nil bundle:nil];
    [rutinaViewController setRutina:self.sorteredTableData[self.sorteredTableData.allKeys[indexPath.section]][indexPath.row]];
    [self.navigationController pushViewController:rutinaViewController animated:YES];
}

@end
