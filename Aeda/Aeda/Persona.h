//
//  Asegurado.h
//  Allianz
//
//  Created by Matías Ginart on 7/21/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef  enum {
    SexoFemenino = 0,
    SexoMasculino,
    SexoIndefinido
} Sexo;

@interface Persona : NSObject

@property (nonatomic, copy) NSString* personaId;
@property (nonatomic, copy) NSString* personaContactoId;
@property (nonatomic, copy) NSString* nombre;
@property (nonatomic, copy) NSString* apellido;
@property (nonatomic) Sexo sexo;
@property (nonatomic, strong) NSDate* fechaNacimiento;
@property (nonatomic, strong) NSMutableArray* domicilios;
@property (nonatomic, strong) NSMutableArray* profesiones;
@property (nonatomic, strong) NSMutableArray* telefonos;
@property (nonatomic, strong) NSMutableArray* mails;
@property (nonatomic, strong) NSMutableArray* documentos;

- (id)initWithDictionary:(NSDictionary*)dictionary;

- (NSString *)parseKey;

- (instancetype)initMock;

@end
