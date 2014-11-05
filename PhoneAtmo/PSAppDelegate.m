//
//  PSAppDelegate.m
//  PSNetAtmo
//
//  Created by Philip Schneider on 23.11.13.
//  Copyright (c) 2013 phschneider.net. All rights reserved.
//


#import "PSAppDelegate.h"

#import "PSNetAtmoProfilesViewController.h"
#import "PSNetAtmoDevicesViewController.h"
#import "PSNetAtmoNavigationController.h"
#import "NSObject+Runtime.h"
#import "PSNetAtmoNotification.h"
#import "PSNetAtmoAccountWithAuthHandler.h"
#import <MBFingerTipWindow.h>

#ifdef CONFIGURATION_AppStore
    #import <Crashlytics/Crashlytics.h>
#else
    #import "TestFlight.h"
    #import <AdSupport/AdSupport.h>
//      #import <LookBack/LookBack.h>
#endif


@implementation PSAppDelegate

@synthesize managedObjectContext            = _managedObjectContext;
@synthesize backgroundManagedObjectContext  = _backgroundManagedObjectContext;
@synthesize managedObjectModel              = _managedObjectModel;
@synthesize persistentStoreCoordinator      = _persistentStoreCoordinator;


#pragma mark - Helper
//+ (void)initialize
//{
//    DLogFuncName();
//    [[iRate sharedInstance] setAppStoreID:783111887];
//    [[iRate sharedInstance] setUsesPerWeekForPrompt:5.0];
//    [[iRate sharedInstance] setRemindPeriod:7];
//    [[iRate sharedInstance] setDaysUntilPrompt:7];
//}


//- (void)initIVersion
//{
//    DLogFuncName();
//    [[iVersion sharedInstance] setAppStoreID:783111887];
//    [[iVersion sharedInstance] setGroupNotesByVersion:YES];
//    [[iVersion sharedInstance] setCheckPeriod:3];
//    [[iVersion sharedInstance] setCheckPeriod:3];
//}


- (void) initTestFlight
{
    DLogFuncName();
    DEBUG_APPCYCLE_LogName();
    
#ifdef CONFIGURATION_Beta
    NSLog(@"Beta Build");
        NSLog(@"PhoneAtmo Build");
        [TestFlight takeOff:@"66091025-afcf-4ada-8077-bfcfd501253e"];
#endif
    
#ifdef CONFIGURATION_Debug
    NSLog(@"Debug Build");
        NSLog(@"PhoneAtmo Build");
        [TestFlight takeOff:@"e9f0d4b0-8d81-4698-853d-2a4cb7d26171"];
#endif
    
}


- (void) initCrashLytics
{
    DLogFuncName();
    DEBUG_APPCYCLE_LogName();
    
#ifdef CONFIGURATION_AppStore
    NSLog(@"PhoneAtmo Build");
    [Crashlytics startWithAPIKey:@"c13fd4d9aee54009fd4750058c84e02db744864d"];
#endif
    
}


#pragma mark - AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    DLogFuncName();
    DEBUG_APPCYCLE_LogName();
    
#ifdef CONFIGURATION_AppStore
    NSLog(@"AppStore Build");
    [self initCrashLytics];
#else
    [self initTestFlight];
#endif

    [PSNetAtmoNotification sharedInstance];
    [PSNetAtmoAccountWithAuthHandler sharedInstance];

#define TRACKING_ID_APPSTORE    @"UA-50438211-1"
#define TRACKING_ID_BETA        @"UA-50438211-2"
#define TRACKING_ID_DEBUG       @"UA-50438211-3"
    
    self.devicesViewController = [[PSNetAtmoDevicesViewController alloc] init];
    self.profilesViewController = [[PSNetAtmoProfilesViewController alloc] init];

//    UIViewController *rootViewController = nil;
//    if ([[PSNetAtmoApiAccount sharedInstance] hasAccount])
//    {
//        rootViewController = self.devicesViewController;
//    }
//    else
//    {
//        NSLog(@"No ACCOUNT :(");
//        rootViewController = self.profilesViewController;
//    }
    
    PSNetAtmoNavigationController * navController = [[PSNetAtmoNavigationController alloc] initWithRootViewController:self.devicesViewController];
    
    self.window = [[MBFingerTipWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = navController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    DLogFuncName();
    DEBUG_APPCYCLE_LogName();
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    DLogFuncName();
    DEBUG_APPCYCLE_LogName();
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    DLogFuncName();
    DEBUG_APPCYCLE_LogName();
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.

}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    DLogFuncName();
    DEBUG_APPCYCLE_LogName();
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

//    [[iRate sharedInstance] logEvent:YES];
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    DLogFuncName();
    DEBUG_APPCYCLE_LogName();
    
//    [[PSNetAtmoLocalStorage sharedInstance] archive];
}


#pragma mark - CoreData
- (NSManagedObjectContext *)managedObjectContext
{
    DLogFuncName();
    DEBUG_APPCYCLE_LogName();
    
    if ([[NSThread currentThread] isMainThread])
    {
//        NSLog(@"managedObjectContext Main");
        if (_managedObjectContext != nil && _managedObjectContext.persistentStoreCoordinator != nil)
        {
            return _managedObjectContext;
        }
        
        NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
        if (coordinator != nil)
        {
            _managedObjectContext = [[NSManagedObjectContext alloc] init];
            [_managedObjectContext setPersistentStoreCoordinator:coordinator];
        }
        return _managedObjectContext;
    }
    else
    {
        NSLog(@"managedObjectContext Background");
        if (_backgroundManagedObjectContext != nil && _backgroundManagedObjectContext.persistentStoreCoordinator != nil)
        {
            return _backgroundManagedObjectContext;
        }
        else
        {
            return [self backgroundManagedObjectContext];
        }
    }
}



- (NSManagedObjectContext *)backgroundManagedObjectContext
{
    DLogFuncName();
    DEBUG_APPCYCLE_LogName();
    
    if ([[NSThread currentThread] isMainThread])
    {
        NSLog(@"WARNING using tmpManagedObjectContext in Main Thread");
    }
    
    if (_backgroundManagedObjectContext != nil && _backgroundManagedObjectContext.persistentStoreCoordinator != nil)
    {
        return _backgroundManagedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    
    if (coordinator != nil) {
        _backgroundManagedObjectContext = [[NSManagedObjectContext alloc] init];
        [_backgroundManagedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    //    __tmpManagedObjectContext.parentContext = __managedObjectContext;
    
    return _backgroundManagedObjectContext;
}


#pragma mark - Core Data stack
- (void)saveContext
{
    DLogFuncName();
    DEBUG_APPCYCLE_LogName();
    
    NSError *error = nil;
    
    NSManagedObjectContext *managedObjectContext = nil;
    if ([[NSThread currentThread] isMainThread])
    {
        managedObjectContext = self.managedObjectContext;
    }
    else
    {
        managedObjectContext = self.backgroundManagedObjectContext;
    }
    
    
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            NSString * message = [error localizedDescription];
            dispatch_async(dispatch_get_main_queue(),^{
                [[[UIAlertView alloc] initWithTitle:@"Save failed" message:message delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil] show];
            });
            abort();
        }
        else
        {
            NSLog(@"NOT HAS CHANGES ");
        }
    }
}


// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    DLogFuncName();
    DEBUG_APPCYCLE_LogName();
    
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"PSNetAtmo" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    DLogFuncName();
    DEBUG_APPCYCLE_LogName();
    
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"PSNetAtmo.sqlite"];
    
    NSError *error = nil;
    NSDictionary *pscOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                                [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption,
                                nil];    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:pscOptions error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    DLogFuncName();
    DEBUG_APPCYCLE_LogName();
    
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end