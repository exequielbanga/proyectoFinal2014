//
//  RutinaViewController.m
//  Aeda
//
//  Created by Jonathan Banga on 5/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "RutinaViewController.h"
#import "ResultadoRutina.h"
#import "ResultadoEjercicio.h"
#import "EjercicioView.h"
#import "RutinaEnProgresoViewController.h"

#define kYOffset 5
#define kXOffset 5

@interface RutinaViewController ()<EjercicioViewDelegate>
@property(nonatomic,strong)IBOutlet UILabel *titulo;
@property(nonatomic,strong)IBOutlet UILabel *detalle;
@property(nonatomic,strong)IBOutlet UIScrollView *scrollView;

@property(nonatomic,strong)ResultadoRutina *resultadoRutina;
@end

@implementation RutinaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    [self updateViews];
}

- (void)setRutina:(Rutina *)rutina{
    self.resultadoRutina = [[ResultadoRutina alloc] initWithRutina:rutina];
    [self updateViews];
}
- (Rutina *)rutina{
    return self.resultadoRutina;
}

- (void)updateViews{
    self.titulo.text = self.rutina.nombre;
    self.detalle.text = self.rutina.detalle;
    
    CGSize size = [self.detalle sizeThatFits:CGSizeMake(self.detalle.frame.size.width, 1000)];
    self.detalle.frame = CGRectMake(self.detalle.frame.origin.x,self.detalle.frame.origin.y, self.detalle.frame.size.width, size.height);

    CGFloat yOffset = self.detalle.frame.origin.y + self.detalle.frame.size.height;
    for (Ejercicio *ejercicio in self.rutina.ejercicios) {
        EjercicioView *ejercicioView = [EjercicioView View];
        ejercicioView.delegate = self;
        [ejercicioView fillWithEjercicio:ejercicio];
        ejercicioView.frame = CGRectMake(kXOffset, yOffset, ejercicioView.frame.size.width, ejercicioView.frame.size.height);
        yOffset = ejercicioView.frame.origin.y + ejercicioView.frame.size.height + kYOffset;
        [self.scrollView addSubview:ejercicioView];
    }
    self.scrollView.contentSize = CGSizeMake(0, yOffset);
}

- (void)ejercicioView:(EjercicioView *)view wantStartEjercicio:(Ejercicio *)ejercicio{
    RutinaEnProgresoViewController *viewController = [[RutinaEnProgresoViewController alloc]initWithNibName:@"RutinaEnProgresoViewController" bundle:nil];
    viewController.rutina = self.resultadoRutina;
    viewController.ejercicioActual = ejercicio;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
