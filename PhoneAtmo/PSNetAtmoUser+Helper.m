//
//  PSNetAtmoUserDB.m
//  PSNetAtmo
//
//  Created by Philip Schneider on 23.11.13.
//  Copyright (c) 2013 phschneider.net. All rights reserved.
//

#import "PSNetAtmoUser+Helper.h"
#import "PSNetAtmoNotifications.h"
#import "PSNetAtmo.h"
#import "PSNetAtmoDevice+Helper.h"
#import "PSAppDelegate.h"

@interface PSNetAtmoUser ()
@end

@implementation PSNetAtmoUser (Helper)

+ (NSArray *)allUsersInContext:(NSManagedObjectContext *)context
{
    DLogFuncName();
    DEBUG_CORE_DATA_LogName();
    NSFetchRequest *request = [[NSFetchRequest alloc] init];

    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NETATMO_ENTITY_USER inManagedObjectContext:context];
    [request setEntity:entityDescription];

    return [context executeFetchRequest:request error:nil];
}


+ (PSNetAtmoUser *)findByID:(NSString *)userID context:(NSManagedObjectContext *)context
{
    DLogFuncName();
    DEBUG_CORE_DATA_LogName();
    NSAssert(userID, @"No moduleID given");
    NSFetchRequest *request = [[NSFetchRequest alloc] init];

    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NETATMO_ENTITY_USER inManagedObjectContext:context];
    [request setEntity:entityDescription];
    [request setFetchLimit:1];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(userID == %@)", userID];
    [request setPredicate:predicate];

    NSError *error = nil;

    NSArray *array = [context executeFetchRequest:request error:&error];

    PSNetAtmoUser *user = nil;

    if (!error && [array count] > 0) {
        user = [array lastObject];
    }

    return user;
}


+ (void) updateUserFromJsonDict:(NSDictionary *)dict inContext:(NSManagedObjectContext *)context withAccount:(NXOAuth2Account *)account
{
    DLogFuncName();
    DEBUG_CORE_DATA_LogName();

    NSDictionary *body = [dict objectForKey:@"body"];
    NSDictionary *administrative = [body objectForKey:@"administrative"];
    NSDictionary *date_creation = [body objectForKey:@"date_creation"];
    NSString *userID = [body objectForKey:@"_id"];

    PSNetAtmoUser *user = [PSNetAtmoUser findByID:userID context:context];
    if (!user)
    {
        user = [NSEntityDescription insertNewObjectForEntityForName:NETATMO_ENTITY_USER inManagedObjectContext:context];
    }

    user.userID = userID;
    user.country = [administrative objectForKey:@"country"];
    user.locale = [administrative objectForKey:@"reg_locale"];
    user.lang = [administrative objectForKey:@"lang"];

    user.unit = [administrative objectForKey:@"unit"];
    user.windUnit = [administrative objectForKey:@"windunit"];
    user.pressureUnit = [administrative objectForKey:@"pressureunit"];
    user.feelLikeAlgo = [administrative objectForKey:@"feel_like_algo"];

    user.createdAt = [NSDate dateWithTimeIntervalSince1970:[[date_creation objectForKey:@"sec"] integerValue]];

    for (NSString *deviceID in [body objectForKey:@"devices"])
    {
        PSNetAtmoDevice *device = [PSNetAtmoDevice findByID:deviceID context:context];
        if (device)
        {
            [user addDevicesObject:device];
            [device addOwnersObject:user];
        }
    }


    for (NSString *deviceID in [body objectForKey:@"friend_devices"])
    {
        PSNetAtmoDevice *device = [PSNetAtmoDevice findByID:deviceID context:context];
        if (device)
        {
            [user addFriendDevicesObject:device];
            [device addFriendsObject:user];
        }
    }

    user.mail = [body objectForKey:@"mail"];
    user.timelineNotRead = [body objectForKey:@"timeline_not_read"];
    user.oAuthAccountData = [NSKeyedArchiver archivedDataWithRootObject:account];

    [APPDELEGATE saveContext];
}
    

+ (void) setCurrentUserFromJsonDict:(NSDictionary *)dictionary inContext:(NSManagedObjectContext *)context withAccount:(NXOAuth2Account *)account
{
    DLogFuncName();
    DEBUG_CORE_DATA_LogName();

    NSDictionary *body = [dictionary objectForKey:@"body"];
    NSDictionary *administrative = [body objectForKey:@"administrative"];
    NSDictionary *date_creation = [body objectForKey:@"date_creation"];
    NSString *userID = [body objectForKey:@"_id"];

    PSNetAtmoUser * currentUser = [PSNetAtmoUser findByID:userID context:context];
    NSAssert(currentUser, @"User not found");

    [self resetCurrentUserInContext:context];

    [currentUser setIsCurrentUser:@YES];
    [currentUser setOAuthAccountData:[NSKeyedArchiver archivedDataWithRootObject:account]];
    [APPDELEGATE saveContext];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PSNETNETATMO_SET_CURRENT_USER_NOTIFICATION object:nil];
}


+ (void) resetCurrentUserInContext:(NSManagedObjectContext *)context
{
    DLogFuncName();
    DEBUG_CORE_DATA_LogName();
    
    for (PSNetAtmoUser *user in [PSNetAtmoUser allUsersInContext:context])
    {
        [user setIsCurrentUser:@NO];
    }
    [APPDELEGATE saveContext];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PSNETATMO_RESET_CURRENT_USER_NOTIFICATION object:nil];
}


+ (PSNetAtmoUser *) currentuser
{
    DLogFuncName();
    DEBUG_CORE_DATA_LogName();
    
    return [PSNetAtmoUser currentUserInContext:APPDELEGATE.managedObjectContext];
}


+ (PSNetAtmoUser *)currentUserInContext:(NSManagedObjectContext *)context
{
    DLogFuncName();
    DEBUG_CORE_DATA_LogName();
    NSFetchRequest *request = [[NSFetchRequest alloc] init];

    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NETATMO_ENTITY_USER inManagedObjectContext:context];
    [request setEntity:entityDescription];
    [request setFetchLimit:1];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(isCurrentUser == %@)",@YES];
    [request setPredicate:predicate];

    NSError *error = nil;

    NSArray *array = [context executeFetchRequest:request error:&error];

    PSNetAtmoUser *user = nil;

    if (!error && [array count] > 0) {
        user = [array lastObject];
    }

    return user;
}


#pragma mark - Instance
- (void) delete
{
    DLogFuncName();
    DEBUG_CORE_DATA_LogName();
    [self.managedObjectContext deleteObject:self];
}


- (NXOAuth2Account*)oAuthAccount
{
    DLogFuncName();
    DEBUG_CORE_DATA_LogName();
    return [NSKeyedUnarchiver unarchiveObjectWithData:self.oAuthAccountData];
}


- (NSDate*)expiresAt
{
    DLogFuncName();
    DEBUG_CORE_DATA_LogName();
    return self.oAuthAccount.accessToken.expiresAt;
}


- (NSString*)expireString
{
    DLogFuncName();
    DEBUG_CORE_DATA_LogName();
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    return [dateFormatter stringFromDate:[self expiresAt]];
}


#pragma mark - Administrative Helpers
// unit : 0 -> metric system, 1 -> imperial system
- (BOOL) useMetric
{
    DLogFuncName();
    DEBUG_CORE_DATA_LogName();
    return ([self.unit integerValue] != 1);
}


// unit : 0 -> metric system, 1 -> imperial system
- (BOOL) useImperial
{
    DLogFuncName();
    DEBUG_CORE_DATA_LogName();
    return ([self.unit integerValue] == 1);
}


// feel_like: algorithme used to compute feel like temperature, 0 -> humidex, 1 -> heat-index
- (BOOL) useTemperatureHumdiex
{
    DLogFuncName();
    DEBUG_CORE_DATA_LogName();
    return ([self.feelLikeAlgo integerValue] == 1);
}


#pragma mark - WindUnit
// windunit: 0 -> kph, 1 -> mph, 2 -> ms, 3 -> beaufort, 4 -> knot
- (BOOL) useKph
{
    DLogFuncName();
    DEBUG_CORE_DATA_LogName();
    return ([self.windUnit integerValue] == 0);
}


// windunit: 0 -> kph, 1 -> mph, 2 -> ms, 3 -> beaufort, 4 -> knot
- (BOOL) useMph
{
    DLogFuncName();
    DEBUG_CORE_DATA_LogName();
    return ([self.windUnit integerValue] == 1);
}


- (BOOL) useMs
{
    DLogFuncName();
    DEBUG_CORE_DATA_LogName();
    return ([self.windUnit integerValue] == 2);
}


- (BOOL) useBeaufort
{
    DLogFuncName();
    DEBUG_CORE_DATA_LogName();
    return ([self.windUnit integerValue] == 3);
}


- (BOOL) useKnot
{
    DLogFuncName();
    DEBUG_CORE_DATA_LogName();
    return ([self.windUnit integerValue] == 4);
}


- (NSString*) windUnitAsString
{
    DLogFuncName();
    DEBUG_CORE_DATA_LogName();
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
    DEBUG_CORE_DATA_LogName();
    return ([self.pressureUnit integerValue] == 0);
}


// pressureunit: 0 -> mbar, 1 -> inHg, 2 -> mmHg
- (BOOL) usesInHg
{
    DLogFuncName();
    DEBUG_CORE_DATA_LogName();
    return ([self.pressureUnit integerValue] == 1);
}


// pressureunit: 0 -> mbar, 1 -> inHg, 2 -> mmHg
- (BOOL) usesMmHg
{
    DLogFuncName();
    DEBUG_CORE_DATA_LogName();
    return ([self.pressureUnit integerValue] == 2);
}


- (NSString*) pressureUnitAsString
{
    DLogFuncName();
    DEBUG_CORE_DATA_LogName();
    
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
