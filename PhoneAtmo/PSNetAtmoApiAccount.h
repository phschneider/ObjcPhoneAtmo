//
// Created by pschneider on 23.11.13.
//
// Copyright (c) 2013 Haus & Gross communications. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <NXOAuth2Client/NXOAuth2.h>
#import "PSNetAtmo.h"


@interface PSNetAtmoApiAccount : NSObject

+ (instancetype) sharedInstance;
- (NXOAuth2Account*) account;

- (BOOL)hasAccount;
- (BOOL)accountIsValid:(NXOAuth2Account*)oAuthAccount;
- (BOOL)currentAccountIsValid;


- (void) requestAccount;
- (void) deleteAccount;
- (void) checkAccounts;

@end