//
//  PSNetAtmoConverter.m
//  PSNetAtmo
//
//  Created by Philip Schneider on 03.01.14.
//  Copyright (c) 2014 phschneider.net. All rights reserved.
//

#import "PSNetAtmoConverter.h"

@implementation PSNetAtmoConverter

static PSNetAtmoConverter* instance = nil;

+ (PSNetAtmoConverter*) sharedInstance {
    @synchronized (self)
    {
        if (instance == nil)
        {
            [PSNetAtmoConverter new];
        }
    }
    return instance;
}


- (id)init
{
    DLogFuncName();
    NSAssert(!instance, @"Instance of PSNetAtmoConverter already exists!");
    self = [super init];
    if (self)
    {
        
    }
    instance = self;
    return self;
}


- (CGFloat)convertCelsiusToFahrenheit:(CGFloat)celsius
{
    DLogFuncName();
    float fahrenheit = (celsius * 1.8 + 32);
    return fahrenheit;
}



- (CGFloat)convertMeteresToMiles:(CGFloat)km
{
    DLogFuncName();
    float mi = km / 1.609344;
    return mi;
}

@end
