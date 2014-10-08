//
//  SesionRutina.h
//  Aeda
//
//  Created by Jonathan Banga on 7/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    SesionRutinaDiaLunes = 0,
    SesionRutinaDiaMartes,
    SesionRutinaDiaMiercoles,
    SesionRutinaDiaJueves,
    SesionRutinaDiaViernes,
    SesionRutinaDiaSabado,
    SesionRutinaDiaDomingo,
}SesionRutinaDia;

@interface SesionRutina : NSObject

@property(nonatomic,assign)SesionRutinaDia dia;
@property(nonatomic,strong)NSDate *hora;

- (instancetype)initWithDictionary;
- (instancetype)initMock;

- (NSComparisonResult)compare:(SesionRutina *)otraRutina;

@end
