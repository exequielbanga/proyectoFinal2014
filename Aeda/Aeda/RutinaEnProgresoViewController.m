//
//  RutinaEnProgresoViewController.m
//  Aeda
//
//  Created by Jonathan Banga on 8/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "RutinaEnProgresoViewController.h"
#import "HeartRate.h"

@interface RutinaEnProgresoViewController ()
@property(nonatomic,strong)IBOutlet UILabel *nombreEjercicio;
@property(nonatomic,strong)IBOutlet UIImageView *corazon;

@property(nonatomic,assign)BOOL animandoCorazon;
@property(nonatomic,assign)BOOL pausa;
@end

@implementation RutinaEnProgresoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pausa = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"Entrenando...";
    [self updateViews];
    self.animandoCorazon = YES;
    [self animarCorazon];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.animandoCorazon = NO;
}

- (void)setRutina:(ResultadoRutina *)rutina{
    _rutina = rutina;
    [self updateViews];
}

- (void)setEjercicioActual:(Ejercicio *)ejercicioActual{
    _ejercicioActual = ejercicioActual;
    [self updateViews];
}

- (void)updateViews{
    self.nombreEjercicio.text = self.ejercicioActual.nombre;
}

- (void)animarCorazon{
    static BOOL expandir = NO;
    
    CGFloat duracion = [[HeartRate sharedHeartRate] rate]/(60*4.0);
    
    [UIView animateWithDuration:duracion animations:^{
        if (expandir) {
//            CGPoint centro = self.corazon.center;
            self.corazon.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.25, 1.25);
        }else{
            self.corazon.transform = CGAffineTransformScale(CGAffineTransformIdentity,1, 1);
        }
    }];
    expandir = !expandir;
    
    if (expandir) {
        [self performSelector:@selector(animarCorazon) withObject:nil afterDelay:60*6/([[HeartRate sharedHeartRate] rate]*4.0)];
    }else{
        [self performSelector:@selector(animarCorazon) withObject:nil afterDelay:60/([[HeartRate sharedHeartRate] rate]*4.0)];
    }
}

@end
