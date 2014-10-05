//
//  Asegurado.m
//  Allianz
//
//  Created by Matías Ginart on 7/21/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import "Persona.h"

@implementation Persona



-(NSString *) randomStringWithLength: (int) len {
    
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((int)[letters length]) % [letters length]]];
    }
    
    return randomString;
}
- (instancetype)initMock{
    self = [self init];
    if (self) {
        self.nombre = [self randomStringWithLength:10 + arc4random()%7];
        self.personaId = [self randomStringWithLength:10];
    }
    return self;
}


- (id)initWithDictionary:(NSDictionary*)dictionary {
    self = [super init];
    if (self) {
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];

        self.personaId = dictionary[[NSString stringWithFormat:@"%@%@",[self parseKey],@"idPersona"]];
        self.personaContactoId = dictionary[[NSString stringWithFormat:@"%@%@",[self parseKey],@"idPersonaContacto"]];
        self.nombre = dictionary[[NSString stringWithFormat:@"%@%@",[self parseKey],@"nombre"]];
        self.apellido = dictionary[[NSString stringWithFormat:@"%@%@",[self parseKey],@"apellido"]];

        if (dictionary[[NSString stringWithFormat:@"%@%@",[self parseKey],@"sexo"]]) {
            if ([dictionary[[NSString stringWithFormat:@"%@%@",[self parseKey],@"sexo"]] isEqualToString:@"H"]) {
                self.sexo = SexoMasculino;
            } else {
                self.sexo = SexoFemenino;
            }
        } else {
            self.sexo = SexoIndefinido;
        }

        self.fechaNacimiento = [dateFormatter dateFromString:dictionary[[NSString stringWithFormat:@"%@%@",[self parseKey],@"fechaNacimiento"]]];
    }
    return self;
}

- (NSString *)parseKey{
    return @"per:";
}


@end
