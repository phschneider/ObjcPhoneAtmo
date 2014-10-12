//
//  PSNetAtmoModuleMeasure.h
//  PSNetAtmo
//
//  Created by Philip Schneider on 25.04.14.
//  Copyright (c) 2014 phschneider.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PSNetAtmoModule;

@interface PSNetAtmoModuleMeasure : NSManagedObject

@property (nonatomic, retain) NSNumber * co2;
@property (nonatomic, retain) NSData * data;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * humidity;
@property (nonatomic, retain) NSNumber * noise;
@property (nonatomic, retain) NSNumber * pressure;
@property (nonatomic, retain) NSNumber * temperature;
@property (nonatomic, retain) NSNumber * rain;
@property (nonatomic, retain) PSNetAtmoModule *module;

@end
