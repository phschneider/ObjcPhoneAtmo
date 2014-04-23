//
//  PSNetAtmoMeasureDB.m
//  PSNetAtmo
//
//  Created by Philip Schneider on 23.11.13.
//  Copyright (c) 2013 phschneider.net. All rights reserved.
//

#import "PSNetAtmo.h"
#import "PSAppDelegate.h"
#import "PSNetAtmoModuleMeasure+Helper.h"

#define MEASURE_DEFAULT_VALUE   @-100

@implementation PSNetAtmoModuleMeasure (Helper)

+ (PSNetAtmoModuleMeasure *)finyByModule:(PSNetAtmoModule *)module andDate:(NSDate *)date context:(NSManagedObjectContext *)context
{
    DLogFuncName();
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NETATMO_ENTITY_MODULE_MEASURE inManagedObjectContext:context];
    [request setEntity:entityDescription];
    [request setFetchLimit:1];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(module == %@ AND date == %@)", module, date];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    
    NSArray *array = [context executeFetchRequest:request error:&error];
    PSNetAtmoModuleMeasure * measure = nil;
    
    if (!error && [array count] > 0) {
        measure = [array lastObject];
    }
    
    return measure;
}


+ (BOOL) existsInDB:(PSNetAtmoModule *)module date:(NSDate*)date context:(NSManagedObjectContext*) context
{
    DLogFuncName();
    return ([PSNetAtmoModuleMeasure finyByModule:module andDate:date context:(NSManagedObjectContext *)context] != nil);
}


- (void) updateWithDictionary:(NSDictionary *)dataDict
{
    DLogFuncName();
    
    for (NSString *keyString in @[ @"noise", @"co2", @"humidity", @"pressure", @"temperature"])
    {
        if ([dataDict objectForKey:keyString])
        {
            if ( [self valueForKey:keyString])
            {
                [self setValue:[dataDict objectForKey:keyString] forKey:keyString];
            }
            else
            {
                NSLog(@"No value for key %@", keyString);
            }
        }
        else
        {
            NSLog(@"No value for key %@", keyString);
        }
    }
}


- (NSString *) formattedTemperature
{
    DLogFuncName();
    NSString *value = @"";
    if (![self.temperature isEqual:MEASURE_DEFAULT_VALUE])
    {
        value = [NSString stringWithFormat:@"%.1f°", [[self temperature] floatValue] ];
    }
    return value;
}


- (NSString *) formattedHumidity
{
    DLogFuncName();
    
    NSString *value = @"";
    if (![self.humidity isEqual:MEASURE_DEFAULT_VALUE])
    {
        value = [NSString stringWithFormat:@"%.1f%%", [[self humidity] floatValue]];
    }
    return value;
}


- (NSString *) formattedPressure
{
    DLogFuncName();
    NSString *value = @"";
    if (![self.pressure isEqual:MEASURE_DEFAULT_VALUE])
    {
        value = [NSString stringWithFormat:@"%.1fmbar", [[self pressure] floatValue] ];
    }
    return value;
}


- (NSString *) formattedCo2
{
    DLogFuncName();
    NSString *value = @"";
    if (![self.co2 isEqual:MEASURE_DEFAULT_VALUE])
    {
        value = [NSString stringWithFormat:@"%.1fppm", [[self co2] floatValue] ];
    }
    return value;
}


- (NSString *) formattedNoise
{
    DLogFuncName();
    NSString *value = @"";
    if (![self.noise isEqual:MEASURE_DEFAULT_VALUE])
    {
        value = [NSString stringWithFormat:@"%.1fdb", [[self noise] floatValue] ];
    }
    return value;
}




- (NSString *) formattedDateTime
{
    DLogFuncName();
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    return [dateFormatter stringFromDate:self.date];
}
@end
