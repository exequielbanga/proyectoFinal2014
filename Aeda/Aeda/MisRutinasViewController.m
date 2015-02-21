//
//  MessagesViewController.m
//  Allianz
//
//  Created by Matías Ginart on 8/22/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "MisRutinasViewController.h"
#import "UIColor+ALColor.h"
#import "ALSegmentedControl.h"
#import "RutinasListByDayViewController.h"
#import "RutinasHoyViewController.h"

@interface MisRutinasViewController ()
@property (nonatomic, strong) ALSegmentedControl* segmentedControl;
@property (nonatomic, weak) IBOutlet UIView* segmentedSuperview;
@property (nonatomic, weak) IBOutlet UIView* containerView;

@property (nonatomic, strong) RutinasListByDayViewController *rutinasPorDia;
@property (nonatomic, strong) RutinasListViewController *todasLasRutinas;
@property (nonatomic, strong) UIViewController* currentViewController;

@end

@implementation MisRutinasViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.title = @"Mis Rutinas";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor ALLilaColor];
    self.containerView.backgroundColor = [UIColor ALLilaColor];

    self.segmentedControl = [ALSegmentedControl view];
    self.segmentedControl.frame = CGRectMake(0, 0, self.segmentedSuperview.frame.size.width, self.segmentedSuperview.frame.size.height);
    self.segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.segmentedSuperview addSubview:self.segmentedControl];

    
    [self.segmentedControl.entryButton addTarget:self action:@selector(showRutinasPorDia) forControlEvents:UIControlEventTouchUpInside];
    [self.segmentedControl.sentButton addTarget:self action:@selector(showTodasLasRutinas) forControlEvents:UIControlEventTouchUpInside];

    [self showTodasLasRutinas];
}

- (void)showViewController:(UIViewController*)newViewController {
    [self.currentViewController viewWillDisappear:YES];
    [newViewController viewWillAppear:YES];

    [self addChildViewController:newViewController];
    newViewController.view.frame = CGRectMake(0, 0, self.containerView.frame.size.width, self.containerView.frame.size.height);
    [self.containerView insertSubview:newViewController.view atIndex:0];
    [self.currentViewController.view removeFromSuperview];
    [self.currentViewController removeFromParentViewController];

    [self.currentViewController viewDidDisappear:YES];
    [newViewController viewDidAppear:YES];
    self.currentViewController = newViewController;
}

- (void)showRutinasPorDia {
    if (!self.rutinasPorDia) {
        self.rutinasPorDia = [[RutinasListByDayViewController alloc] initWithNibName:@"RutinasListViewController" bundle:nil];
        self.rutinasPorDia.isEntryListing = NO;
    }
    
    if (self.currentViewController == self.rutinasPorDia) {
        return;
    }
    [self showViewController:self.rutinasPorDia];
}

- (void)showTodasLasRutinas {
    if (!self.todasLasRutinas) {
        self.todasLasRutinas = [[RutinasListViewController alloc] initWithNibName:@"RutinasListViewController" bundle:nil];
        self.todasLasRutinas.isEntryListing = YES;
    }
    
    if (self.currentViewController == self.todasLasRutinas) {
        return;
    }
    [self showViewController:self.todasLasRutinas];
}

@end
