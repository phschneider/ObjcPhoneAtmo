//
//  PSNetAtmoModules.h
//  PSNetAtmo
//
//  Created by Philip Schneider on 07.12.13.
//  Copyright (c) 2013 phschneider.net. All rights reserved.
//

#import "PSNetAtmoModule.h"

@interface PSNetAtmoModule (Helper)

+ (PSNetAtmoModule *)findByID:(NSString *)moduleID context:(NSManagedObjectContext *)context;
+ (void)updateModuleFromJsonDict:(NSDictionary*)dict inContext:(NSManagedObjectContext*)context;


- (int) tag;
- (void) refresh;

- (void) requestLastMeasure;
- (NSString *)typeStringForLastMeasureRequest;

- (void) updateMeasuresWithData:(NSData *)data;
- (NSString*) lastTemperature;
- (NSString*) lastHumidity;
- (NSString*) lastPressure;
- (NSString*) lastCo2;

//@property (nonatomic) NSString *moduleID;
//@property (nonatomic) NSString *moduleName;

//- (id) initWithData:(NSData*)data error:(NSError**)error;
//- (id) initWithDictionary:(NSDictionary*)dict;

//- (void)updateLastDataStoreFromDict:(NSDictionary *)dict;
@end
