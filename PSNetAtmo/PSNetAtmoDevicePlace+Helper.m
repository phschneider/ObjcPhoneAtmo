//
//  PSNetAtmoDevicePlaceDB.m
//  PSNetAtmo
//
//  Created by Philip Schneider on 07.12.13.
//  Copyright (c) 2013 phschneider.net. All rights reserved.
//

#import "PSNetAtmo.h"
#import "PSAppDelegate.h"
#import "PSNetAtmoDevicePlace.h"
#import "PSNetAtmoDevicePlace+Helper.h"


@implementation PSNetAtmoDevicePlace (Helper)

/*
 place =     {
 altitude = 17;
 location =         (
 "-5.0654099999999",
 "50.15013"
 );
 };
 */
- (id) initWithDict:(NSDictionary*)dict
{
    DLogFuncName();
    DEBUG_CORE_DATA_LogName();
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:NETATMO_ENTITY_DEVICE_PLACE inManagedObjectContext:APPDELEGATE.managedObjectContext];
    self = [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
    if (self)
    {
        // Find and Replace ...
        
        NSError * error = nil;
        self.data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];

        self.latitude = [[dict objectForKey:@"location"] objectAtIndex:1];
        self.longitude = [[dict objectForKey:@"location"] objectAtIndex:0];
        
//        self.bssId = [dict objectForKey:@"bssid"];
//        self.country = [dict objectForKey:@"country"];
//        self.timeZone = [dict objectForKey:@"timezone"];
//        self.meteoAlarmArea = [dict objectForKey:@"meteoalarm_area"];
//        self.country = [dict objectForKey:@"country"];
//        
//        self.fromIp = [dict objectForKey:@"from_ip"];
//        
//        self.location = [dict objectForKey:@"location"];
//        self.latitude = [[self.location allObjects] objectAtIndex:0];
//        self.longitude = [[self.location allObjects] objectAtIndex:1];
    }
    return self;
}


+ (PSNetAtmoDevicePlace *)findByID:(NSNumber *)articleID context:(NSManagedObjectContext *)context
{
    DLogFuncName();
    DEBUG_CORE_DATA_LogName();
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NETATMO_ENTITY_DEVICE_PLACE inManagedObjectContext:context];
    [request setEntity:entityDescription];
    [request setFetchLimit:1];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(id == %@)", articleID];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    
    NSArray *array = [context executeFetchRequest:request error:&error];
    PSNetAtmoDevicePlace * devicePlace = nil;
    
    if (!error && [array count] > 0) {
        devicePlace = [array lastObject];
    }
    
    return devicePlace;
}


+ (BOOL) existsInDB:(NSNumber*)articleID context:(NSManagedObjectContext*) context
{
    DLogFuncName();
    DEBUG_CORE_DATA_LogName();
    
    return ([PSNetAtmoDevicePlace findByID:articleID context:(NSManagedObjectContext *)context] != nil);
}


- (CLLocationCoordinate2D)coordinate
{
    DLogFuncName();
    DEBUG_CORE_DATA_LogName();
    
    CLLocationCoordinate2D coord;
    coord.latitude = [self.latitude doubleValue]; // or self.latitudeValue à la MOGen
    coord.longitude = [self.longitude doubleValue];
    return coord;
}


@end
