//
//  RutinaEnProgresoViewController.m
//  Aeda
//
//  Created by Jonathan Banga on 8/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "RutinaEnProgresoViewController.h"
#import "HeartRate.h"
#import "StepCounter.h"
#import "HeartRate.h"
#import "ResultadoEjercicio.h"

@interface RutinaEnProgresoViewController ()<StepCounterDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)IBOutlet UILabel *nombreEjercicio;
@property(nonatomic,strong)IBOutlet UILabel *countReps;
@property(nonatomic,strong)IBOutlet UILabel *ppm;
@property(nonatomic,strong)IBOutlet UIImageView *corazon;
@property(nonatomic,strong)IBOutlet UIImageView *ejercicioCompletadoView;
@property(nonatomic,strong)IBOutlet UILabel *countdownLabel;
@property(nonatomic,strong)IBOutlet UIButton *pauseStartButton;


@property(nonatomic,assign)BOOL animandoCorazon;
@property(nonatomic,assign)BOOL pausa;
@property(nonatomic,assign)BOOL ejercicioCompletado;

@end

@implementation RutinaEnProgresoViewController

#pragma mark - Initialization
- (void)viewDidLoad {
    [super viewDidLoad];
    self.pausa = YES;
    [[StepCounter sharedStepCounter]setDelegate:self];
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

#pragma mark - Setters and Getters

- (void)setEjercicioCompletado:(BOOL)ejercicioCompletado{
    _ejercicioCompletado = ejercicioCompletado;
    self.ejercicioCompletadoView.hidden = !ejercicioCompletado;
}

- (void)setRutina:(ResultadoRutina *)rutina{
    _rutina = rutina;
    [self pausa];
    [self updateViews];
}

- (void)setEjercicioActual:(Ejercicio *)ejercicioActual{
    _ejercicioActual = ejercicioActual;
    [self pausa];
    [self updateViews];
}

#pragma mark - Views
- (void)updateViews{
    self.nombreEjercicio.text = self.ejercicioActual.nombre;
    self.ejercicioCompletado = NO;
    
    ResultadoEjercicio *resultadoEjercicio = [self resultadoEjercicioDe:self.ejercicioActual];
    self.ejercicioCompletado = resultadoEjercicio.completado;
}

- (void)animarCorazon{
    [self updateHeartRate];
    static BOOL expandir = NO;
    
    CGFloat duracion = [[HeartRate sharedHeartRate] rate]/(60*4.0);
    
    [UIView animateWithDuration:duracion animations:^{
        if (expandir) {
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

- (void)startCountdown{
    self.view.userInteractionEnabled = NO;
    self.countReps.hidden = YES;
    self.countdownLabel.text = [NSString stringWithFormat:@"%d",self.countdownLabel.text.intValue - 1];
    if (self.countdownLabel.text.intValue == 0) {
        self.countdownLabel.text = @"¡Ya!";
    }
    self.countdownLabel.transform = CGAffineTransformMakeScale(3, 3);
    self.countdownLabel.alpha = 1;

    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.countdownLabel.transform = CGAffineTransformMakeScale(.1, .1);
        self.countdownLabel.alpha = 0;
    } completion:^(BOOL completition){
        if ([self.countdownLabel.text isEqualToString:@"¡Ya!"]) {
            self.view.userInteractionEnabled = YES;
            self.countReps.hidden = NO;
            [self countdownFinish];
        }else{
            [self startCountdown];
        }
    }];
}


#pragma - mark HeartRate
- (void)updateHeartRate{
    self.ppm.text = [NSString stringWithFormat:@"%lu",(unsigned long)[[HeartRate sharedHeartRate] rate]];
}

#pragma - mark StepCounterDelegate
- (void)stepCounterDidRecogniceStep:(StepCounter *)stepCounter{
    self.countReps.text = [NSString stringWithFormat:@"%lu",(unsigned long)stepCounter.countReps];
}

#pragma mark - Logic
- (ResultadoEjercicio *)resultadoEjercicioDe:(Ejercicio *)ejercicio{
    for (ResultadoEjercicio *resultadoEjercicio in self.rutina.resultadoEjercicios) {
        if ([resultadoEjercicio.nombre isEqualToString:ejercicio.nombre]) {
            return resultadoEjercicio;
        }
    }
    return nil;
}

- (void)generarResultadoEjercicio{
    ResultadoEjercicio *resultado = [[ResultadoEjercicio alloc] initWithEjercicio:self.ejercicioActual];
    //Lógica
    resultado.completado = YES;
    [resultado.resultadoRepeticiones addObject:@([[StepCounter sharedStepCounter] countReps])];
    //
    for (NSInteger i = 0; i < self.rutina.resultadoEjercicios.count; i++) {
        ResultadoEjercicio *resultadoEjercicio = self.rutina.resultadoEjercicios[i];
        if ([resultadoEjercicio.nombre isEqualToString:self.ejercicioActual.nombre]) {
            [self.rutina.resultadoEjercicios replaceObjectAtIndex:i withObject:resultado];
            break;
        }
    }
}

- (void)countdownFinish{
    [[StepCounter sharedStepCounter] start];
}

- (void)comenzarEjercicio{
    [self.pauseStartButton removeTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    [self.pauseStartButton addTarget:self action:@selector(pause:) forControlEvents:UIControlEventTouchUpInside];
    [self.pauseStartButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    self.countdownLabel.text = @"4";
    [self startCountdown];
}

#pragma mark - Actions
- (IBAction)play:(UIButton *)button{
    if ([[self resultadoEjercicioDe:self.ejercicioActual] completado]) {
        [[[UIAlertView alloc] initWithTitle:@"Ejercicio ya completado" message:@"¿Desea realizar el ejercicio de nuevo? Perderá los resultados del mismo." delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Si", nil] show];
    }else{
        [self comenzarEjercicio];
    }
}

- (IBAction)pause:(UIButton *)button{
    [button removeTarget:self action:@selector(pause:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
    [self generarResultadoEjercicio];
    [[StepCounter sharedStepCounter] stop];
    [self updateViews];
}

- (IBAction)ff{
    NSUInteger index = [self.rutina.ejercicios indexOfObject:self.ejercicioActual];
    if (index < (self.rutina.ejercicios.count-1) && index != NSNotFound) {
        self.ejercicioActual = self.rutina.ejercicios[index+1];
    }
}

- (IBAction)rv{
    NSUInteger index = [self.rutina.ejercicios indexOfObject:self.ejercicioActual];
    if (index > 0 && index != NSNotFound) {
        self.ejercicioActual = self.rutina.ejercicios[index-1];
    }
}

#pragma mark - Actions
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != alertView.cancelButtonIndex) {
        [[self resultadoEjercicioDe:self.ejercicioActual] setCompletado:NO];
        [self updateViews];

        [self comenzarEjercicio];
    }
}

@end
