//
//  RutinasHoyViewController.m
//  Aeda
//
//  Created by Jonathan Banga on 8/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "RutinasHoyViewController.h"
#import "RutinaTableViewCell.h"
#import "RutinaService.h"

#define kCellIdentifier @"kCellIdentifierRutina"

@interface RutinasHoyViewController ()

@end

@implementation RutinasHoyViewController

- (void)callService {
    // Debemos o no llamar al servicio?
    if (!self.tableData.count) {
        [self showLoadingMessage];
        
        [self.service getRutinasHoyWithBlock:^(NSObject *response, NSError *error) {
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

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RutinaTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell fillWithRutina:self.tableData[indexPath.row]];
    cell.showsTime = YES;
    return cell;
}

@end
