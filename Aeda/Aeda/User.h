//
//  User.h
//  Allianz
//
//  Created by Matías Ginart on 7/25/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AEDAModel.h"

@interface User : AEDAModel

@property (nonatomic, copy) NSString* userId;
@property (nonatomic, copy) NSString* username;
@property (nonatomic, copy) NSString* nombre;
@property (nonatomic, copy) NSString* nombre_completo;
@property (nonatomic, copy) NSString* apellido;
@property (nonatomic, copy) NSString* email;
@property (nonatomic, copy) NSString* fecha_nacimiento;
@property (nonatomic, copy) NSString* fecha_creacion;
@property (nonatomic, copy) NSString* peso;
@property (nonatomic, copy) NSString* sexo;

@end
