//
//  GenericParser.m
//
//  Created by Exequiel Banga on 13/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GenericParser.h"
#import "TBXML+NSDictionary.h"

@implementation GenericParser

- (id)init {
    self = [super init];
    if (self) {
        self.resultObjects = [NSMutableArray array];
    }
    return self;
}

- (void)parse:(NSString *)data {
    NSDictionary *dictionaryData = [self dictionaryFromXMLString:data];
    NSError *error = [self errorFromDictionary:dictionaryData];
    if (error) {
        self.error = error;
    }else{
        [self parseResponse:dictionaryData];
    }
}

- (NSString *)keyPathToResponse{
    // Abstract method
    return nil;
}

- (Class)responseObjectsClass{
    // Abstract method
    return nil;
}

- (void)parseResponse:(NSDictionary *)dictionary{
    NSArray* allObjectsDictionaries = [dictionary valueForKeyPath:[self keyPathToResponse]];
    
    for (NSDictionary* objectData in allObjectsDictionaries) {
        [self.resultObjects addObject:[[[self responseObjectsClass] alloc] initWithDictionary:objectData]];
    }
}

- (NSError *)errorFromDictionary:(NSDictionary *)dictionary{
    NSDictionary *fault = [dictionary valueForKeyPath:@"soapenv:Envelope.soapenv:Body.soapenv:Fault"];
    if (fault) {
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:fault];
        userInfo[NSLocalizedFailureReasonErrorKey] = userInfo[@"detail"][@"con:fault"][@"con:reason"];
        userInfo[NSLocalizedDescriptionKey] = userInfo[@"faultstring"];
        
        NSInteger errorCode = [[[userInfo[@"detail"][@"con:fault"][@"con:errorCode"]componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""]integerValue];
        
        self.error = [NSError errorWithDomain:@"Error" code:errorCode userInfo:userInfo];
    }
    return self.error;
}

- (NSDictionary *)dictionaryFromXMLString:(NSString *)xmlString{
    return [TBXML dictionaryWithXMLData:[xmlString dataUsingEncoding:NSUTF8StringEncoding] error:nil];
}

@end
