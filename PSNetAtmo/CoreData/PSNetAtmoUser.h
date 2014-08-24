//
//  PSNetAtmoUser.h
//  PSNetAtmo
//
//  Created by Philip Schneider on 02.05.14.
//  Copyright (c) 2014 phschneider.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PSNetAtmoDevice;

@interface PSNetAtmoUser : NSManagedObject

@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSData * data;
@property (nonatomic, retain) NSNumber * feelLikeAlgo;
@property (nonatomic, retain) NSNumber * isCurrentUser;
@property (nonatomic, retain) NSString * lang;
@property (nonatomic, retain) NSString * locale;
@property (nonatomic, retain) NSString * mail;
@property (nonatomic, retain) NSNumber * pressureUnit;
@property (nonatomic, retain) NSNumber * timelineNotRead;
@property (nonatomic, retain) NSNumber * unit;
@property (nonatomic, retain) NSString * userID;
@property (nonatomic, retain) NSNumber * windUnit;
@property (nonatomic, retain) NSData * oAuthAccountData;
@property (nonatomic, retain) NSSet *devices;
@property (nonatomic, retain) NSSet *friendDevices;
@end

@interface PSNetAtmoUser (CoreDataGeneratedAccessors)

- (void)addDevicesObject:(PSNetAtmoDevice *)value;
- (void)removeDevicesObject:(PSNetAtmoDevice *)value;
- (void)addDevices:(NSSet *)values;
- (void)removeDevices:(NSSet *)values;

- (void)addFriendDevicesObject:(PSNetAtmoDevice *)value;
- (void)removeFriendDevicesObject:(PSNetAtmoDevice *)value;
- (void)addFriendDevices:(NSSet *)values;
- (void)removeFriendDevices:(NSSet *)values;

@end
