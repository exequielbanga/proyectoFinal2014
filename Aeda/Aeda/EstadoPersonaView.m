//
//  EstadoPersonaView.m
//  Aeda
//
//  Created by Jonathan Banga on 10/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "EstadoPersonaView.h"
#import "Barra.h"

@interface EstadoPersonaView()
@property(nonatomic,weak)IBOutlet Barra *objetivo;
@property(nonatomic,weak)IBOutlet Barra *resistencia;
@property(nonatomic,weak)IBOutlet Barra *fuerza;
@property(nonatomic,weak)IBOutlet Barra *flexibilidad;
@property(nonatomic,weak)IBOutlet UILabel *objetivoDescripcion;
@property(nonatomic,weak)IBOutlet UIImageView *imagen;
@property(nonatomic,weak)IBOutlet UIView *tapaimagen;
@end

@implementation EstadoPersonaView

+ (instancetype)view {
    EstadoPersonaView* view = [[NSBundle mainBundle] loadNibNamed:@"EstadoPersonaView" owner:nil options:nil][0];
    return view;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imagen.image =[[UIImage imageNamed:@"Mis_Rutinas"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.imagen.tintColor = [UIColor whiteColor];
    self.imagen.frame = CGRectMake(self.imagen.frame.origin.x, self.resistencia.frame.origin.y, self.imagen.frame.size.width, self.imagen.self.frame.size.height);
    self.segmentedControl = [ALSegmentedControl view];
    [self.segmentedControl showTwoButtons];
    [self.segmentedControl.entryButton setTitle:@"Por rutina" forState:UIControlStateNormal];
    [self addSubview:self.segmentedControl];
}

- (void)fillWithEstadoPersona:(EstadoPersona *)estado{
    [self.objetivo setValorAnimated:estado.objetivo];
    [self.fuerza setValorAnimated: estado.fuerza];
    [self.resistencia setValorAnimated:estado.resistencia];
    [self.flexibilidad setValorAnimated:estado.flexibilidad];

    self.tapaimagen.frame = CGRectMake(self.imagen.frame.origin.x, self.imagen.frame.origin.y + self.imagen.frame.size.height * (1.0 - estado.objetivo.floatValue), self.imagen.frame.size.width, self.imagen.frame.size.height * (estado.objetivo.floatValue));
    
    self.objetivoDescripcion.text = estado.detalleObjetivo;
    CGSize size = [self.objetivoDescripcion sizeThatFits:CGSizeMake(self.objetivoDescripcion.frame.size.width, 10000)];
    self.objetivoDescripcion.frame = CGRectMake(self.objetivoDescripcion.frame.origin.x,self.objetivoDescripcion.frame.origin.y, self.objetivoDescripcion.frame.size.width, size.height);

    self.segmentedControl.frame = CGRectMake(0, self.objetivoDescripcion.frame.origin.y + self.objetivoDescripcion.frame.size.height + 5, 320, 44);

//    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.objetivoDescripcion.frame.origin.y + self.objetivoDescripcion.frame.size.height + 5);
    
}


@end
