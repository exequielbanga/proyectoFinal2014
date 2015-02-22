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
#import "EjerciciosRutinaService.h"
#import "UIColor+ALColor.h"

#define kYOffset 5
#define kXOffset 5

@interface RutinaViewController ()<EjercicioViewDelegate>
@property(nonatomic,strong)IBOutlet UILabel *titulo;
@property(nonatomic,strong)IBOutlet UILabel *detalle;
@property(nonatomic,strong)IBOutlet UIScrollView *scrollView;

@property(nonatomic,strong)ResultadoRutina *resultadoRutina;
@end

@implementation RutinaViewController

- (void)userLoged{
    [super userLoged];
    [self callService];
}

- (void)callService{
    [[EjerciciosRutinaService new] getEjerciciosForRutina:self.rutina WithBlock:^(NSArray *response,NSError *error){
        if (!error) {
            self.rutina.ejercicios = response;
            [self updateViews];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor ALBlueColor]];
    self.title = @"";
}

- (void)setRutina:(Rutina *)rutina{
    self.resultadoRutina = [[ResultadoRutina alloc] initWithRutina:rutina];
    [self updateViews];
}
- (Rutina *)rutina{
    return self.resultadoRutina;
}

- (void)updateViews{
    self.scrollView.frame = self.view.bounds;
    
    self.titulo.text = self.rutina.nombre;
    self.titulo.frame = CGRectMake(self.titulo.frame.origin.x, self.titulo.frame.origin.y, self.scrollView.frame.size.width - self.titulo.frame.origin.x*2, self.titulo.frame.size.height);
    
    self.detalle.text = self.rutina.detalle;
    
    CGSize size = [self.detalle sizeThatFits:CGSizeMake(self.scrollView.frame.size.width - self.detalle.frame.origin.x*2, 1000)];
    self.detalle.frame = CGRectMake(self.detalle.frame.origin.x,self.detalle.frame.origin.y, self.scrollView.frame.size.width - self.detalle.frame.origin.x*2, size.height);

    CGFloat yOffset = self.detalle.frame.origin.y + self.detalle.frame.size.height;
    for (Ejercicio *ejercicio in self.rutina.ejercicios) {
        EjercicioView *ejercicioView = [EjercicioView View];
        ejercicioView.delegate = self;
        [ejercicioView fillWithEjercicio:ejercicio];
        ejercicioView.frame = CGRectMake(kXOffset, yOffset, self.scrollView.frame.size.width - kXOffset*2, ejercicioView.frame.size.height);
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
