//
//  PSAppDelegate.h
//  PSNetAtmo
//
//  Created by Philip Schneider on 23.11.13.
//  Copyright (c) 2013 phschneider.net. All rights reserved.
//

#import <UIKit/UIKit.h>

#define APPDELEGATE ((PSAppDelegate*)[[UIApplication sharedApplication] delegate])
@class MBFingerTipWindow;

@class PSNetAtmoDevicesViewController;
@class PSNetAtmoProfilesViewController;
@class PSNetAtmoSettingsViewController;

@interface PSAppDelegate : UIResponder <UIApplicationDelegate>

#ifndef CONFIGURATION_AppStore
@property (strong, nonatomic) MBFingerTipWindow *window;
#else
@property (strong, nonatomic) UIWindow *window;
#endif

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectContext *backgroundManagedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic) PSNetAtmoDevicesViewController *devicesViewController;
@property (nonatomic) PSNetAtmoProfilesViewController *profilesViewController;
@property (nonatomic) PSNetAtmoSettingsViewController *settingsViewController;

+ (NSManagedObjectContext *)managedObjectContext;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end                                                           
