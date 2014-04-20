//
//  PSNetAtmoUserDB.m
//  PSNetAtmo
//
//  Created by Philip Schneider on 23.11.13.
//  Copyright (c) 2013 phschneider.net. All rights reserved.
//

#import "PSNetAtmoUser+Helper.h"
#import "PSNetAtmoNotifications.h"

@implementation PSNetAtmoUser (Helper)

#warning - evtl umbauen
- (id) initWithData:(NSData*)data error:(NSError **)error
{
    DLogFuncName();
    self = [super init];
    if(self)
    {
        NSError *localError = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
        
        if (localError != nil) {
            *error = localError;
            return nil;
        }
        
        NSDictionary *body = [dict objectForKey:@"body"];
        NSDictionary *administrative = [body objectForKey:@"administrative"];
        NSDictionary *date_creation = [body objectForKey:@"date_creation"];
        
        self.userID = [body objectForKey:@"_id"];
        
        self.country = [administrative objectForKey:@"country"];
        self.locale = [administrative objectForKey:@"reg_locale"];
        self.lang = [administrative objectForKey:@"lang"];
        
        self.unit = [administrative objectForKey:@"unit"];
        self.windUnit = [administrative objectForKey:@"windunit"];
        self.pressureUnit = [administrative objectForKey:@"pressureunit"];
        self.feelLikeAlgo = [administrative objectForKey:@"feel_like_algo"];
        
        self.createdAt = [NSDate dateWithTimeIntervalSince1970:[[date_creation objectForKey:@"sec"] integerValue]];
        
        self.devices = [body objectForKey:@"devices"];
        self.friendDevices = [body objectForKey:@"friend_devices"];

        self.mail = [body objectForKey:@"mail"];
        self.timelineNotRead = [body objectForKey:@"timeline_not_read"];
        
//        NSLog(@"ParsedObject = %@", dict);
//        NSLog(@"TimeExec = %@",[dict objectForKey:@"time_exec"]);
//        NSLog(@"TimeServer = %@ => %@", [dict objectForKey:@"time_server"], [NSDate dateWithTimeIntervalSince1970:[[dict objectForKey:@"time_server"] integerValue]]);
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:PSNETATMO_USER_UPDATE_NOTIFICATION object:nil];
    return self;
}


#pragma mark - Administrative Helpers
// unit : 0 -> metric system, 1 -> imperial system
- (BOOL) useMetric
{
    DLogFuncName();
    return ([self.unit integerValue] != 1);
}


// unit : 0 -> metric system, 1 -> imperial system
- (BOOL) useImperial
{
    DLogFuncName();
    return ([self.unit integerValue] == 1);
}


// feel_like: algorithme used to compute feel like temperature, 0 -> humidex, 1 -> heat-index
- (BOOL) useTemperatureHumdiex
{
    DLogFuncName();
    return ([self.feelLikeAlgo integerValue] == 1);
}


#pragma mark - WindUnit
// windunit: 0 -> kph, 1 -> mph, 2 -> ms, 3 -> beaufort, 4 -> knot
- (BOOL) useKph
{
    DLogFuncName();
    return ([self.windUnit integerValue] == 0);
}


// windunit: 0 -> kph, 1 -> mph, 2 -> ms, 3 -> beaufort, 4 -> knot
- (BOOL) useMph
{
    DLogFuncName();
    return ([self.windUnit integerValue] == 1);
}


- (BOOL) useMs
{
    DLogFuncName();
    return ([self.windUnit integerValue] == 2);
}


- (BOOL) useBeaufort
{
    DLogFuncName();
    return ([self.windUnit integerValue] == 3);
}


- (BOOL) useKnot
{
    DLogFuncName();
    return ([self.windUnit integerValue] == 4);
}


- (NSString*) windUnitAsString
{
    DLogFuncName();
    if ([self useKnot])
    {
        return @"Knoten";
    }
    else if ([self useBeaufort])
    {
        return @"Beaufort";
    }
    else if ([self useMs])
    {
        return @"ms";
    }
    else if ([self useMph])
    {
        return @"Mph";
    }
    else if ([self useKph])
    {
        return @"Kph";
    }
    return @"[not defined]";
}


#pragma mark - PressureUnit
// pressureunit: 0 -> mbar, 1 -> inHg, 2 -> mmHg
- (BOOL) usesMbar
{
    DLogFuncName();
    return ([self.pressureUnit integerValue] == 0);
}


// pressureunit: 0 -> mbar, 1 -> inHg, 2 -> mmHg
- (BOOL) usesInHg
{
    DLogFuncName();
    return ([self.pressureUnit integerValue] == 1);
}


// pressureunit: 0 -> mbar, 1 -> inHg, 2 -> mmHg
- (BOOL) usesMmHg
{
    return ([self.pressureUnit integerValue] == 2);
}


- (NSString*) pressureUnitAsString
{
    DLogFuncName();
    if ([self usesMmHg])
    {
        return @"mmHg";
    }
    else if ([self usesInHg])
    {
        return @"inHg";
    }
    else if ([self usesMbar])
    {
        return @"mbar";
    }
    else
    {
        return @"[not defined]";
    }
}

#pragma mark - Localization / i18n
// reg_locale: user regional preferences (used for displaying date)
//- (NSLocale*) locale
//{
//    return [NSLocale localeWithLocaleIdentifier: self.locale];
//}





@end
