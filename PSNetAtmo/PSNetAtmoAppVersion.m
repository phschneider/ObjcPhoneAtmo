//
//  PSNetAtmoAppVersion.m
//  PSNetAtmo
//
//  Created by Philip Schneider on 14.12.13.
//  Copyright (c) 2013 phschneider.net. All rights reserved.
//

#import "PSNetAtmo.h"
#import "PSNetAtmoDateFormatter.h"
#import "PSNetAtmoAppVersion.h"
#import "PSNetAtmoAnalytics.h"
#import "PSNetAtmoNotifications.h"

@interface PSNetAtmoAppVersion()
@property (nonatomic) BOOL isFirstStart;
@property (nonatomic) BOOL isFirstStartForCurrentAppVersion;
@end

@implementation PSNetAtmoAppVersion

static PSNetAtmoAppVersion* instance = nil;

+ (PSNetAtmoAppVersion*) sharedInstance {
    @synchronized (self)
    {
        if (instance == nil)
        {
            [PSNetAtmoAppVersion new];
        }
    }
    return instance;
}


- (id)init
{
    DLogFuncName();
    NSAssert(!instance, @"Instance of PSNetAtmoAppVersion already exists");

    self = [super init];
    if (self)
    {
        self.isFirstStart = NO;
        self.isFirstStartForCurrentAppVersion = NO;
        
        [self checkIsFirstStart];
        [self checkIsFirstStartForCurrentAppVersion];
        
        DLog(@"lastAppVersion = %@", [self lastAppVersion]);
        DLog(@"isFirstStart = %@", ([self isFirstStart]) ? @"YES" : @"NO");
        DLog(@"isFirstStartForCurrentAppVersion = %@", ([self isFirstStartForCurrentAppVersion]) ? @"YES" : @"NO");
    }
    
    instance = self;
    return self;
}


- (void)checkIsFirstStart
{
    DLogFuncName();
    BOOL isFirststart = NO;
    NSDate * firstStartDate = [[NSUserDefaults standardUserDefaults] objectForKey:DEFAULTS_APP_FIRST_START_DATE];
    if (!firstStartDate)
    {
        DLog(@"is first start");
        isFirststart = YES;
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:DEFAULTS_APP_FIRST_START_DATE];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
        DLog(@"First Start Date = %@", [[PSNetAtmoDateFormatter sharedInstance] stringFromDate:firstStartDate]);
    }
    
    self.isFirstStart = isFirststart;
}


- (void) setIsFirstStart:(BOOL)isFirstStart
{
    DLogFuncName();
    _isFirstStart = isFirstStart;
    if (_isFirstStart)
    {
        [[PSNetAtmoAnalytics sharedInstance] trackBlankInstall];
        [[PSNetAtmoAnalytics sharedInstance] trackBlankInstallVersion:[self currentAppVersion]];
    }
}


- (void)checkIsFirstStartForCurrentAppVersion
{
    DLogFuncName();
    BOOL isFirstStartForCurrentAppVersion = [self isFirstStart];
    NSString * currentVersion = [self currentAppVersion];
    
    if (isFirstStartForCurrentAppVersion)
    {
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:DEFAULTS_APP_LAST_VERSION];
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:DEFAULTS_APP_LAST_VERSION_DATE];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
        //Compare AppVersion
        NSString * latestVersion = [[NSUserDefaults standardUserDefaults] objectForKey:DEFAULTS_APP_LAST_VERSION];
        NSDate * latestVersionDate = [[NSUserDefaults standardUserDefaults] objectForKey:DEFAULTS_APP_LAST_VERSION_DATE];
        
        DLog(@"LastVersion %@, Date = %@", latestVersion, [[PSNetAtmoDateFormatter sharedInstance] stringFromDate:latestVersionDate]);
        if (![currentVersion isEqualToString:latestVersion])
        {
            [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:DEFAULTS_APP_LAST_VERSION_DATE];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            isFirstStartForCurrentAppVersion = YES;
            DLog(@"is first start");
        }
    }
    
    self.isFirstStartForCurrentAppVersion = isFirstStartForCurrentAppVersion;
}


- (void)setIsFirstStartForCurrentAppVersion:(BOOL)isFirstStartForCurrentAppVersion
{
    DLogFuncName();
    _isFirstStartForCurrentAppVersion = isFirstStartForCurrentAppVersion;
    if (_isFirstStartForCurrentAppVersion && ![self isFirstStart])
    {
        [[PSNetAtmoAnalytics sharedInstance] trackUpdateInstall];
        [[PSNetAtmoAnalytics sharedInstance] trackUpdateInstallVersion:[self currentAppVersion]];
        [[PSNetAtmoAnalytics sharedInstance] trackUpdateInstallVersion:[self currentAppVersion] fromVersion:[self lastAppVersion]];
        
        // Erweiterung des Else-Zweig von checkIsFirstStartForCurrentAppVersion
        [[NSUserDefaults standardUserDefaults] setObject:[self currentAppVersion] forKey:DEFAULTS_APP_LAST_VERSION];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    if (_isFirstStartForCurrentAppVersion)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:PSNETATMO_PUBLIC_FIRST_START_NOTIFICATION object:nil];
    }
}


- (NSString*)currentAppVersion
{
    DLogFuncName();
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}


- (NSString*)lastAppVersion
{
    DLogFuncName();
    return [[NSUserDefaults standardUserDefaults] objectForKey:DEFAULTS_APP_LAST_VERSION];
    
}


@end
