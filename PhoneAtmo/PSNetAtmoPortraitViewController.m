//
// Created by Philip Schneider on 27.04.14.
// Copyright (c) 2014 phschneider.net. All rights reserved.
//

#import "PSNetAtmoPortraitViewController.h"


@implementation PSNetAtmoPortraitViewController

- (NSUInteger)supportedInterfaceOrientations
{
    DLogFuncName();
    return UIInterfaceOrientationMaskPortrait;
}

@end