//
//  DOWModel.h
//  DOW
//
//  Created by Jonathan Banga on 5/11/14.
//  Copyright (c) 2014 DOW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AEDAModel : NSObject<NSCoding>

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary *) mappingDictionary;//La clave es la propiedad que viene del servicio. El valor es el nombre de la propiedad a setear
@end
