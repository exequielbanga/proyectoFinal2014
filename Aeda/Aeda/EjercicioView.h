//
//  ALFooterLabelView.h
//  Allianz
//
//  Created by Matías Ginart on 8/2/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ejercicio.h"

@interface EjercicioView : UIView

@property (nonatomic, strong) IBOutlet UILabel* textLabel;

+ (EjercicioView*)View;

- (void)fillWithEjercicio:(Ejercicio *)ejercicio;

@end
