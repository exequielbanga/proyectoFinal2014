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

@interface RutinaEnProgresoViewController ()<StepCounterDelegate>
@property(nonatomic,strong)IBOutlet UILabel *nombreEjercicio;
@property(nonatomic,strong)IBOutlet UILabel *countReps;
@property(nonatomic,strong)IBOutlet UILabel *ppm;
@property(nonatomic,strong)IBOutlet UIImageView *corazon;

@property(nonatomic,strong)IBOutlet UILabel *countdownLabel;

@property(nonatomic,assign)BOOL animandoCorazon;
@property(nonatomic,assign)BOOL pausa;

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

- (void)setRutina:(ResultadoRutina *)rutina{
    _rutina = rutina;
    [self updateViews];
}

- (void)setEjercicioActual:(Ejercicio *)ejercicioActual{
    _ejercicioActual = ejercicioActual;
    [self updateViews];
}

#pragma mark - Views
- (void)updateViews{
    self.nombreEjercicio.text = self.ejercicioActual.nombre;
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

#pragma mark - Actions

- (void)countdownFinish{
    [[StepCounter sharedStepCounter] start];
}

- (IBAction)play:(UIButton *)button{
    [button removeTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(pause:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    self.countdownLabel.text = @"4";
    [self startCountdown];
}

- (IBAction)pause:(UIButton *)button{
    [button removeTarget:self action:@selector(pause:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
    [[StepCounter sharedStepCounter] stop];
}

- (IBAction)ff{
    
}

- (IBAction)rv{
    
}



@end
