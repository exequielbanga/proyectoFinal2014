//
//  ResultadoRutinaTableViewCell.h
//  Aeda
//
//  Created by Jonathan Banga on 5/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultadoRutina.h"

@interface ResultadoRutinaTableViewCell : UITableViewCell
@property(nonatomic,assign)BOOL showDate;

- (void)fillWithResultadoRutina:(ResultadoRutina *)resultadoRutina;

@end
