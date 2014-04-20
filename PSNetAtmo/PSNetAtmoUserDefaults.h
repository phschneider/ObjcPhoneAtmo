//
// Created by Philip Schneider on 05.12.13.
// Copyright (c) 2013 phschneider.net. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface PSNetAtmoUserDefaults : NSObject

+ (PSNetAtmoUserDefaults*) sharedInstance;

- (BOOL)useFahrenheit;

- (void)setUseFahrenheitAsTempUnit;

- (void)setUseCelsiusAsTempUnit;

@end