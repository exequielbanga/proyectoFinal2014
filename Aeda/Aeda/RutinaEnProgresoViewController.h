//
//  RutinaEnProgresoViewController.h
//  Aeda
//
//  Created by Jonathan Banga on 8/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "ALViewController.h"
#import "ResultadoRutina.h"
#import "Ejercicio.h"

@interface RutinaEnProgresoViewController : ALViewController
@property(nonatomic,strong)ResultadoRutina *rutina;
@property(nonatomic,strong)Ejercicio *ejercicioActual;
@end
