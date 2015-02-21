//
//  DOWModel.m
//  DOW
//
//  Created by Jonathan Banga on 5/11/14.
//  Copyright (c) 2014 DOW. All rights reserved.
//

#import "AEDAModel.h"
#import <objc/runtime.h>

@implementation AEDAModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    for (NSString *key in dictionary.allKeys) {
        NSString *actualKey = [self.mappingDictionary objectForKey:key];
        if (!actualKey) {
            actualKey = key;
        }
        
        NSString *selectorName = [NSString stringWithFormat:@"set%2@:",[actualKey stringByReplacingCharactersInRange:NSMakeRange(0,1)withString:[[actualKey substringToIndex:1] capitalizedString]]];
        
        if ([self respondsToSelector:NSSelectorFromString(selectorName)]) {
            NoLeakWarning([self performSelector:NSSelectorFromString(selectorName) withObject:dictionary[key]]);
        }
    }
    return self;
}

- (NSDictionary *) mappingDictionary{
    return nil;
}

#pragma mark - encoding
- (id)initWithCoder:(NSCoder*)coder {
    self = [super init];
    if (self) {
        NSArray *properties = [self allPropertyNames];
        
        for (NSString *property in properties) {
            
            id attribute = [coder decodeObjectForKey:property];
            
            if(attribute){
                [self setValue:attribute forKey:property];
            }
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    NSArray *properties = [self allPropertyNames];
    
    for (NSString *property in properties) {
        
        id attribute = [self valueForKey:property];
        
        if(attribute){
            [aCoder encodeObject:attribute forKey:property];
        }
    }
}


- (NSArray *)allPropertyNames
{
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    NSMutableArray *rv = [NSMutableArray array];
    
    unsigned i;
    for (i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        NSString *name = [NSString stringWithUTF8String:property_getName(property)];
        [rv addObject:name];
    }
    
    free(properties);
    
    return rv;
}

- (void *)pointerOfIvarForPropertyNamed:(NSString *)name
{
    objc_property_t property = class_getProperty([self class], [name UTF8String]);
    
    const char *attr = property_getAttributes(property);
    const char *ivarName = strchr(attr, 'V') + 1;
    
    Ivar ivar = object_getInstanceVariable(self, ivarName, NULL);
    
    return (char *)self + ivar_getOffset(ivar);
}

@end
