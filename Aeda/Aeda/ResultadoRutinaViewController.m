//
//  ResultadoRutinaViewController.m
//  Aeda
//
//  Created by Jonathan Banga on 6/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "ResultadoRutinaViewController.h"
#import "ResultadoEjercicioView.h"
#import "UIColor+ALColor.h"

#define kYOffset 5
#define kXOffset 5
#define kEjercicioViewHeight 230

@interface ResultadoRutinaViewController ()
@property (nonatomic,strong) UILabel *titulo;
@property (nonatomic,strong) UILabel *detalle;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *vistasResultadosEjercicios;
@end

@implementation ResultadoRutinaViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.vistasResultadosEjercicios = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Resultado";
    self.view.backgroundColor = [UIColor ALBlueColor];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height-20)];
    [self.view addSubview:self.scrollView];

    self.titulo = [[UILabel alloc] initWithFrame:CGRectMake(kXOffset, 0, self.scrollView.frame.size.width - kXOffset*2, 44)];
    self.titulo.font = [UIFont boldSystemFontOfSize:17];
    self.titulo.textColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.titulo];

    self.detalle = [[UILabel alloc] initWithFrame:CGRectMake(kXOffset,self.titulo.frame.size.height + kYOffset, self.scrollView.frame.size.width - kXOffset*2, 44)];
    self.detalle.textColor = [UIColor whiteColor];
    self.detalle.numberOfLines = 0;
    [self.scrollView addSubview:self.detalle];
    [self updateViews];
}

- (void)setResultadoRutina:(ResultadoRutina *)resultadoRutina{
    _resultadoRutina = resultadoRutina;
    [self updateViews];
}

- (void)updateViews{
    self.titulo.text = self.resultadoRutina.nombre;
    
    self.detalle.text = self.resultadoRutina.detalle;
    CGSize size = [self.detalle sizeThatFits:CGSizeMake(self.scrollView.frame.size.width - kXOffset*2, 1000)];
    self.detalle.frame = CGRectMake(kXOffset, self.titulo.frame.size.height + kYOffset, self.scrollView.frame.size.width - kXOffset*2, size.height);
    
    [self.vistasResultadosEjercicios removeAllObjects];
    CGFloat yOffset = self.detalle.frame.origin.y + self.detalle.frame.size.height + kYOffset;
    for (ResultadoEjercicio *resultadoEjercicio in self.resultadoRutina.resultadoEjercicios) {
        ResultadoEjercicioView *vista = [[ResultadoEjercicioView alloc] initWithFrame:CGRectMake(0, yOffset, self.scrollView.frame.size.width, kEjercicioViewHeight)];
        yOffset = vista.frame.origin.y + vista.frame.size.height + kYOffset;
        [self.vistasResultadosEjercicios addObject:vista];
        [self.scrollView addSubview:vista];
        [vista fillWithResultadoEjercicio:resultadoEjercicio];
    }
    self.scrollView.contentSize = CGSizeMake(0, yOffset);
}

@end
