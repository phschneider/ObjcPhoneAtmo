//
//  NSDictionary+Validator.m
//  PSNetAtmo
//
//  Created by Philip Schneider on 27.07.14.
//  Copyright (c) 2014 phschneider.net. All rights reserved.
//

#import "NSDictionary+Validator.h"

@implementation NSDictionary (Validator)

- (NSString*)validateStringForKey:(NSString*)key
{
    DLogFuncName();
    
    if (![self hasKey:key])
    {
        return @"";
    }
    
    if ([self objectForKey:key])
    {
        return [self objectForKey:key];
    }
    
    return @"";
}


- (NSNumber*)validateNumberForKey:(NSString *)key
{
    DLogFuncName();
    
    if (![self hasKey:key])
    {
        return @0;
    }
    
    if ([self objectForKey:key])
    {
        return [self objectForKey:key];
    }
    
    return @0;
}


- (BOOL) hasKey:(NSString*)key
{
    DLogFuncName();
    return ([[self allKeys] containsObject:key]);
}

@end

