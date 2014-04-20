//
//  PSNetAtmoDevicePlaceDB.h
//  PSNetAtmo
//
//  Created by Philip Schneider on 07.12.13.
//  Copyright (c) 2013 phschneider.net. All rights reserved.
//


#import "PSNetAtmoDevicePlace.h"
#import <MapKit/MapKit.h>

@interface PSNetAtmoDevicePlace (Helper)

- (id) initWithDict:(NSDictionary*)dict;
+ (PSNetAtmoDevicePlace *)findByID:(NSNumber *)articleID context:(NSManagedObjectContext *)context;
+ (BOOL) existsInDB:(NSNumber*)articleID context:(NSManagedObjectContext*) context;

- (CLLocationCoordinate2D)coordinate;

@end
