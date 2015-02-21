//
//  Rutina.m
//  Aeda
//
//  Created by Jonathan Banga on 5/10/14.
//  Copyright (c) 2014 Solbest. All rights reserved.
//

#import "Rutina.h"
#import "Ejercicio.h"
#import "SesionRutina.h"
@implementation Rutina

- (NSDictionary *)mappingDictionary{
    return @{
             @"descripcion": @"detalle",
             @"id":@"rutinaId"
             };
}

- (void)setDetalle:(NSString *)detalle{
    if (![detalle isKindOfClass:[NSString class]]) {
        _detalle = @"";
    }else{
        _detalle = detalle;
    }
}

- (NSString *)detalleCorto{
    return self.detalle;
}

- (void)setUsuarioRutina:(NSDictionary *)dictionary{
    self.usuarioRutinas = [NSMutableArray new];
    for (NSString *key in [dictionary allKeys]) {
        NSString *valor = dictionary[key];
        if ([valor length] && ![valor isEqualToString:@"0"]) {
            SesionRutinaDia dia = SesionRutinaDiaNada;
            if ([key isEqualToString:@"lunes"]) {
                dia = SesionRutinaDiaLunes;
            }else if ([key isEqualToString:@"martes"]) {
                dia = SesionRutinaDiaMartes;
            }else if ([key isEqualToString:@"miercoles"]) {
                dia = SesionRutinaDiaMiercoles;
            }else if ([key isEqualToString:@"jueves"]) {
                dia = SesionRutinaDiaJueves;
            }else if ([key isEqualToString:@"viernes"]) {
                dia = SesionRutinaDiaViernes;
            }else if ([key isEqualToString:@"sabado"]) {
                dia = SesionRutinaDiaSabado;
            }else if ([key isEqualToString:@"domingo"]) {
                dia = SesionRutinaDiaDomingo;
            }
            if (dia != SesionRutinaDiaNada) {
                SesionRutina *sesion = [[SesionRutina alloc]initWithSesionRutinaDia:dia hora:valor];
                [self.usuarioRutinas addObject:sesion];
            }
            
        }
    }
}


- (instancetype)initMock{
    self = [self init];
    if (self) {
        switch (arc4random()%5) {
            case 0:
                self.nombre = @"Brazos Inicial";
                break;
            case 1:
                self.nombre = @"Abdominales Intermedio";
                break;
            case 2:
                self.nombre = @"Aeróbico";
                break;
            case 3:
                self.nombre = @"Piernas";
                break;
            case 4:
                self.nombre = @"Boxeo";
                break;
        }
        
//        self.sesion = [[SesionRutina alloc] initMock];
        
        self.detalle = @"Esta rutina es ideal para comenzar a trabajar los músculos de ambos brazos. Se recomienda realizarla como máximo dos veces a la semana.";
        self.detalleCorto = @"Esta rutina es ideal para comenzar a trabajar los músculos de ambos brazos.";
        NSMutableArray *ejercicios = [NSMutableArray new];

        Ejercicio *ej1 = [[Ejercicio alloc] initMock];
        [ejercicios addObject:ej1];

        Ejercicio *ej2 = [[Ejercicio alloc] initMock];
        ej2.nombre = @"Tríceps";
        [ejercicios addObject:ej2];

        Ejercicio *ej3 = [[Ejercicio alloc] initMock];
        ej3.nombre = @"Patada de Burro";
        [ejercicios addObject:ej3];
        
        self.ejercicios = ejercicios;
    }
    return self;
}

@end
