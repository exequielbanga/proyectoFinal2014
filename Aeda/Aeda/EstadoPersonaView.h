//
//  EstadoPersonaView.h
//  Aeda
//
//  Created by Jonathan Banga on 10/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EstadoPersona.h"
#import "ALSegmentedControl.h"

@interface EstadoPersonaView : UIView

@property(nonatomic,strong)ALSegmentedControl *segmentedControl;

- (void)fillWithEstadoPersona:(EstadoPersona *)estado;

+ (instancetype)view;

@end
