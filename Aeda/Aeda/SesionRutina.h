//
//  SesionRutina.h
//  Aeda
//
//  Created by Jonathan Banga on 7/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AEDAModel.h"

typedef enum{
    SesionRutinaDiaLunes = 0,
    SesionRutinaDiaMartes,
    SesionRutinaDiaMiercoles,
    SesionRutinaDiaJueves,
    SesionRutinaDiaViernes,
    SesionRutinaDiaSabado,
    SesionRutinaDiaDomingo,
    SesionRutinaDiaNada,
}SesionRutinaDia;

@interface SesionRutina : AEDAModel

@property(nonatomic,assign)SesionRutinaDia dia;
@property(nonatomic,strong)NSString *hora;

- (instancetype)initWithSesionRutinaDia:(SesionRutinaDia)dia hora:(NSString *)hora;

- (NSComparisonResult)compare:(SesionRutina *)otraRutina;

@end
