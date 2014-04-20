//
//  PSNetAtmoDevice.h
//  PSNetAtmo
//
//  Created by Philip Schneider on 14.12.13.
//  Copyright (c) 2013 phschneider.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PSNetAtmoDevicePlace, PSNetAtmoModule;

@interface PSNetAtmoDevice : NSManagedObject

@property (nonatomic, retain) NSString * deviceID;
@property (nonatomic, retain) NSSet *modules;
@property (nonatomic, retain) PSNetAtmoDevicePlace *place;
@end

@interface PSNetAtmoDevice (CoreDataGeneratedAccessors)

- (void)addModulesObject:(PSNetAtmoModule *)value;
- (void)removeModulesObject:(PSNetAtmoModule *)value;
- (void)addModules:(NSSet *)values;
- (void)removeModules:(NSSet *)values;

@end
