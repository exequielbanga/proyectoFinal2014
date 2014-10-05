//
//  RestService.h
//  Allianz
//
//  Created by Matías Ginart on 8/14/14.
//  Copyright (c) 2014 Matías Ginart. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum  {
    RestMethodGET = 0,
    RestMethodPOST,
    RestMethodPUT
} RestMethod;

typedef void (^ServiceBlock)(NSObject *response, NSError * error);

@interface RestService : NSObject

// El path del servicio en question (cuestion)
@property (nonatomic, strong) NSString* path;
@property (nonatomic, strong) NSDictionary* queryParams;
@property (nonatomic, strong) NSDictionary* bodyParams;
@property (nonatomic) BOOL isRunning;

- (void)requestWithServiceBlock:(ServiceBlock)serviceBlock;

- (void)invalidate;

@end
