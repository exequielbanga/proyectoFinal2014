//
//  RestService.h
//  Allianz
//
//  Created by Exequiel Banga on 5/11/14.
//  Copyright (c) 2014 Exequiel Banga. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum  {
    RestMethodGET = 0,
    RestMethodPOST,
    RestMethodPUT
} RestMethod;

typedef void (^ServiceBlock)(NSArray *response, NSError * error);

@interface RestService : NSObject

@property (nonatomic, strong) NSString* path;
@property (nonatomic, strong) NSDictionary* queryParams;
@property (nonatomic, strong) NSDictionary* bodyParams;
@property (nonatomic) BOOL isRunning;
@property (nonatomic, strong) NSString* specificUri;

- (void)requestWithServiceBlock:(ServiceBlock)serviceBlock;

- (void)invalidate;

- (BOOL)shouldUpdateCache;//Sobreescribir con la lógica de actualización de caché (Tiempo, llamar a otro servicio, etc)

- (BOOL)isAuthenticated;

@end
