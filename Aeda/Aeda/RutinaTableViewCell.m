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
@property(nonatomic,strong)IBOutlet UILabel *hora;
@end

@implementation RutinaTableViewCell

- (void)fillWithRutina:(Rutina *)rutina{
    self.nombre.text = rutina.nombre;
    self.detalle.text = rutina.detalleCorto;
//    self.hora.text = rutina.sesion.hora;
    self.hora.hidden = !self.showsTime;
}

- (void)setShowsTime:(BOOL)showsTime{
    _showsTime = showsTime;
    self.hora.hidden = !showsTime;
}

@end
