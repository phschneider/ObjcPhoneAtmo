//
//  PSNetAtmoDevice.h
//  PSNetAtmo
//
//  Created by Philip Schneider on 21.04.14.
//  Copyright (c) 2014 phschneider.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PSNetAtmoDevicePlace, PSNetAtmoModule;

@interface PSNetAtmoDevice : NSManagedObject

@property (nonatomic, retain) NSString * accessCode;
@property (nonatomic, retain) NSNumber * co2Calibrating;
@property (nonatomic, retain) NSData * data;
@property (nonatomic, retain) NSString * deviceID;
@property (nonatomic, retain) NSNumber * mark;
@property (nonatomic, retain) NSString * stationName;
@property (nonatomic, retain) NSNumber * wifiStatus;
@property (nonatomic, retain) NSSet *modules;
@property (nonatomic, retain) PSNetAtmoDevicePlace *place;
@end

@interface PSNetAtmoDevice (CoreDataGeneratedAccessors)

- (void)addModulesObject:(PSNetAtmoModule *)value;
- (void)removeModulesObject:(PSNetAtmoModule *)value;
- (void)addModules:(NSSet *)values;
- (void)removeModules:(NSSet *)values;

@end
