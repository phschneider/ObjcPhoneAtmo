//
//  PSNetAtmoModules.m
//  PSNetAtmo
//
//  Created by Philip Schneider on 07.12.13.
//  Copyright (c) 2013 phschneider.net. All rights reserved.
//


#import "PSNetAtmo.h"
#import "PSNetAtmoModule+Helper.h"


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
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(deviceID == %@)", moduleID];
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

    module.deviceID = [dict objectForKey:@"_id"];
    module.battery = [dict objectForKey:@"battery_vp"];
    module.firmware = [dict objectForKey:@"firmware"];
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
    
#warning TODO    "main_device" = "70:ee:50:00:51:26";
#warning TODO  "data_type" =     (    Temperature,    Humidity);
    
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

- (NSString*) lastTemp
{
    DLogFuncName();
    return @"";
}


- (NSString*) lastCo2
{
    DLogFuncName();
    return @"";
}


- (NSString*) lastHumidy
{
    DLogFuncName();
    return @"";
}


- (NSString*) lastPressure
{
    DLogFuncName();
    return @"";
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
