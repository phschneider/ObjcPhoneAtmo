//
// Created by Philip Schneider on 05.12.13.
// Copyright (c) 2013 phschneider.net. All rights reserved.
//


#import "PSNetAtmoUserDefaults.h"

#define PSNETATMO_USERDEFAULTS_TEMP_UNIT_CELSIUS            @"PSNETATMO_USERDEFAULTS_TEMP_UNIT_CELSIUS"
#define PSNETATMO_USERDEFAULTS_TEMP_UNIT_FAHRENHEIT         @"PSNETATMO_USERDEFAULTS_TEMP_UNIT_FAHRENHEIT"

#define PSNETATMO_USERDEFAULTS_DISTANCE_UNIT_KILOMETERES    @"PSNETATMO_USERDEFAULTS_DISTANCE_UNIT_KILOMETERES"
#define PSNETATMO_USERDEFAULTS_DISTANCE_UNIT_MILES          @"PSNETATMO_USERDEFAULTS_DISTANCE_UNIT_MILES"

#define PSNETATMO_USERDEFAULTS_TEMP_UNIT                    @"PSNETATMO_USERDEFAULTS_TEMP_UNIT"
#define PSNETATMO_USERDEFAULTS_DISTANCE_UNIT                @"PSNETATMO_USERDEFAULTS_DISTANCE_UNIT"

#define PSNETATMO_USERDEFAULTS_FILTER_ENABLED               @"PSNETATMO_USERDEFAULTS_FILTER_ENABLED"

#define PSNETATMO_USERDEFAULTS_FULLSCREEN_LEAVINGS          @"PSNETATMO_USERDEFAULTS_FULLSCREEN_LEAVINGS"
#define PSNETATMO_USERDEFAULTS_FULLSCREEN_ENTERINGS         @"PSNETATMO_USERDEFAULTS_FULLSCREEN_ENTERINGS"

#define PSNETATMO_USERDEFAULTS_APP_VERSION                  @"PSNETATMO_USERDEFAULTS_APP_VERSION"


@interface PSNetAtmoUserDefaults()

@property (nonatomic) int numberOfFullScreenLeavings;
@property (nonatomic) int numberOfFullScreenEnterings;

@end


@implementation PSNetAtmoUserDefaults

static PSNetAtmoUserDefaults* instance = nil;
+ (PSNetAtmoUserDefaults*) sharedInstance {
    @synchronized (self)
    {
        if (instance == nil)
        {
            [PSNetAtmoUserDefaults new];
        }
    }
    return instance;
}


- (id) init
{
    DLogFuncName();
    NSAssert(!instance, @"Instance of PSNetAtmouserDefaults already exists");
    self = [super init];
    if (self)
    {
        self.numberOfFullScreenEnterings = [[[NSUserDefaults standardUserDefaults] objectForKey:PSNETATMO_USERDEFAULTS_FULLSCREEN_ENTERINGS] integerValue];
        self.numberOfFullScreenLeavings = [[[NSUserDefaults standardUserDefaults] objectForKey:PSNETATMO_USERDEFAULTS_FULLSCREEN_LEAVINGS] integerValue];
        
        [[NSUserDefaults standardUserDefaults] setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] forKey:PSNETATMO_USERDEFAULTS_APP_VERSION];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    instance = self;
    return self;
}


#pragma mark - TempUnits
- (BOOL) useFahrenheit
{
    DLogFuncName();
    NSString * value = [[NSUserDefaults standardUserDefaults] objectForKey:PSNETATMO_USERDEFAULTS_TEMP_UNIT];
    return ([value isEqualToString:PSNETATMO_USERDEFAULTS_TEMP_UNIT_FAHRENHEIT]);
}


- (void) setUseFahrenheitAsTempUnit
{
    DLogFuncName();
    [[NSUserDefaults standardUserDefaults] setObject:PSNETATMO_USERDEFAULTS_TEMP_UNIT_FAHRENHEIT forKey:PSNETATMO_USERDEFAULTS_TEMP_UNIT];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void) setUseCelsiusAsTempUnit
{
    DLogFuncName();
    [[NSUserDefaults standardUserDefaults] setObject:PSNETATMO_USERDEFAULTS_TEMP_UNIT_CELSIUS forKey:PSNETATMO_USERDEFAULTS_TEMP_UNIT];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end