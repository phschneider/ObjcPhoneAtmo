//
//  PSNetAtmoUserDB.h
//  PSNetAtmo
//
//  Created by Philip Schneider on 23.11.13.
//  Copyright (c) 2013 phschneider.net. All rights reserved.
//

#import "PSNetAtmoUser.h"

@class NXOAuth2Account;
@interface PSNetAtmoUser (Helper)

- (id) initWithData:(NSData*)data error:(NSError **)error;

+ (void)updateUserWithData:(NSData *)data inContext:(NSManagedObjectContext *)context;

+ (NSArray *) allUsersInContext:(NSManagedObjectContext *)context;

+ (PSNetAtmoUser *) findByID:(NSString *)userID context:(NSManagedObjectContext *)context;

+ (void) updateUserFromJsonDict:(NSDictionary *)dict inContext:(NSManagedObjectContext *)context withAccount:(NXOAuth2Account *)account;

+ (void) setCurrentUserFromJsonDict:(NSDictionary *)dictionary inContext:(NSManagedObjectContext *)context withAccount:(NXOAuth2Account *)account;

+ (void) resetCurrentUserInContext:(NSManagedObjectContext *)context;

+ (PSNetAtmoUser *) currentuser;

- (void) delete;

- (NXOAuth2Account*)oAuthAccount;

- (NSString *) expireString;
@end
