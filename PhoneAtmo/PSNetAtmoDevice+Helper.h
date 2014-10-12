//
//  PSNetAtmoDeviceDB.h
//  PSNetAtmo
//
//  Created by Philip Schneider on 23.11.13.
//  Copyright (c) 2013 phschneider.net. All rights reserved.
//

#import "PSNetAtmoDevice.h"

@interface PSNetAtmoDevice (Helper)

@property (nonatomic) NSString *deviceName;

+ (PSNetAtmoDevice *)findByID:(NSString *)deviceID context:(NSManagedObjectContext *)context;
+ (void)updateDevicesWithData:(NSData*)data inContext:(NSManagedObjectContext*)context;
+ (void)updateDeviceFromJsonDict:(NSDictionary*)deviceDict inContext:(NSManagedObjectContext*)context;

- (id) updateWithData:(NSData*)data error:(NSError **)error;
- (NSDictionary*) lastDataStoreForModule:(NSString*)moduleID;

+ (NSArray*) allDevicesInContext:(NSManagedObjectContext *)context;

- (BOOL) isPublic;
- (BOOL) isPrivate;

@end
