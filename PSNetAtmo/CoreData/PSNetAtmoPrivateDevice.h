//
//  PSNetAtmoPrivateDevice.h
//  PSNetAtmo
//
//  Created by Philip Schneider on 21.04.14.
//  Copyright (c) 2014 phschneider.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PSNetAtmoDevice.h"

@class PSNetAtmoUser;

@interface PSNetAtmoPrivateDevice : PSNetAtmoDevice

@property (nonatomic, retain) NSDate * consolidationDate;
@property (nonatomic, retain) NSNumber * invitationDisable;
@property (nonatomic, retain) NSDate * lastFwUpdate;
@property (nonatomic, retain) NSNumber * publicExtData;
@property (nonatomic, retain) NSDate * setupDate;
@property (nonatomic, retain) NSString * streamingKey;
@property (nonatomic, retain) PSNetAtmoUser *owner;
@property (nonatomic, retain) PSNetAtmoUser *user;

@end
