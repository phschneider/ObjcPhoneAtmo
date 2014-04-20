//
//  PSNetAtmoModuleDataType.h
//  PSNetAtmo
//
//  Created by Philip Schneider on 13.12.13.
//  Copyright (c) 2013 phschneider.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PSNetAtmoModule;

@interface PSNetAtmoModuleDataType : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *modules;
@end

@interface PSNetAtmoModuleDataType (CoreDataGeneratedAccessors)

- (void)addModulesObject:(PSNetAtmoModule *)value;
- (void)removeModulesObject:(PSNetAtmoModule *)value;
- (void)addModules:(NSSet *)values;
- (void)removeModules:(NSSet *)values;

@end
