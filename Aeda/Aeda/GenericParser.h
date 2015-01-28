//
//  GenericParser.h
//
//  Created by Exequiel Banga on 5/11/14.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GenericParser : NSObject

@property(nonatomic, strong) NSMutableArray *resultObjects;
@property(nonatomic, strong) NSError *error;

- (void)parse:(NSString *)string;
- (NSError *)errorFromResponse:(id)responseObject;

//To overwrite in subclasses
- (NSString *)keyPathToResponse;
- (Class)responseObjectsClass;
- (void)parseResponse:(NSDictionary*)response;

@end
