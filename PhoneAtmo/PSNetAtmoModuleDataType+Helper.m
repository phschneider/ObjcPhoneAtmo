//
//  PSNetAtmoModuleDataType+Helper.m
//  PSNetAtmo
//
//  Created by Philip Schneider on 21.04.14.
//  Copyright (c) 2014 phschneider.net. All rights reserved.
//

#import "PSNetAtmo.h"
#import "PSNetAtmoModuleDataType+Helper.h"

@implementation PSNetAtmoModuleDataType (Helper)


+ (PSNetAtmoModuleDataType *)finyByName:(NSString *)name context:(NSManagedObjectContext *)context
{
    DLogFuncName();
    DEBUG_CORE_DATA_LogName();
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NETATMO_ENTITY_MODULE_DATA_TYPE inManagedObjectContext:context];
    [request setEntity:entityDescription];
    [request setFetchLimit:1];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(name == %@)", name];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    
    NSArray *array = [context executeFetchRequest:request error:&error];
    PSNetAtmoModuleDataType * dataType = nil;
    
    if (!error && [array count] > 0) {
        dataType = [array lastObject];
    }
    
    return dataType;
}


+ (BOOL) existsInDB:(NSString*)name context:(NSManagedObjectContext*) context
{
    DLogFuncName();
    DEBUG_CORE_DATA_LogName();
    
    return ([PSNetAtmoModuleDataType finyByName:name context:(NSManagedObjectContext *)context] != nil);
}


- (NSString *)description
{
    DLogFuncName();
    DEBUG_CORE_DATA_LogName();
    
    return [NSString stringWithFormat:@"< %p %@> %@",self, self.class, self.name];
}

@end
