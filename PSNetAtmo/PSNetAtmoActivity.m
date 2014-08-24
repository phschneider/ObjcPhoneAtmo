//
// Created by Philip Schneider on 27.04.14.
// Copyright (c) 2014 phschneider.net. All rights reserved.
//

#import "PSNetAtmoActivity.h"


@interface PSNetAtmoActivity ()
@property(nonatomic) int processCount;
@end

@implementation PSNetAtmoActivity

static PSNetAtmoActivity * instance = nil;

+ (PSNetAtmoActivity *) sharedInstance {
    @synchronized (self)
    {
        if (instance == nil)
        {
            [PSNetAtmoActivity new];
        }
    }
    return instance;
}


- (id)init
{
    DLogFuncName();
    DEBUG_ACTIVITY_LogName();
    NSAssert(instance == nil, @"Instance of PSNetAtmoActivity alread exists");
    self = [super init];
    if (self)
    {                        
        self.processCount = 0;
    }
    instance = self;
    return self;
}


- (void) show
{
    DLogFuncName();
    DEBUG_ACTIVITY_LogName();
    self.processCount++;

    [self logProcessCount];

    [self _show];
}


- (void) _show
{
    DLogFuncName();
    DEBUG_ACTIVITY_LogName();
    if (![self isVisible])
    {
        DEBUG_ACTIVITY_Log(@"Show");
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }
}


- (void) hide
{
    DLogFuncName();
    DEBUG_ACTIVITY_LogName();
    self.processCount--;

    [self logProcessCount];
    [self _hide];
}
    

- (BOOL) canHide
{
    DLogFuncName();
    DEBUG_ACTIVITY_LogName();
    [self logProcessCount];

    return (self.processCount == 0);
}


- (BOOL) isVisible
{
    DLogFuncName();
    DEBUG_ACTIVITY_LogName();
    [self logProcessCount];

    return [[UIApplication sharedApplication] isNetworkActivityIndicatorVisible];
}


- (void) logProcessCount
{
    DLogFuncName();
    DEBUG_ACTIVITY_LogName();
    DEBUG_ACTIVITY_Log(@"ProcessCount = %d", self.processCount);
}


- (void) _hide
{
    DLogFuncName();
    DEBUG_ACTIVITY_LogName();
    [self logProcessCount];

    if ([self canHide])
    {
        DEBUG_ACTIVITY_Log(@"Hide");
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
}
@end