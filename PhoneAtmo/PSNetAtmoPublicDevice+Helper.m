//
//  PSNetAtmoPublicDevice+Helper.m
//  PSNetAtmo
//
//  Created by Philip Schneider on 13.12.13.
//  Copyright (c) 2013 phschneider.net. All rights reserved.
//

#import "PSNetAtmo.h"
#import "PSNetAtmoDevicePlace.h"
#import "PSNetAtmoPublicDevice+Helper.h"

@implementation PSNetAtmoPublicDevice (Helper)


+(PSNetAtmoPublicDevice*) createOrUpdatePublicDeviceWithDict:(NSDictionary*)dict inContext:(NSManagedObjectContext*)context
{
    DLogFuncName();
    DEBUG_CORE_DATA_LogName();
    
//    PSNetAtmoPublicDevice * device = [[PSNetAtmoLocalStorage sharedInstance] publicDeviceWithID:[dict objectForKey:@"_id"]];
//    BOOL addDevice = NO;
//    if (!device)
//    {
//        NSLog(@"Create new Device for id = %@", [dict objectForKey:@"_id"]);
//        device = [[NSManagedObject alloc] initWithEntity: [NSEntityDescription entityForName:NETATMO_ENTITY_PUBLIC_DEVICE inManagedObjectContext:context] insertIntoManagedObjectContext:nil];
//        device.deviceID = [dict objectForKey:@"_id"];
//        
//        addDevice = YES;
//    }
//    
//    
//    if ([device.mark integerValue] != [[dict objectForKey:@"mark"] integerValue])
//    {
//        NSLog(@"Update Mark from %@ to %@", device.mark, [dict objectForKey:@"mark"]);
//        device.mark = [dict objectForKey:@"mark"];
//    }
//    
//    
//    // Updateing Place ...
//    PSNetAtmoDevicePlace * place = device.place;
//    if (!place)
//    {
//        NSLog(@"Create new Place for Device = %@", [dict objectForKey:@"_id"]);
//        place = [[NSManagedObject alloc] initWithEntity: [NSEntityDescription entityForName:NETATMO_ENTITY_DEVICE_PLACE inManagedObjectContext:context] insertIntoManagedObjectContext:nil];
//        place.device = device;
//        device.place = place;
//    }
//    
//    
//    NSNumber * altitude = [[dict objectForKey:@"place"] objectForKey:@"altitude"];
//    if ([place.altitude floatValue] != [altitude floatValue])
//    {
//        NSLog(@"Update Place Altitude from %@ to %@", place.altitude, altitude);
//        place.altitude = altitude;
//    }
//    
//    
//    NSNumber * latitude = [[[dict objectForKey:@"place"] objectForKey:@"location"] objectAtIndex:1];
//    if ([place.latitude floatValue] != [latitude floatValue])
//    {
//        NSLog(@"Update Place Latitude from %@ to %@", place.latitude, latitude);
//        place.latitude = latitude;
//    }
//
//    
//    NSNumber * longitude = [[[dict objectForKey:@"place"] objectForKey:@"location"] objectAtIndex:0];
//    if ([place.longitude floatValue] != [longitude floatValue])
//    {
//        NSLog(@"Update Place Longitude from %@ to %@", place.longitude, longitude);
//        place.longitude = longitude;
//    }
//    
//    if (addDevice)
//    {
//        [[PSNetAtmoLocalStorage sharedInstance] addPublicDevice:device];
//    }
//    return device;
    return nil;
}


+ (NSArray*) allPublicDevicesInContext:(NSManagedObjectContext *)context
{
    DLogFuncName();
    DEBUG_CORE_DATA_LogName();
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NETATMO_ENTITY_PUBLIC_DEVICE inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *items = [context executeFetchRequest:fetchRequest error:&error];
    
    if (error)
    {
        NSLog(@"FETCH ERROR (allPublicDevicesInContext) => %@, %@", error, [error userInfo]);
    }
    
    return items;
}


- (CLLocationCoordinate2D)coordinate
{
    DLogFuncName();
    DEBUG_CORE_DATA_LogName();
    
    CLLocationCoordinate2D coord;
    coord.latitude = [self.place.latitude doubleValue]; // or self.latitudeValue à la MOGen
    coord.longitude = [self.place.longitude doubleValue];
    return coord;
}


@end
