//
// Created by Philip Schneider on 02.05.14.
// Copyright (c) 2014 phschneider.net. All rights reserved.
//

#import "PSNetAtmoAnalytics.h"


@implementation PSNetAtmoAnalytics

static PSNetAtmoAnalytics * instance = nil;

+ (PSNetAtmoAnalytics *) sharedInstance
{
    @synchronized (self) {
        if (instance == nil)
        {
            [PSNetAtmoAnalytics new];
        }
    }
    return instance;
}


- (id) init
{
    DLogFuncName();
    NSAssert(instance == nil, @"Instance of PSNetAtmoAnalytics already exists");
    self = [super init];
    if (self)
    {

    }
    instance = self;
    return self;
}


- (void) trackAuthWindow
{
    DLogFuncName();

}

@end