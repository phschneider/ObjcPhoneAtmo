//
// Created by Philip Schneider on 02.05.14.
// Copyright (c) 2014 phschneider.net. All rights reserved.
//

#import "PSNetAtmoNotification.h"


@implementation PSNetAtmoNotification


static PSNetAtmoNotification *instance = nil;
+ (PSNetAtmoNotification *) sharedInstance
{
    @synchronized (self) {
        if (instance == nil)
        {
            [PSNetAtmoNotification new];
        }
    }
    return instance;
}


-(instancetype) init
{
    DLogFuncName();
    NSAssert(instance == nil, @"Instance of PSNetAtmoNotification already exists");
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(catchedNotification:) name:nil object:nil];
    }
    instance = self;
    return self;
}


- (void) catchedNotification:(NSNotification *)notification
{
    DLogFuncName();
    if (![notification.name hasPrefix:@"_UI"] && ![notification.name hasPrefix:@"UI"] && ![notification.name hasPrefix:@"NS"] && ![notification.name hasPrefix:@"_NS"])
    {
        NSLog(@"Notification = %@ \n UserInfo = %@", notification.name, notification.userInfo);
    }

//    if ([PSNETATMO_NOTIFICATIONS containsObject:note.name])
//    {
//        NSLog(@" ======= %@ ======= ",note.name);
//        NSLog(@" ===> %@ ",note.userInfo);
//    }
}


@end