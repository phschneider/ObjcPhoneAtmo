//
//  PSNetAtmoPublicDevice+Helper.h
//  PSNetAtmo
//
//  Created by Philip Schneider on 13.12.13.
//  Copyright (c) 2013 phschneider.net. All rights reserved.
//

#import "PSNetAtmoPublicDevice.h"
#import <MapKit/MapKit.h>

@interface PSNetAtmoPublicDevice (Helper)

+(PSNetAtmoPublicDevice*) createOrUpdatePublicDeviceWithDict:(NSDictionary*)dict inContext:(NSManagedObjectContext*)context;
+(NSArray*) allPublicDevicesInContext:(NSManagedObjectContext *)context;

- (CLLocationCoordinate2D)coordinate;

@end
