//
//  PSNetAtmoModule.h
//  PSNetAtmo
//
//  Created by Philip Schneider on 14.12.13.
//  Copyright (c) 2013 phschneider.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PSNetAtmoDevice, PSNetAtmoModuleDataType, PSNetAtmoModuleLastDataStore, PSNetAtmoModuleMeasure;

@interface PSNetAtmoModule : NSManagedObject

@property (nonatomic, retain) NSNumber * battery;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSNumber * firmware;
@property (nonatomic, retain) NSDate * lastAlarm;
@property (nonatomic, retain) NSDate * lastEvent;
@property (nonatomic, retain) NSDate * lastMessage;
@property (nonatomic, retain) NSDate * lastSeen;
@property (nonatomic, retain) NSNumber * manualPairing;
@property (nonatomic, retain) NSNumber * rfStatus;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * deviceID;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *dataTypes;
@property (nonatomic, retain) PSNetAtmoDevice *device;
@property (nonatomic, retain) PSNetAtmoModuleLastDataStore *lastDataStore;
@property (nonatomic, retain) PSNetAtmoModuleMeasure *measures;
@end

@interface PSNetAtmoModule (CoreDataGeneratedAccessors)

- (void)addDataTypesObject:(PSNetAtmoModuleDataType *)value;
- (void)removeDataTypesObject:(PSNetAtmoModuleDataType *)value;
- (void)addDataTypes:(NSSet *)values;
- (void)removeDataTypes:(NSSet *)values;

@end
