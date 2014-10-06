//
//  User.h
//  Allianz
//
//  Created by Matías Ginart on 7/25/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, copy) NSString* userId;
@property (nonatomic, copy) NSString* firstname;
@property (nonatomic, copy) NSString* lastname;
@property (nonatomic, copy) NSString* username;
@property (nonatomic, copy) NSString* password;
@property (nonatomic, copy) NSString* email;

- (id)initWithDictionary:(NSDictionary*)dictionary;


@end