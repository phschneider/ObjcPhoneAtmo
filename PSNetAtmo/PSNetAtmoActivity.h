//
// Created by Philip Schneider on 27.04.14.
// Copyright (c) 2014 phschneider.net. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface PSNetAtmoActivity : NSObject


+ (PSNetAtmoActivity *)sharedInstance;

- (void)show;

- (void)hide;
@end