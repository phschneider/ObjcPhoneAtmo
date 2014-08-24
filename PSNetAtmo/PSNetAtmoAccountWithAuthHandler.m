//
//  PSNetAtmoAccountWithAuthHandler.m
//  PSNetAtmo
//
//  Created by Philip Schneider on 02.05.14.
//  Copyright (c) 2014 phschneider.net. All rights reserved.
//

#import "PSNetAtmoAccountWithAuthHandler.h"

@implementation PSNetAtmoAccountWithAuthHandler

#warning todo - spinning wheel ...
static PSNetAtmoAccountWithAuthHandler * instance = nil;

+ (PSNetAtmoAccountWithAuthHandler*) sharedInstance {
    @synchronized (self)
    {
        if (instance == nil)
        {
            [PSNetAtmoAccountWithAuthHandler new];
        }
    }
    return instance;
}


- (instancetype)init
{
    DLogFuncName();
    DEBUG_ACCOUNT_LogName();
    
    self = [super init];
    if (self)
    {
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accountStoreDidChange:) name:NXOAuth2AccountStoreAccountsDidChangeNotification object: [NXOAuth2AccountStore sharedStore]];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accountStoreDidFailToRequestAccess:) name:NXOAuth2AccountStoreDidFailToRequestAccessNotification object:[NXOAuth2AccountStore sharedStore]];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accountStoreNewAccountUser:) name:NXOAuth2AccountStoreNewAccountUserInfoKey object: [NXOAuth2AccountStore sharedStore]];
//        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accountStoreRedirect:) name:PSNETATMO_RECEIVED_REDIRECT_URL object:nil];
//        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
//
//        NSSortDescriptor * sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"accessToken.expiresAt" ascending:YES selector:@selector(compare:)];
//        NSArray * unsortedArray = [[NXOAuth2AccountStore sharedStore] accounts];
//        
//        self.oAuthAccount = [[unsortedArray sortedArrayUsingDescriptors:@[sortDescriptor]] lastObject];
//        DEBUG_ACCOUNT_Log(@"Accounts = %@",[unsortedArray sortedArrayUsingDescriptors:@[sortDescriptor]]);
//        DEBUG_ACCOUNT_Log(@"Account = %@",self.oAuthAccount);
    }
    instance = self;
    return self;
}


// Hier dürfen wir erst rein wenn die VIEW soweit ist ...
- (void) requestAccountWithPreparedAuthorizationURLHandler
{
    DLogFuncName();
    DEBUG_ACCOUNT_LogName();
    
//    for (NXOAuth2Account *account in [[NXOAuth2AccountStore sharedStore] accounts])
//    {
//        account.accessToken = nil;
//    }
    [[NXOAuth2AccountStore sharedStore] requestAccessToAccountWithType:ACCOUNT_TYPE
                                   withPreparedAuthorizationURLHandler:^(NSURL *preparedURL) {
                                       [[NSNotificationCenter defaultCenter] postNotificationName:PSNETATMO_RECEIVED_AUTH_URL object:nil userInfo:@{ @"url" : preparedURL} ];
                                   }];
}

@end
