//
//  PSNetAtmoModules.m
//  PSNetAtmo
//
//  Created by Philip Schneider on 07.12.13.
//  Copyright (c) 2013 phschneider.net. All rights reserved.
//


#import "PSNetAtmo.h"
#import "PSAppDelegate.h"
#import "PSNetAtmoModule+Helper.h"
#import "PSNetAtmoModuleDataType+Helper.h"

//@interface PSNetAtmoModuleDB ()
//
//@property (nonatomic, strong)  NSDictionary *dict;
//
//@property (nonatomic) NSNumber *battery;
//@property (nonatomic) NSNumber *firmware;
//@property (nonatomic) NSString *type;
//@property (nonatomic) NSDate *lastAlarm;
//@property (nonatomic) NSDate *lastEvent;
//@property (nonatomic) NSDate *lastMessage;
//@property (nonatomic) NSDate *lastSeen;
//@property (nonatomic) NSDate *createdAt;
//@property (nonatomic) NSNumber *rfStatus;
//@property (nonatomic) NSNumber *manualPairing;
//@property (nonatomic) NSSet * dataTypes;
//@property (nonatomic) PSNetAtmoDeviceDB * device;
//
//@property (nonatomic) NSDictionary *lastDataStore;
//
//@end

@implementation PSNetAtmoModule (Helper)

+ (PSNetAtmoModule *)findByID:(NSString *)moduleID context:(NSManagedObjectContext *)context
{
    DLogFuncName();
    NSAssert(moduleID, @"No moduleID given");
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NETATMO_ENTITY_MODULE inManagedObjectContext:context];
    [request setEntity:entityDescription];
    [request setFetchLimit:1];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(moduleID == %@)", moduleID];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    
    NSArray *array = [context executeFetchRequest:request error:&error];
    
    PSNetAtmoModule * module = nil;
    
    if (!error && [array count] > 0) {
        module = [array lastObject];
    }
    
    return module;
}

+ (void)updateModuleFromJsonDict:(NSDictionary*)dict inContext:(NSManagedObjectContext*)context
{
    DLogFuncName();
    PSNetAtmoModule * module = [PSNetAtmoModule findByID:[dict objectForKey:@"_id"] context:context];
    
    if (!module)
    {
        module = [NSEntityDescription insertNewObjectForEntityForName:NETATMO_ENTITY_MODULE inManagedObjectContext:context];
    }

    module.moduleID = [dict objectForKey:@"_id"];
    module.deviceID = [dict objectForKey:@"main_device"];
    module.battery = [dict objectForKey:@"battery_vp"];
    module.firmware = [dict objectForKey:@"firmware"];
    
    for (NSString * dataTypeString in [dict objectForKey:@"data_type"])
    {
        PSNetAtmoModuleDataType * dataType = [PSNetAtmoModuleDataType finyByName:dataTypeString context:context];
        if (!dataType)
        {
            dataType = [NSEntityDescription insertNewObjectForEntityForName:NETATMO_ENTITY_MODULE_DATA_TYPE inManagedObjectContext:context];
            dataType.name = dataTypeString;
        }
        
        [module addDataTypesObject:dataType];
        [dataType addModulesObject:module];
    }
    
    //    module.wifiStatus = [dict objectForKey:@"wifi_status"];
//    module.accessCode = [dict objectForKey:@"access_code"];
//    module.co2Calibrating = [dict objectForKey:@"co2_calibrating"];
//    
//
//    module.moduleName = [dict objectForKey:@"module_name"];
//    module.battery = [dict objectForKey:@"battery_vp"];

//    module.type = [dict objectForKey:@"type"];
    module.rfStatus = [dict objectForKey:@"rf_status"];
//
//    module.dataTypes = [dict objectForKey:@"data_type"];
    module.type = [dict objectForKey:@"type"];
    module.name = [dict objectForKey:@"module_name"];
    if ([dict objectForKey:@"manual_pairing"])
    {
        module.manualPairing = [dict objectForKey:@"manual_pairing"];
    }
    
    module.createdAt = [NSDate dateWithTimeIntervalSince1970:[[[dict objectForKey:@"date_creation"] objectForKey:@"sec"] integerValue]];
    module.lastAlarm = [NSDate dateWithTimeIntervalSince1970:[[dict objectForKey:@"last_alarm_stored"] integerValue]];
    module.lastEvent = [NSDate dateWithTimeIntervalSince1970:[[dict objectForKey:@"last_event_stored"] integerValue]];
    module.lastMessage = [NSDate dateWithTimeIntervalSince1970:[[dict objectForKey:@"last_message"] integerValue]];
    module.lastSeen = [NSDate dateWithTimeIntervalSince1970:[[dict objectForKey:@"last_seen"] integerValue]];
}

- (int) tag
{
    return [[self.deviceID stringByReplacingOccurrencesOfString:@":" withString:@""] integerValue];
}

//- (id) initWithData:(NSData*)data error:(NSError**)error
//{
//    DLogFuncName();
//    self = [super init];
//    if (self)
//    {
//        NSError *localError = nil;
//        NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
//        
//        if (localError != nil) {
//            *error = localError;
//            return nil;
//        }
//
//        self = [self initWithDictionary:parsedObject];
//    }
//    return self;
//}


//- (id) initWithDictionary:(NSDictionary*)dict
//{
//    DLogFuncName();
//    self = [super init];
//    if (self)
//    {
////        self.dict = dict;
//        
//        self.moduleID = [dict objectForKey:@"_id"];
//        self.moduleName = [dict objectForKey:@"module_name"];
//        self.battery = [dict objectForKey:@"battery_vp"];
//        self.firmware = [dict objectForKey:@"firmware"];
//        self.type = [dict objectForKey:@"type"];
//        self.rfStatus = [dict objectForKey:@"rf_status"];
//        
//        self.dataTypes = [dict objectForKey:@"data_type"];
//
//        self.manualPairing = [dict objectForKey:@"manual_pairing"];
//        self.createdAt = [NSDate dateWithTimeIntervalSince1970:[[[dict objectForKey:@"date_creation"] objectForKey:@"sec"] integerValue]];
//        self.lastAlarm = [NSDate dateWithTimeIntervalSince1970:[[dict objectForKey:@"last_alarm_stored"] integerValue]];
//        self.lastEvent = [NSDate dateWithTimeIntervalSince1970:[[dict objectForKey:@"last_event_stored"] integerValue]];
//        self.lastMessage = [NSDate dateWithTimeIntervalSince1970:[[dict objectForKey:@"last_message"] integerValue]];
//        self.lastSeen = [NSDate dateWithTimeIntervalSince1970:[[dict objectForKey:@"last_seen"] integerValue]];
//        
//#warning todo - device zuordnung
//        // "main_device" = "70:ee:50:00:51:26";
//        
//    }
//    return self;
//}

- (void) refresh
{
    DLogFuncName();
    [PSNetAtmoApi measureForDevice:self.device andModule:self];
}


- (void) requestLastMeasure
{
    DLogFuncName();
    [PSNetAtmoApi lastMeasureForDevice:self.device andModule:self];
}


- (void) refreshDevice
{
    DLogFuncName();
    NSLog(@"TODO");
}


- (NSString *)typeStringForLastMeasureRequest
{
    DLogFuncName();
    return [[[self.dataTypes allObjects] valueForKey:@"name"] componentsJoinedByString:@","];
}


- (void) updateMeasuresWithData:(NSData *)data
{
    DLogFuncName();
    
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
    NSLog(@"ParsedObject = %@", parsedObject);
   
    
    // [[parsedObject objectForKey:@"body"] objectAtIndex:0]
    // [[[parsedObject objectForKey:@"body"] objectAtIndex:0] objectForKey:@"step_time"]
    // [[[parsedObject objectForKey:@"body"] objectAtIndex:0] objectForKey:@"beg_time"]
    
    NSDictionary *body = [[parsedObject objectForKey:@"body"] objectAtIndex:0];
    NSString *status = [body objectForKey:@"status"];
    NSTimeInterval serverTime = [[body objectForKey:@"time_server"] floatValue];
    NSTimeInterval execTime = [[body objectForKey:@"time_exec"] floatValue];
    NSTimeInterval beginTime = [[body objectForKey:@"beg_time"] floatValue];
    NSTimeInterval stepTime = [[body objectForKey:@"step_time"] floatValue];
    NSTimeInterval valueTime = beginTime;
    NSArray *values = [[[parsedObject objectForKey:@"body"] objectAtIndex:0] objectForKey:@"value"];
    
    //Vermutung: Die Reihenfolge der DataTypesString muss die gleiche sein wie bei der Anfrage
    NSArray *dataTypes = [[[self typeStringForLastMeasureRequest] lowercaseString] componentsSeparatedByString:@","] ;
    
    NSLog(@"ServerTime = %@", [NSDate dateWithTimeIntervalSince1970:serverTime]);
    for (NSArray *value in values)
    {
        NSDictionary *dataValues = [NSDictionary dictionaryWithObjects:value forKeys:dataTypes];
        NSDate *measureDate = [NSDate dateWithTimeIntervalSince1970:valueTime];
        NSLog(@"Time = %f (%@) DataValues = %@ DataTypes = %@ Value = %@",valueTime,measureDate , dataValues, dataTypes, value);
        valueTime += stepTime;
        
        PSNetAtmoModuleMeasure *measure = [PSNetAtmoModuleMeasure finyByModule:self andDate:measureDate context:self.managedObjectContext];
        if (!measure)
        {
            measure = [NSEntityDescription insertNewObjectForEntityForName:NETATMO_ENTITY_MODULE_MEASURE inManagedObjectContext:self.managedObjectContext];
            measure.date = measureDate;
            [self addMeasuresObject:measure];
            measure.module = self;
        }
        
        [measure updateWithDictionary:dataValues];
    }
    
    [APPDELEGATE saveContext];
}


- (BOOL) hasTemperature
{
    DLogFuncName();
    return [self.dataTypes containsObject:@"Temperature"];
}


- (BOOL) hasHumidity
{
    DLogFuncName();
    return [self.dataTypes containsObject:@"Humidity"];
}


- (BOOL) hasCo2
{
    DLogFuncName();
    return [self.dataTypes containsObject:@"Co2"];
}


- (BOOL) hasPressure
{
    DLogFuncName();
    return [self.dataTypes containsObject:@"Pressure"];
}


- (BOOL) hasNoise
{
    DLogFuncName();
    return [self.dataTypes containsObject:@"Noise"];
}


- (void) updateLastDataStoreFromDict:(NSDictionary *)dict
{
    DLogFuncName();
   self.lastDataStore = dict;
}

- (NSString*) lastTemperature
{
    DLogFuncName();
    
    NSString *tempString = @"- °";
    NSArray *measures = [self.measures sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]]];
    measures = [measures filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"temperature != -100"]];
    
    if ([measures count] > 0)
    {
        tempString = [NSString stringWithFormat:@"%.1f°", [[[measures lastObject] temperature] floatValue] ];
    }
    
    NSLog(@"TempString = %@",tempString);
    return tempString;
}


- (NSString*) lastHumidity
{
    DLogFuncName();
    
    NSString *tempString = @"- %";
    NSArray *measures = [self.measures sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]]];
    measures = [measures filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"humidity != -100"]];
    
    if ([measures count] > 0)
    {
        tempString = [NSString stringWithFormat:@"%.1f%%", [[[measures lastObject] humidity] floatValue] ];
    }
    
    NSLog(@"TempString = %@",tempString);
    return tempString;
}


- (NSString*) lastPressure
{
    DLogFuncName();
    
    NSString *tempString = @"-";
    NSArray *measures = [self.measures sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]]];
    measures = [measures filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"pressure != -100"]];
    
    if ([measures count] > 0)
    {
        tempString = [NSString stringWithFormat:@"%.1f", [[[measures lastObject] pressure] floatValue] ];
    }
    
    NSLog(@"TempString = %@",tempString);
    return tempString;
}



- (NSString*) lastCo2
{
    DLogFuncName();
    
    NSString *tempString = @"-";
    NSArray *measures = [self.measures sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]]];
    measures = [measures filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"co2 != -100"]];
    
    if ([measures count] > 0)
    {
        tempString = [NSString stringWithFormat:@"%.1f", [[[measures lastObject] co2] floatValue] ];
    }
    
    NSLog(@"TempString = %@",tempString);
    return tempString;
}



- (NSArray *)temperatures
{
    DLogFuncName();
    return nil;
}


- (NSString*) lastNoise
{
    DLogFuncName();
    return @"";
}


- (NSString*) description
{
    DLogFuncName();
    return [NSString stringWithFormat:@"DESCRIPTION (Module):\n ID: %@\n Name: %@\n", self.deviceID, self.name];
}

@end
