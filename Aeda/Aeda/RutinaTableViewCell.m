//
//  RutinaTableViewCell.m
//  Aeda
//
//  Created by Jonathan Banga on 7/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "RutinaTableViewCell.h"

@interface RutinaTableViewCell()
@property(nonatomic,strong)IBOutlet UILabel *nombre;
@property(nonatomic,strong)IBOutlet UILabel *detalle;
@end

@implementation RutinaTableViewCell

- (void)fillWithRutina:(Rutina *)rutina{
    self.nombre.text = rutina.nombre;
    self.detalle.text = rutina.detalleCorto;
}

@end
