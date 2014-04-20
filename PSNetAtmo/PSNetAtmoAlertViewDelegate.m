//
//  PSNetAtmoAlertViewDelegate.m
//  PSNetAtmo
//
//  Created by Philip Schneider on 19.01.14.
//  Copyright (c) 2014 phschneider.net. All rights reserved.
//

#import "PSNetAtmoUserDefaults.h"
#import "PSNetAtmoAlertViewDelegate.h"
#import "PSNetAtmoNotifications.h"

#ifndef CONFIGURATION_AppStore
    #import "TestFlight.h"
#endif

@implementation PSNetAtmoAlertViewDelegate

static PSNetAtmoAlertViewDelegate* instance = nil;
+ (PSNetAtmoAlertViewDelegate*) sharedInstance {
    @synchronized (self)
    {
        if (instance == nil)
        {
            [PSNetAtmoAlertViewDelegate new];
        }
    }
    return instance;
}


- (id) init
{
    DLogFuncName();
    NSAssert(!instance, @"Instance of PSNetAtmoAlertViewDelegate already exists");
    self = [super init];
    if (self)
    {

    }
    instance = self;
    return self;
}


#pragma mark - AlertView
// Sent to the delegate when the user clicks a button on an alert view.
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    DLogFuncName();
    if ([[alertView.title lowercaseString] isEqualToString:@"filter"])
    {
       
    }
}


@end
