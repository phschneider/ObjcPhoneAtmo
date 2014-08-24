//
//  PSNetAtmoAccountWithLogin.m
//  PSNetAtmo
//
//  Created by Philip Schneider on 02.05.14.
//  Copyright (c) 2014 phschneider.net. All rights reserved.
//

#import "PSNetAtmoAccountWithLogin.h"

@implementation PSNetAtmoAccountWithLogin


- (void) requestAccountWithUser:(NSString*)user andPass:(NSString*)pass
{
    DLogFuncName();
    DEBUG_ACCOUNT_LogName();
    
    if (![self account])
    {
        [self checkAccounts];
        [[NXOAuth2AccountStore sharedStore] requestAccessToAccountWithType:ACCOUNT_TYPE
                                                                  username:@"USER_NAME"
                                                                  password:@"USER_PASS"];
    }
}

@end
