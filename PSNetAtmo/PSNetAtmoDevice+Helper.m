//
//  PSNetAtmoDeviceDB.m
//  PSNetAtmo
//
//  Created by Philip Schneider on 23.11.13.
//  Copyright (c) 2013 phschneider.net. All rights reserved.
//

#import "PSNetAtmo.h"
#import "PSAppDelegate.h"
#import "PSNetAtmoDevice.h"
#import "PSNetAtmoDevice+Helper.h"

@implementation PSNetAtmoDevice (Helper)

+ (PSNetAtmoDevice *)findByID:(NSString *)deviceID context:(NSManagedObjectContext *)context
{
    DLogFuncName();
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NETATMO_ENTITY_DEVICE inManagedObjectContext:context];
    [request setEntity:entityDescription];
    [request setFetchLimit:1];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(deviceID == %@)", deviceID];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    
    NSArray *array = [context executeFetchRequest:request error:&error];
    
    PSNetAtmoDevice * device = nil;
    
    if (!error && [array count] > 0) {
        device = [array lastObject];
    }
    
    return device;
}


+ (void)updateDevicesWithData:(NSData*)data inContext:(NSManagedObjectContext*)context
{
    NSError *localError = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
    NSLog(@"ParsedObject = %@", dict);
    
    if (localError != nil)
    {
        NSLog(@"ERROR = %@", localError);
        return;
    }
    else
    {
        NSDictionary * body = [dict objectForKey:@"body"];
        NSDictionary *devices = [body objectForKey:@"devices"];
        NSDictionary *modules = [body objectForKey:@"modules"];
        
        for (NSDictionary * module in modules)
        {           
            [PSNetAtmoModule updateModuleFromJsonDict:module inContext:context];
        }
        
        
        for (NSDictionary* device in devices)
        {
            [PSNetAtmoDevice updateDeviceFromJsonDict:device inContext:context];
            
        }
    }
    
    [APPDELEGATE saveContext];
    
#warning todo
//

        
            //        //"public_ext_data" = 1;
        //        // "invitation_disable": false,
        //        // "ip": "95.91.248.184",
        //
        
        //
        //
        //#warning todo - multiple devices
        //        for (NSDictionary* device in devices)
        //        {
        //                   //
        //
        //            self.place = [[PSNetAtmoDevicePlaceDB alloc] initWithDict:[device objectForKey:@"place"]];
        //
        //            self.lastFwUpdate = [NSDate dateWithTimeIntervalSince1970:[[device objectForKey:@"last_fw_update"] integerValue]];
        //            self.consolidationDate = [NSDate dateWithTimeIntervalSince1970:[[device objectForKey:@"consolidation_date"] integerValue]];
        //
        //            #warning todo - create a module from main device
        //            self.moduleName = [device objectForKey:@"module_name"];
        //            self.battery = [device objectForKey:@"battery_vp"];
        //            self.firmware = [device objectForKey:@"firmware"];
        //            self.type = [device objectForKey:@"type"];
        //
        //            // rf_amb_status muss zu rf_status werden
        //            self.rfStatus = [device objectForKey:@"rf_amb_status"];
        //            self.dataTypes = [device objectForKey:@"data_type"];
        //            self.lastStatus = [NSDate dateWithTimeIntervalSince1970:[[device objectForKey:@"last_status_store"] integerValue]];
        //            self.lastEvent = [NSDate dateWithTimeIntervalSince1970:[[device objectForKey:@"last_event_stored"] integerValue]];
        //            self.lastAlarm = [NSDate dateWithTimeIntervalSince1970:[[device objectForKey:@"last_alarm_stored"] integerValue]];
        //
        //            // date_setup wird zu date_created
        //            self.setupDate = [NSDate dateWithTimeIntervalSince1970:[[[device objectForKey:@"date_setup"]  objectForKey:@"sec"] integerValue]];
        //
        //            NSMutableDictionary * mainModule = [[NSMutableDictionary alloc] init];
        //            [mainModule setObject:[device objectForKey:@"_id"] forKey:@"_id"];
        //            [mainModule setObject:[device objectForKey:@"module_name"] forKey:@"module_name"];
        //            [mainModule setObject:[device objectForKey:@"battery_vp"] forKey:@"battery_vp"];
        //            [mainModule setObject:[device objectForKey:@"firmware"] forKey:@"firmware"];
        //            [mainModule setObject:[device objectForKey:@"type"] forKey:@"type"];
        //            [mainModule setObject:[device objectForKey:@"rf_amb_status"] forKey:@"rf_status"];
        //            [mainModule setObject:[device objectForKey:@"data_type"] forKey:@"data_type"];
        //
        //            [mainModule setObject:[device objectForKey:@"date_setup"] forKey:@"date_created"];
        //            [mainModule setObject:[device objectForKey:@"last_alarm_stored"] forKey:@"last_alarm_stored"];
        //            [mainModule setObject:[device objectForKey:@"last_event_stored"] forKey:@"last_event_stored"];
        //            [mainModule setObject:[device objectForKey:@"last_status_store"] forKey:@"last_status_store"];
        //
        //            PSNetAtmoModuleDB * netAtmoModule = [[PSNetAtmoModuleDB alloc] initWithDictionary:mainModule];
        //            [self.modules addObject:netAtmoModule];
        //
        //
        //            NSDictionary * lastDataStore = [device objectForKey:@"last_data_store"];
        //            for (NSString * moduleID in [lastDataStore allKeys])
        //            {
        //                PSNetAtmoModuleDB * module = [self moduleWithID:moduleID];
        //                [module updateLastDataStoreFromDict:[lastDataStore objectForKey:moduleID]];
        //            }
        //        }
}


+ (void)updateDeviceFromJsonDict:(NSDictionary*)deviceDict inContext:(NSManagedObjectContext*)context
{
    DLogFuncName();
    PSNetAtmoPrivateDevice * device = [PSNetAtmoDevice findByID:[deviceDict objectForKey:@"_id"] context:context];
    
    if (!device)
    {
        device = [NSEntityDescription insertNewObjectForEntityForName:NETATMO_ENTITY_PRIVATE_DEVICE inManagedObjectContext:context];
    }
    
    device.stationName = [deviceDict objectForKey:@"station_name"];
    device.deviceID = [deviceDict objectForKey:@"_id"];
    device.wifiStatus = [deviceDict objectForKey:@"wifi_status"];
    device.accessCode = [deviceDict objectForKey:@"access_code"];
    device.co2Calibrating = [deviceDict objectForKey:@"co2_calibrating"];

    for (NSString * moduleID in [deviceDict objectForKey:@"modules"])
    {
        PSNetAtmoModule * module = [PSNetAtmoModule findByID:moduleID context:context];
        if (module && ![device.modules containsObject:module])
        {
            [device addModulesObject:module];
            module.device = device;
        }
    }
}


//@interface PSNetAtmoDevice ()
//
//@property (nonatomic) NSMutableDictionary * devices;
//
//@property (nonatomic) NSDictionary *dict;
//// Device
//@property (nonatomic) NSMutableSet *modules;
//
//@property (nonatomic) NSString *deviceId;
//@property (nonatomic) NSString *accessCode;
//@property (nonatomic) NSString *streamingKey;
//@property (nonatomic) NSNumber *wifiStatus;
//@property (nonatomic) NSString * stationName;
//@property (nonatomic) NSDate * lastFwUpdate;
//@property (nonatomic) NSDate * lastStatus;
//@property (nonatomic) NSDate * setupDate;
//@property (nonatomic) NSSet * moduleIDs;
//@property (nonatomic) NSNumber * co2Calibrating;
//@property (nonatomic) PSNetAtmoDevicePlaceDB *place;
//@property (nonatomic) NSDate *consolidationDate;
//
//// Module
//@property (nonatomic) NSString *type;
//@property (nonatomic) NSDate * lastEvent;
//@property (nonatomic) NSDate * lastAlarm;
//@property (nonatomic) NSNumber *rfStatus;
//@property (nonatomic) NSNumber *battery;
//@property (nonatomic) NSString * module;
//@property (nonatomic) NSNumber * firmware;
//@property (nonatomic) NSSet *dataTypes;
//
//@end

// TODOS

//"streaming_key" = 56e3cdc4ce715560;
//"update_device" = 0;
// "netcom_transport" = tcp
//  "invitation_disable" = 0;

// "user_owner": [          "5165a31f187759e7a1000035"        ],

//"battery_rint" = 0;

//"alarm_config" =                 {
//    "default_alarm" =                     (
//                                           {
//                                               "db_alarm_number" = 0;
//                                           },
//                                           {
//                                               "db_alarm_number" = 1;
//                                           },
//                                           {
//                                               "db_alarm_number" = 2;
//                                           },
//                                           {
//                                               "db_alarm_number" = 6;
//                                           },
//                                           {
//                                               "db_alarm_number" = 4;
//                                               desactivated = 1;
//                                           },
//                                           {
//                                               "db_alarm_number" = 5;
//                                           },
//                                           {
//                                               "db_alarm_number" = 7;
//                                           }
//                                           );
//    personnalized =                     (
//                                         {
//                                             "data_type" = 0;
//                                             "db_alarm_number" = 19;
//                                             direction = 1;
//                                             threshold = 4;
//                                         }
//                                         );
//};


- (id) initWithData:(NSData*)data error:(NSError **)error
{
    DLogFuncName();
    self = [super init];
    if (self)
    {
        NSError *localError = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
        NSLog(@"ParsedObject = %@", dict);
        
        if (localError != nil) {
            *error = localError;
            return nil;
        }

//        self.devices = [[NSMutableDictionary alloc] init];
//        self.modules = [[NSMutableSet alloc] init];
//        
//        //"public_ext_data" = 1;
//        // "invitation_disable": false,
//        // "ip": "95.91.248.184",
//        
//        NSDictionary * body = [dict objectForKey:@"body"];
//        
//        NSDictionary *modules = [body objectForKey:@"modules"];
//        for (NSDictionary * module in modules)
//        {
//            PSNetAtmoModule * netAtmoModule = [[PSNetAtmoModuleDB alloc] initWithDictionary:module];
//            [self.modules addObject:netAtmoModule];
//        }
//        
//        
//        NSDictionary *devices = [body objectForKey:@"devices"];
//#warning todo - multiple devices
//        for (NSDictionary* device in devices)
//        {
//            self.stationName = [device objectForKey:@"station_name"];
//            self.moduleIDs = [device objectForKey:@"modules"];
//            self.deviceId = [device objectForKey:@"_id"];
//            self.wifiStatus = [device objectForKey:@"wifi_status"];
//            self.rfStatus = [device objectForKey:@"rf_amb_status"];
//            self.accessCode = [device objectForKey:@"access_code"];
//            self.co2Calibrating = [device objectForKey:@"co2_calibrating"];
//
//            
//            self.place = [[PSNetAtmoDevicePlaceDB alloc] initWithDict:[device objectForKey:@"place"]];
//            
//            self.lastFwUpdate = [NSDate dateWithTimeIntervalSince1970:[[device objectForKey:@"last_fw_update"] integerValue]];
//            self.consolidationDate = [NSDate dateWithTimeIntervalSince1970:[[device objectForKey:@"consolidation_date"] integerValue]];
//
//            #warning todo - create a module from main device
//            self.moduleName = [device objectForKey:@"module_name"];
//            self.battery = [device objectForKey:@"battery_vp"];
//            self.firmware = [device objectForKey:@"firmware"];
//            self.type = [device objectForKey:@"type"];
//
//            // rf_amb_status muss zu rf_status werden
//            self.rfStatus = [device objectForKey:@"rf_amb_status"];
//            self.dataTypes = [device objectForKey:@"data_type"];
//            self.lastStatus = [NSDate dateWithTimeIntervalSince1970:[[device objectForKey:@"last_status_store"] integerValue]];
//            self.lastEvent = [NSDate dateWithTimeIntervalSince1970:[[device objectForKey:@"last_event_stored"] integerValue]];
//            self.lastAlarm = [NSDate dateWithTimeIntervalSince1970:[[device objectForKey:@"last_alarm_stored"] integerValue]];
//
//            // date_setup wird zu date_created
//            self.setupDate = [NSDate dateWithTimeIntervalSince1970:[[[device objectForKey:@"date_setup"]  objectForKey:@"sec"] integerValue]];
//
//            NSMutableDictionary * mainModule = [[NSMutableDictionary alloc] init];
//            [mainModule setObject:[device objectForKey:@"_id"] forKey:@"_id"];
//            [mainModule setObject:[device objectForKey:@"module_name"] forKey:@"module_name"];
//            [mainModule setObject:[device objectForKey:@"battery_vp"] forKey:@"battery_vp"];
//            [mainModule setObject:[device objectForKey:@"firmware"] forKey:@"firmware"];
//            [mainModule setObject:[device objectForKey:@"type"] forKey:@"type"];
//            [mainModule setObject:[device objectForKey:@"rf_amb_status"] forKey:@"rf_status"];
//            [mainModule setObject:[device objectForKey:@"data_type"] forKey:@"data_type"];
//            
//            [mainModule setObject:[device objectForKey:@"date_setup"] forKey:@"date_created"];
//            [mainModule setObject:[device objectForKey:@"last_alarm_stored"] forKey:@"last_alarm_stored"];
//            [mainModule setObject:[device objectForKey:@"last_event_stored"] forKey:@"last_event_stored"];
//            [mainModule setObject:[device objectForKey:@"last_status_store"] forKey:@"last_status_store"];
//            
//            PSNetAtmoModuleDB * netAtmoModule = [[PSNetAtmoModuleDB alloc] initWithDictionary:mainModule];
//            [self.modules addObject:netAtmoModule];
//
//
//            NSDictionary * lastDataStore = [device objectForKey:@"last_data_store"];
//            for (NSString * moduleID in [lastDataStore allKeys])
//            {
//                PSNetAtmoModuleDB * module = [self moduleWithID:moduleID];
//                [module updateLastDataStoreFromDict:[lastDataStore objectForKey:moduleID]];
//            }
//        }

        NSLog(@"ParsedObject = %@", dict);
        NSLog(@"TimeExec = %@",[dict objectForKey:@"time_exec"]);
        NSLog(@"TimeServer = %@ => %@", [dict objectForKey:@"time_server"], [NSDate dateWithTimeIntervalSince1970:[[dict objectForKey:@"time_server"] integerValue]]);
    }
    return self;
}


//+ (NSArray*) allDevicesInContext:(NSManagedObjectContext *)context
//{
//    DLogFuncName();
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:NETATMO_ENTITY_DEVICE inManagedObjectContext:context];
//    [fetchRequest setEntity:entity];
//
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"deviceID" ascending:NO];
//    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
//    [fetchRequest setSortDescriptors:sortDescriptors];
//    
//    
//    NSError *error;
//    NSArray *items = [context executeFetchRequest:fetchRequest error:&error];
//    
//    if (error)
//    {
//        NSLog(@"FETCH ERROR (allCloudFilesInContext) => %@, %@", error, [error userInfo]);
//    }
//    
//    return items;
//}


- (BOOL) isPublic
{
    DLogFuncName();
    return [self isKindOfClass: [PSNetAtmoPublicDevice class]];
}

- (BOOL) isPrivate
{
    DLogFuncName();
    return [self isKindOfClass: [PSNetAtmoPrivateDevice class]];
}

//- (BOOL) hasModuleWithID:(NSString*)moduleID
//{
//    return ([self.moduleIDs containsObject:moduleID]);
//}


//- (PSNetAtmoModuleDB *)moduleWithID:(NSString*)moduleID
//{
//    if ([self hasModuleWithID:moduleID])
//    {
//        for (PSNetAtmoModuleDB * module in self.modules)
//        {
//            if ([module.moduleID isEqualToString:moduleID])
//            {
//                return module;
//            }
//        }
//    }
//    return nil;
//}
//
//
//- (NSDictionary*) lastDataStoreForModule:(NSString*)moduleID
//{
//    // a = Temp
//    // b = humidy
//    return [[[[self.dict objectForKey:@"devices"] objectAtIndex:0] objectForKey:@"last_data_store"] objectForKey:moduleID];
//}
//
//
//- (NSString*) description
//{
//    return [NSString stringWithFormat:@"DESCRIPTION (DEVICE):\n ID: %@\n Name: %@\n", self.deviceId, self.deviceName];
//}

@end
