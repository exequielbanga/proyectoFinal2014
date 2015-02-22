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
@end
