//
//  PSAppDelegate.m
//  PSNetAtmo
//
//  Created by Philip Schneider on 23.11.13.
//  Copyright (c) 2013 phschneider.net. All rights reserved.
//


#import "PSAppDelegate.h"

#import "PSNetAtmoAppVersion.h"
#import "PSNetAtmoMainViewController.h"
#import "PSNetAtmoNavigationController.h"
#import <MBFingerTipWindow.h>

#ifdef CONFIGURATION_AppStore
//    #import <Crashlytics/Crashlytics.h>
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


- (void) notificationCatched:(NSNotification*)note
{

//    if ([PSNETATMO_NOTIFICATIONS containsObject:note.name])
//    {
//        NSLog(@" ======= %@ ======= ",note.name);
//        NSLog(@" ===> %@ ",note.userInfo);
//    }
}


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

#pragma mark - AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    DLogFuncName();
    
//#ifdef DEBUG
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationCatched:) name:nil object:nil];
//#endif
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(managedObjectContextDidSave:)
//                                                 name:NSManagedObjectContextDidSaveNotification
//                                               object:self.backgroundManagedObjectContext];
    
    
    // iOS5 Warning - NO Social Framework
    // iOS5 Warning - NO Ad Framework


    UIViewController * rootViewController = [[PSNetAtmoMainViewController alloc] init];
    self.window = [[MBFingerTipWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    PSNetAtmoNavigationController * navController = [[PSNetAtmoNavigationController alloc] initWithRootViewController:rootViewController];
    self.window.rootViewController = navController;

    [self.window makeKeyAndVisible];
    
    [PSNetAtmoAppVersion sharedInstance];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    DLogFuncName();
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

}


- (void)applicationDidEnterBackground:(UIApplication *)application
{
    DLogFuncName();
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

}


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    DLogFuncName();
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.

}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    DLogFuncName();
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

//    [[iRate sharedInstance] logEvent:YES];
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    DLogFuncName();
//    [[PSNetAtmoLocalStorage sharedInstance] archive];
}


#pragma mark - CoreData
- (NSManagedObjectContext *)managedObjectContext
{
    DLogFuncName();
    if ([[NSThread currentThread] isMainThread])
    {
        NSLog(@"Main");
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
        NSLog(@"Background");
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
    }
}


// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    DLogFuncName();
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
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end