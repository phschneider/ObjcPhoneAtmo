//
//  PSNetAtmoMeasureDB.h
//  PSNetAtmo
//
//  Created by Philip Schneider on 23.11.13.
//  Copyright (c) 2013 phschneider.net. All rights reserved.
//

#import "PSNetAtmoModuleMeasure.h"

@interface PSNetAtmoModuleMeasure (Helper)

+ (PSNetAtmoModuleMeasure *)finyByModule:(PSNetAtmoModule *)module andDate:(NSDate *)date context:(NSManagedObjectContext *)context;
+ (BOOL) existsInDB:(PSNetAtmoModule *)module date:(NSDate*)date context:(NSManagedObjectContext*) context;

- (void) updateWithDictionary:(NSDictionary *)dataDict;

@end
