//
//  PSNetAtmoDevicePlace.h
//  PSNetAtmo
//
//  Created by Philip Schneider on 21.04.14.
//  Copyright (c) 2014 phschneider.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PSNetAtmoDevice;

@interface PSNetAtmoDevicePlace : NSManagedObject

@property (nonatomic, retain) NSNumber * altitude;
@property (nonatomic, retain) NSString * bssID;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSData * data;
@property (nonatomic, retain) NSNumber * fromIp;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * meteoAlarmArea;
@property (nonatomic, retain) NSString * timeZone;
@property (nonatomic, retain) PSNetAtmoDevice *device;

@end
