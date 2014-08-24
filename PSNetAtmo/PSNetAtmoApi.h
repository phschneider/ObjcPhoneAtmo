//
//  PSNetAtmoApi.h
//  PSNetAtmo
//
//  Created by Philip Schneider on 08.12.13.
//  Copyright (c) 2013 phschneider.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@class PSNetAtmoDevice;
@class PSNetAtmoModule;

@interface PSNetAtmoApi : NSObject

+ (void) publicMeassuresForSw:(CLLocationCoordinate2D)sw andNe:(CLLocationCoordinate2D)ne;

//+ (PSNetAtmoDeviceDB *) devices;
//+ (PSNetAtmoMeasureDB *) measureForDevice:(NSString*)deviceID;
//+ (PSNetAtmoMeasureDB *) measureForDevice:(NSString*)deviceID andModule:(NSString*)module;

+ (void) user;
+ (void) devices;
+ (void) measureForDevice:(NSString*)deviceID;
+ (void) measureForDevice:(PSNetAtmoDevice*)device andModule:(PSNetAtmoModule*)module;
+ (void) lastMeasureForDevice:(PSNetAtmoDevice*)device andModule:(PSNetAtmoModule*)module;

@end
