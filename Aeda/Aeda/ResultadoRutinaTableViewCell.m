//
//  ResultadoRutinaTableViewCell.m
//  Aeda
//
//  Created by Jonathan Banga on 5/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "ResultadoRutinaTableViewCell.h"
#import "Barra.h"
#import "UIColor+ALColor.h"

@interface ResultadoRutinaTableViewCell()
@property(nonatomic,strong)IBOutlet UILabel *nombre;
@property(nonatomic,strong)IBOutlet Barra *barra;
@end

@implementation ResultadoRutinaTableViewCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    return self;
}

- (void)fillWithResultadoRutina:(ResultadoRutina *)resultadoRutina{
    self.nombre.text = resultadoRutina.nombre;
    [self.barra setValorAnimated:@(resultadoRutina.resultado)];
}


@end
