//
//  PSNetAtmoApi.m
//  PSNetAtmo
//
//  Created by Philip Schneider on 08.12.13.
//  Copyright (c) 2013 phschneider.net. All rights reserved.
//

#import "PSAppDelegate.h"

#import "PSNetAtmo.h"
#import "PSNetAtmoApi.h"
#import "PSNetAtmoAccount.h"

#import <MapKit/MapKit.h>

@implementation PSNetAtmoApi

#pragma mark - API
+ (void) user
{
    DLogFuncName();
//    NXOAuth2Account * account = [[PSNetAtmoAccount sharedInstance] account];
//    
//    [NXOAuth2Request performMethod:@"GET"
//                        onResource:[NSURL URLWithString:NETATMO_URL_USER]
//                   usingParameters:@{@"access_token" : account.accessToken.accessToken}
//                       withAccount:account
//               sendProgressHandler:^(unsigned long long bytesSend, unsigned long long bytesTotal)  {  }// e.g., update a progress indicator }
//                   responseHandler:^(NSURLResponse *response, NSData *responseData, NSError *error){
//                       // Process the response
//                       
//                       DEBUG_REQUEST_REPONSE_Log(@"account.accessToken.accessToken = %@", account.accessToken.accessToken);
//                       DEBUG_REQUEST_REPONSE_Log(@"Responsed = %@", response);
//                       DEBUG_REQUEST_REPONSE_Log(@"Error = %@", error);
//                       DEBUG_REQUEST_REPONSE_Log(@"Data = %@", [NSString stringWithUTF8String:[responseData bytes]]);
//                       
//                       if (!error && [responseData length])
//                       {
//                           [[PSNetAtmoUser alloc] initWithData:responseData error:nil];
//                       }
//                   }];
}






#pragma mark - API
+ (void) devices
{
    DLogFuncName();
    NXOAuth2Account * account = [[PSNetAtmoAccount sharedInstance] account];
    NSAssert(account,@"no account given");

    [NXOAuth2Request performMethod:@"GET"
                        onResource:[NSURL URLWithString:NETATMO_URL_DEVICE_LIST]
                   usingParameters:@{@"access_token" : account.accessToken.accessToken}
                       withAccount:account
               sendProgressHandler:^(unsigned long long bytesSend, unsigned long long bytesTotal)  {  }// e.g., update a progress indicator }
                   responseHandler:^(NSURLResponse *response, NSData *responseData, NSError *error){
                       // Process the response
                       
//                       NSLog(@"account.accessToken.accessToken = %@", account.accessToken.accessToken);
                       NSLog(@"Responsed = %@", response);
                       NSLog(@"Error = %@", error);
//                       NSLog(@"Data = %@", [NSString stringWithUTF8String:[responseData bytes]]);
                       [PSNetAtmoDevice updateDevicesWithData:responseData inContext:APPDELEGATE.managedObjectContext];
//
//                       PSNetAtmoDeviceDB * device = [[PSNetAtmoDeviceDB alloc] initWithData:responseData error:nil];
//                       
//                       NSLog(@"Schlafzimmer = %@", [device lastDataStoreForModule:@"03:00:00:00:3d:2a"]);
//                       NSLog(@"Balkon = %@", [device lastDataStoreForModule:@"02:00:00:00:4f:30"]);
//                       NSLog(@"Badezimmer = %@", [device lastDataStoreForModule:@"03:00:00:00:43:56"]);
//                       NSLog(@"Wohnzimmer = %@", [device lastDataStoreForModule:@"03:00:00:00:0 :0 "]);
                       
//                       [[NSNotificationCenter defaultCenter] postNotificationName:@"DEVICE_UPDATE_NOTIFICATION" object:device];
                   }];
}


+ (void) measureForDevice:(NSString*)deviceID
{
    DLogFuncName();
    NSLog(@"DeviceID = %@",deviceID);
//    
//    NXOAuth2Account * account = [[PSNetAtmoAccount sharedInstance] account];
//    __block PSNetAtmoMeasureDB * measure = nil;
//    
//    [NXOAuth2Request performMethod:@"GET"
//                        onResource:[NSURL URLWithString:NETATMO_URL_DEVICE_MEASSURE]
//                   usingParameters:@{@"access_token" : account.accessToken.accessToken,
//                                     @"device_id" : deviceID,
//                                     @"scale" : @"3hours",
//                                     @"type" : @"Temperature"}
//                       withAccount:account
//               sendProgressHandler:^(unsigned long long bytesSend, unsigned long long bytesTotal)  {  }// e.g., update a progress indicator }
//                   responseHandler:^(NSURLResponse *response, NSData *responseData, NSError *error){
//                       // Process the response
//
//                       DEBUG_REQUEST_REPONSE_Log(@"account.accessToken.accessToken = %@", account.accessToken.accessToken);
//                       DEBUG_REQUEST_REPONSE_Log(@"Responsed = %@", response);
//                       DEBUG_REQUEST_REPONSE_Log(@"Error = %@", error);
//                       DEBUG_REQUEST_REPONSE_Log(@"Data = %@", [NSString stringWithUTF8String:[responseData bytes]]);
//                       
//                       if (!error && [responseData length])
//                       {
//                           measure = [[PSNetAtmoMeasureDB alloc] initWithData:responseData error:nil];
//                       }
//
//                   }];
}


+ (void) measureForDevice:(NSString*)deviceID andModule:(NSString*)moduleID
{
    DLogFuncName();
    NSLog(@"DeviceID = %@",deviceID);
    
//    NXOAuth2Account * account = [[PSNetAtmoAccount sharedInstance] account];
//    __block PSNetAtmoMeasure * measure = nil;
//    
//    [NXOAuth2Request performMethod:@"GET"
//                        onResource:[NSURL URLWithString:NETATMO_URL_DEVICE_MEASSURE]
//                   usingParameters:@{@"access_token" : account.accessToken.accessToken,
//                                     @"device_id" : deviceID,
//                                     @"scale" : @"3hours",
//                                     @"module_id" : moduleID,
//                                     @"type" : @"Temperature"}
//                       withAccount:account
//               sendProgressHandler:^(unsigned long long bytesSend, unsigned long long bytesTotal)  {  }// e.g., update a progress indicator }
//                   responseHandler:^(NSURLResponse *response, NSData *responseData, NSError *error){
//                       // Process the response
//
//                       DEBUG_REQUEST_REPONSE_Log(@"account.accessToken.accessToken = %@", account.accessToken.accessToken);
//                       DEBUG_REQUEST_REPONSE_Log(@"Responsed = %@", response);
//                       DEBUG_REQUEST_REPONSE_Log(@"Error = %@", error);
//                       DEBUG_REQUEST_REPONSE_Log(@"Data = %@", [NSString stringWithUTF8String:[responseData bytes]]);
//                       
//                       if (!error && [responseData length])
//                       {
//                           measure = [[PSNetAtmoMeasureDB alloc] initWithData:responseData error:nil];
//                       }
//                       
//                   }];
}

@end
