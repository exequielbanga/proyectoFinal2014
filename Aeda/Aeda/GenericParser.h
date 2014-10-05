//
//  GenericParser.h
//
//  Created by Exequiel Banga on 13/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kErrorCode @"ErrorCode"
#define kErrorValue @"ErrorValue"

@interface GenericParser : NSObject

@property(nonatomic, strong) NSMutableArray *resultObjects;
@property(nonatomic, strong) NSError *error;

- (void)parse:(NSString *)string;
- (NSDictionary *)dictionaryFromXMLString:(NSString *)xmlString;
- (NSError *)errorFromDictionary:(NSDictionary *)dictionary;

//To overwrite in subclasses
- (NSString *)keyPathToResponse;
- (Class)responseObjectsClass;
- (void)parseResponse:(NSDictionary*)response;

@end
