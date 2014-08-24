//
// Created by pschneider on 23.11.13.
//
// Copyright (c) 2013 Haus & Gross communications. All rights reserved.
//


#import "PSNetAtmoApiAccount.h"
#import "PSNetAtmoUser+Helper.h"
#import "PSNetAtmo.h"
#import "PSAppDelegate.h"

@interface PSNetAtmoApiAccount ()
@property (nonatomic, strong)  NXOAuth2Account  * oAuthAccount;
@end


@implementation PSNetAtmoApiAccount

static PSNetAtmoApiAccount * instance= nil;

+ (PSNetAtmoApiAccount *) sharedInstance {
    @synchronized (self)
    {
        if (instance == nil)
        {
            [PSNetAtmoApiAccount new];
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
        [self addAccountsFromDatabaseToAccountStore];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accountStoreDidChange:) name:NXOAuth2AccountStoreAccountsDidChangeNotification object: [NXOAuth2AccountStore sharedStore]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accountStoreDidFailToRequestAccess:) name:NXOAuth2AccountStoreDidFailToRequestAccessNotification object:[NXOAuth2AccountStore sharedStore]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accountStoreNewAccountUser:) name:NXOAuth2AccountStoreNewAccountUserInfoKey object: [NXOAuth2AccountStore sharedStore]];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accountStoreRedirect:) name:PSNETATMO_RECEIVED_REDIRECT_URL object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];

        [self loadAccountsFromAccountStore];
    }
    instance = self;
    return self;
}


- (void) addAccountsFromDatabaseToAccountStore
{
    DLogFuncName();
    DEBUG_ACCOUNT_LogName();

    int numberOfAccountsAddedFromDatabase = 0;
    int numberOfAccountsInDatabase = 0;
    for (PSNetAtmoUser *user in [PSNetAtmoUser allUsersInContext:APPDELEGATE.managedObjectContext])
    {
        if (user.oAuthAccountData)
        {
            numberOfAccountsInDatabase++;
            NXOAuth2Account *account = [user oAuthAccount];
            if ( ![[[NXOAuth2AccountStore sharedStore] accounts] containsObject:account])
            {
                DEBUG_ACCOUNT_Log(@"ADD oAuthAccpount = %@",_oAuthAccount);
                numberOfAccountsAddedFromDatabase++;
                [[NXOAuth2AccountStore sharedStore] addAccount:account];
            }
            DEBUG_ACCOUNT_Log(@"oAuthAccpount = %@",_oAuthAccount);
        }
    }
    
    DEBUG_ACCOUNT_Log(@"Added %d of %d Accounts",numberOfAccountsAddedFromDatabase, numberOfAccountsInDatabase);
}


- (void) loadAccountsFromAccountStore
{
    DLogFuncName();
    DEBUG_ACCOUNT_LogName();
    
    NSSortDescriptor * sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"accessToken.expiresAt" ascending:YES selector:@selector(compare:)];
    NSArray * unsortedArray = [[NXOAuth2AccountStore sharedStore] accounts];
    
    self.oAuthAccount = [[unsortedArray sortedArrayUsingDescriptors:@[sortDescriptor]] lastObject];
    DEBUG_ACCOUNT_Log(@"Accounts = %@",[unsortedArray sortedArrayUsingDescriptors:@[sortDescriptor]]);
    DEBUG_ACCOUNT_Log(@"Account = %@",self.oAuthAccount);
}


- (void) appDidBecomeActive:(NSNotification *)notification
{
    DLogFuncName();
    DEBUG_ACCOUNT_LogName();
    
// Muss immer durchgeführt werden, das ist die configuration welche benötigt wird ...
    [[NXOAuth2AccountStore sharedStore] setClientID:CLIENT_ID
                                             secret:CLIENT_SECRET
                                   authorizationURL:[NSURL URLWithString:AUTH_URL]
                                           tokenURL:[NSURL URLWithString:REQUEST_TOKEN]
                                        redirectURL:[NSURL URLWithString:@"http://phoneatmoapp.com"]
                                     forAccountType:ACCOUNT_TYPE];
    
    if ([self hasAccount])
    {
        [PSNetAtmoApi user];
    }
}


- (void) accountStoreNewAccountUser:(NSNotification *)notification
{
    DLogFuncName();
    DEBUG_ACCOUNT_LogName();
    
}

// Accounts sind immer eine Stunde gültig...
// <NXOAuth2Account identifier:'340DEB68-8369-4032-A1B6-C1FBA6D5A49F' accountType:'PhoneAtmo' accessToken:<NXOAuth2Token token:5165a31f187759e7a1000035|210ca45bc57514f5cef863616cb10317 refreshToken:5165a31f187759e7a1000035|62c2316c3612e5f2061f26f94b53d6dd expiresAt:2014-05-02 23:47:08 +0000 tokenType: OAuth> userData:(null)>
- (void) accountStoreDidChange:(NSNotification *)notification
{
    DLogFuncName();
    DEBUG_ACCOUNT_LogName();

    // Update your UI
    // Step 2 - We ve got access
    // Hier wird der Account neu gesetzt!!!
    [self checkAccounts];

    self.oAuthAccount =  [[notification userInfo] objectForKey:@"NXOAuth2AccountStoreNewAccountUserInfoKey"];
    DEBUG_ACCOUNT_Log(@"%@",[[notification userInfo] objectForKey:@"NXOAuth2AccountStoreNewAccountUserInfoKey"]);

    [[NSNotificationCenter defaultCenter] postNotificationName:PSNETATMO_ACCOUNT_UPDATE_NOTIFICATION object:nil];
    [PSNetAtmoApi user];
}


- (void) accountStoreDidFailToRequestAccess:(NSNotification *)notification
{
    DLogFuncName();
    DEBUG_ACCOUNT_LogName();
    
    NSError *error = [notification.userInfo objectForKey:NXOAuth2AccountStoreErrorKey];
    // Do something with the error
    DEBUG_ACCOUNT_Log(@"ERROR =%@", error);
    [self checkAccounts];
#warning todo - show error!!
}


// Dürfte nur beim AuthHandler geschehen ...
- (void) accountStoreRedirect:(NSNotification *)notification
{
    DLogFuncName();
    DEBUG_ACCOUNT_LogName();
    
    // Do something with the error
    // Step 1 - WebView formular abgeschickt!
    // Ruft auf der WebView die Funktion zum schließen auf -> cancel usw
    if ([[notification.userInfo allKeys] containsObject:@"url"])
    {
        DEBUG_ACCOUNT_Log(@"URL = %@",[notification.userInfo objectForKey:@"url"]);
        if ([[[notification.userInfo objectForKey:@"url"] absoluteString] hasPrefix:@"http://phoneatmoapp.com"])
        {
            [[NXOAuth2AccountStore sharedStore] handleRedirectURL:[notification.userInfo objectForKey:@"url"]];
        }
    }
}


#pragma mark - Account Validation
- (BOOL) hasAccount
{
    DLogFuncName();
    DEBUG_ACCOUNT_LogName();

    #warning todo - debug self account
    #warning todo - check accounts!!!

    return (self.oAuthAccount != nil);
}


- (BOOL)accountIsValid:(NXOAuth2Account*)oAuthAccount
{
    DLogFuncName();
    DEBUG_ACCOUNT_LogName();
    
    return ([self.oAuthAccount.accessToken.expiresAt compare:[NSDate date]] == NSOrderedDescending);
}


- (BOOL)currentAccountIsValid
{
    DLogFuncName();
    DEBUG_ACCOUNT_LogName();
    
    return ([self hasAccount] && [self accountIsValid:[self account]]);
}


- (NXOAuth2Account*) account
{
    DLogFuncName();
    DEBUG_ACCOUNT_LogName();
    
    return self.oAuthAccount;
}


#pragma mark - Request Account
- (void) requestAccount
{
    DLogFuncName();
    DEBUG_ACCOUNT_LogName();
    
    if (!self.oAuthAccount)
    {
        [[NXOAuth2AccountStore sharedStore] requestAccessToAccountWithType:ACCOUNT_TYPE];
    }
}





- (void) checkAccounts
{
    DLogFuncName();
    DEBUG_ACCOUNT_LogName();
    
    for (NXOAuth2Account * account in [[NXOAuth2AccountStore sharedStore] accounts])
    {

        // Do something with the account
        NSLog(@"Account = %@", account);
        NSDate *expireDate = account.accessToken.expiresAt;
        NSDate *now = [NSDate date];

        if ([expireDate compare:now] == NSOrderedDescending)
        {
            NSLog(@"expireDate is later than now");
            self.oAuthAccount = account;
            break;

        }
    }
    
    [self cleanAccounts];
}


- (void) cleanAccounts
{
    DLogFuncName();
    DEBUG_ACCOUNT_LogName();
    
    if (self.account)
    {
        for (NXOAuth2Account * account in [[NXOAuth2AccountStore sharedStore] accounts])
        {
            if (account != self.account)
            {
                NSLog(@"Remove Account %@", account);
                [[NXOAuth2AccountStore sharedStore] removeAccount:account];
            }
        }
        
//        if (![self currentAccountIsValid])
//        {
////            [self deleteAccount];
//            [[NXOAuth2AccountStore sharedStore] removeAccount:self.account];
//        }
    }
}


- (void) deleteAccount
{
    DLogFuncName();
    DEBUG_ACCOUNT_LogName();
    
    [self checkAccounts];
    // BÖSE!!!!
    if (self.account)
    {
        [[NXOAuth2AccountStore sharedStore] removeAccount:self.account];
    }
}

@end