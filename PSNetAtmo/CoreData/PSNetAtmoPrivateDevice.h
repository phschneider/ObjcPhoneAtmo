//
//  PSNetAtmoPrivateDevice.h
//  PSNetAtmo
//
//  Created by Philip Schneider on 13.12.13.
//  Copyright (c) 2013 phschneider.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PSNetAtmoDevice.h"

@class PSNetAtmoUser;

@interface PSNetAtmoPrivateDevice : PSNetAtmoDevice

@property (nonatomic, retain) NSString * accessCode;
@property (nonatomic, retain) NSNumber * co2Calibrating;
@property (nonatomic, retain) NSDate * consolidationDate;
@property (nonatomic, retain) NSData * data;
@property (nonatomic, retain) NSNumber * invitationDisable;
@property (nonatomic, retain) NSString * ip;
@property (nonatomic, retain) NSDate * lastFwUpdate;
@property (nonatomic, retain) NSNumber * publicExtData;
@property (nonatomic, retain) NSDate * setupDate;
@property (nonatomic, retain) NSString * stationName;
@property (nonatomic, retain) NSString * streamingKey;
@property (nonatomic, retain) NSNumber * wifiStatus;
@property (nonatomic, retain) PSNetAtmoUser *owner;
@property (nonatomic, retain) PSNetAtmoUser *user;

@end
