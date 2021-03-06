//
//  PSNetAtmoModuleLastDataStore.h
//  PSNetAtmo
//
//  Created by Philip Schneider on 21.04.14.
//  Copyright (c) 2014 phschneider.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PSNetAtmoModule;

@interface PSNetAtmoModuleLastDataStore : NSManagedObject

@property (nonatomic, retain) NSNumber * co2;
@property (nonatomic, retain) NSData * data;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * humidy;
@property (nonatomic, retain) NSNumber * noise;
@property (nonatomic, retain) NSNumber * pressure;
@property (nonatomic, retain) NSNumber * temperature;
@property (nonatomic, retain) PSNetAtmoModule *module;

@end
