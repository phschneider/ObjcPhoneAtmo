//
//  PSNetAtmoModuleDataType+Helper.h
//  PSNetAtmo
//
//  Created by Philip Schneider on 21.04.14.
//  Copyright (c) 2014 phschneider.net. All rights reserved.
//

#import "PSNetAtmoModuleDataType.h"

@interface PSNetAtmoModuleDataType (Helper)

+ (PSNetAtmoModuleDataType *)finyByName:(NSString *)name context:(NSManagedObjectContext *)context;
+ (BOOL) existsInDB:(NSString*)name context:(NSManagedObjectContext*) context;


@end
