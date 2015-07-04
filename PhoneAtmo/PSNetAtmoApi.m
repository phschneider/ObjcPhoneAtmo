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
#import "PSNetAtmoApiAccount.h"
#import "PSNetAtmoAccountWithAuthHandler.h"
#import "PSNetAtmoActivity.h"
#import "SVProgressHUD/SVProgressHUD.h"
#import <MapKit/MapKit.h>

@implementation PSNetAtmoApi

#pragma mark - API
// USERID ist der erste deil des oAuthToken (AccessToken, RefreshToken...)
+ (void) user
{
    // wann wird der benutzer abgefragt!?
    // beim app start!? -> eigentlich nur wenn login angezeigt wurde, ansonsten ändert sich nichts!?
    // DOCH - App kann übers backend jederzeit änderungen erfahren
    
    DLogFuncName();
    DEBUG_API_LogName();
    
    NXOAuth2Account * account = [[PSNetAtmoApiAccount sharedInstance] account];

    if (account)
//    if ( [[PSNetAtmoApiAccount sharedInstance] accountIsValid:account])
    {
        [[PSNetAtmoActivity sharedInstance] show];
        [NXOAuth2Request performMethod:HTTP_METHOD
                            onResource:[NSURL URLWithString:NETATMO_URL_USER]
                       usingParameters:@{@"access_token" : account.accessToken.accessToken}
                           withAccount:nil
                   sendProgressHandler:^(unsigned long long bytesSend, unsigned long long bytesTotal)  {  }// e.g., update a progress indicator }
                       responseHandler:^(NSURLResponse *response, NSData *responseData, NSError *error){
                       // Process the response
                       
                       DEBUG_REQUEST_REPONSE_Log(@"account.accessToken.accessToken = %@", account.accessToken.refreshToken);
                       DEBUG_REQUEST_REPONSE_Log(@"Responsed = %@", response);
                       DEBUG_REQUEST_REPONSE_Log(@"Error = %@", error);
                       DEBUG_REQUEST_REPONSE_Log(@"Data = %@", [NSString stringWithUTF8String:[responseData bytes]]);
                       
                           NSError *localError = nil;
                           NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&localError];
                           
                           if (error)
                           {
                               if (parsedObject && [parsedObject objectForKey:@"error"] && [[parsedObject objectForKey:@"error"] objectForKey:@"message"])
                               {
                                   [SVProgressHUD showErrorWithStatus:[[parsedObject objectForKey:@"error"] objectForKey:@"message"]];
                               }
                               else
                               {
                                   [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                               }
                           }
                           else
                           {
//                       if (!error && [responseData length])
//                       {
                           
                           DEBUG_REQUEST_REPONSE_Log(@"ParsedObject = %@", parsedObject);

                           [PSNetAtmoUser updateUserFromJsonDict:parsedObject inContext:APPDELEGATE.managedObjectContext withAccount:account];
                           [PSNetAtmoUser setCurrentUserFromJsonDict:parsedObject inContext:APPDELEGATE.managedObjectContext withAccount:account];
//                       }

                       
                       [PSNetAtmoApi devices];
                           }
                           
                           [[PSNetAtmoActivity sharedInstance] hide];
                   }];
    }
    else
    {
        [[PSNetAtmoApiAccount sharedInstance] deleteAccount];
    }
}


#pragma mark - API
+ (void) devices
{
    DLogFuncName();
    DEBUG_API_LogName();
    
    NXOAuth2Account * account = [[PSNetAtmoApiAccount sharedInstance] account];
    NSAssert(account,@"no account given");
    
    if (account)
//    if ( [[PSNetAtmoApiAccount sharedInstance] accountIsValid:account])
    {
        [[PSNetAtmoActivity sharedInstance] show];
        [NXOAuth2Request performMethod:HTTP_METHOD
                            onResource:[NSURL URLWithString:NETATMO_URL_DEVICE_LIST]
                       usingParameters:@{@"access_token" : account.accessToken.accessToken}
                           withAccount:nil
                   sendProgressHandler:^(unsigned long long bytesSend, unsigned long long bytesTotal)  {  }// e.g., update a progress indicator }
                       responseHandler:^(NSURLResponse *response, NSData *responseData, NSError *error){
                           // Process the response
                           
                           DEBUG_REQUEST_REPONSE_Log(@"account.accessToken.accessToken = %@", account.accessToken.accessToken);
                           DEBUG_REQUEST_REPONSE_Log(@"Responsed = %@", response);
                           DEBUG_REQUEST_REPONSE_Log(@"Error = %@", error);
                           DEBUG_REQUEST_REPONSE_Log(@"Data = %@", [NSString stringWithUTF8String:[responseData bytes]]);
                           
                           if (error)
                           {
                               [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                           }
                           else
                           {
                               [PSNetAtmoDevice updateDevicesWithData:responseData inContext:APPDELEGATE.managedObjectContext];

                           }
                           
                          [[PSNetAtmoActivity sharedInstance] hide];
    //
    //                       PSNetAtmoDeviceDB * device = [[PSNetAtmoDeviceDB alloc] initWithData:responseData error:nil];
    ////
    //                       NSLog(@"Schlafzimmer = %@", [device lastDataStoreForModule:@"03:00:00:00:3d:2a"]);
    //                       NSLog(@"Balkon = %@", [device lastDataStoreForModule:@"02:00:00:00:4f:30"]);
    //                       NSLog(@"Badezimmer = %@", [device lastDataStoreForModule:@"03:00:00:00:43:56"]);
    //                       NSLog(@"Wohnzimmer = %@", [device lastDataStoreForModule:@"03:00:00:00:0 :0 "]);
                           
    //                       [[NSNotificationCenter defaultCenter] postNotificationName:@"DEVICE_UPDATE_NOTIFICATION" object:device];
                       }];
        
#warning todo - meassureForDevice ...
    }
    else
    {
        [[PSNetAtmoApiAccount sharedInstance] deleteAccount];
    }
}


+ (void) measureForDevice:(NSString*)deviceID
{
    DLogFuncName();
    DEBUG_API_LogName();
    
    DEBUG_API_Log(@"DeviceID = %@",deviceID);

    NXOAuth2Account * account = [[PSNetAtmoApiAccount sharedInstance] account];
    NSAssert(account,@"no account given");
    
    if (account)
//    if ( [[PSNetAtmoApiAccount sharedInstance] accountIsValid:account])
    {

        [[PSNetAtmoActivity sharedInstance] show];
//    __block PSNetAtmoMeasureDB * measure = nil;
//    
////    [NXOAuth2Request performMethod:HTTP_METHOD
////                        onResource:[NSURL URLWithString:NETATMO_URL_DEVICE_MEASSURE]
////                   usingParameters:@{@"access_token" : account.accessToken.accessToken,
////                                     @"device_id" : deviceID,
////                                     @"scale" : @"3hours",
////                                     @"type" : @"Temperature"}
////                       withAccount:account
////               sendProgressHandler:^(unsigned long long bytesSend, unsigned long long bytesTotal)  {  }// e.g., update a progress indicator }
////                   responseHandler:^(NSURLResponse *response, NSData *responseData, NSError *error){
////                       // Process the response
////
//                        [[PSNetAtmoActivity sharedInstance] hide];
////                       DEBUG_REQUEST_REPONSE_Log(@"account.accessToken.accessToken = %@", account.accessToken.accessToken);
////                       DEBUG_REQUEST_REPONSE_Log(@"Responsed = %@", response);
////                       DEBUG_REQUEST_REPONSE_Log(@"Error = %@", error);
////                       DEBUG_REQUEST_REPONSE_Log(@"Data = %@", [NSString stringWithUTF8String:[responseData bytes]]);
////                       
////                       if (!error && [responseData length])
////                       {
////                           measure = [[PSNetAtmoMeasureDB alloc] initWithData:responseData error:nil];
////                       }
////
////                   }];
    }
    else
    {
        [[PSNetAtmoApiAccount sharedInstance] deleteAccount];
    }
}


+ (void) measureForDevice:(PSNetAtmoDevice*)device andModule:(PSNetAtmoModule*)module
{
    DLogFuncName();
    DEBUG_API_LogName();
    
    NXOAuth2Account * account = [[PSNetAtmoApiAccount sharedInstance] account];
    NSAssert(account,@"no account given");
    NSAssert(device.deviceID,@"no device_id given");
    NSAssert(module.moduleID,@"no module_id given");
    
    //    __block PSNetAtmoMeasure * measure = nil;
    if (account)
//    if ( [[PSNetAtmoApiAccount sharedInstance] accountIsValid:account])
    {
        [[PSNetAtmoActivity sharedInstance] show];
        [NXOAuth2Request performMethod:HTTP_METHOD
                            onResource:[NSURL URLWithString:NETATMO_URL_DEVICE_MEASSURE]
                       usingParameters:@{@"access_token" : account.accessToken.accessToken,
                                         @"device_id" : device.deviceID,
                                         @"scale" : @"max",
                                         @"module_id" : module.moduleID,
                                         @"type" : @"Temperature"}
                           withAccount:nil
                   sendProgressHandler:^(unsigned long long bytesSend, unsigned long long bytesTotal)  {  }// e.g., update a progress indicator }
                       responseHandler:^(NSURLResponse *response, NSData *responseData, NSError *error){
                           // Process the response
                           
                           DEBUG_REQUEST_REPONSE_Log(@"account.accessToken.accessToken = %@", account.accessToken.accessToken);
                           DEBUG_REQUEST_REPONSE_Log(@"Responsed = %@", response);
                           DEBUG_REQUEST_REPONSE_Log(@"Error = %@", error);
                           DEBUG_REQUEST_REPONSE_Log(@"Data = %@", [NSString stringWithUTF8String:[responseData bytes]]);
                           
                           if (error)
                           {
                               [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                           }
                           else
                           {
                               
                               NSError *localError = nil;
                               NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&localError];
                               DEBUG_REQUEST_REPONSE_Log(@"ParsedObject = %@", parsedObject);
                               
                               // [[parsedObject objectForKey:@"body"] objectAtIndex:0]
                               // [[[parsedObject objectForKey:@"body"] objectAtIndex:0] objectForKey:@"step_time"]
                               // [[[parsedObject objectForKey:@"body"] objectAtIndex:0] objectForKey:@"beg_time"]
                               
                               NSDictionary *body = [[parsedObject objectForKey:@"body"] objectAtIndex:0];
                               NSTimeInterval beginTime = [[body objectForKey:@"beg_time"] floatValue];
                               NSTimeInterval stepTime = [[body objectForKey:@"step_time"] floatValue];
                               NSTimeInterval valueTime = beginTime;
                               NSArray *values = [[[parsedObject objectForKey:@"body"] objectAtIndex:0] objectForKey:@"value"];
                               
                               for (NSArray *value in values)
                               {
                                   DEBUG_API_Log(@"Time = %f (%@) Value = %@",valueTime, [NSDate dateWithTimeIntervalSince1970:valueTime], [value objectAtIndex:0]);
                                   valueTime += stepTime;
                               }
                           }
                           [[PSNetAtmoActivity sharedInstance] hide];
                           //                       if (!error && [responseData length])
                           //                       {
                           //                           measure = [[PSNetAtmoMeasureDB alloc] initWithData:responseData error:nil];
                           //                       }
                           
                       }];
    }
    else
    {
        [[PSNetAtmoApiAccount sharedInstance] deleteAccount];
    }
}



+ (void) lastMeasureForDevice:(PSNetAtmoDevice*)device andModule:(PSNetAtmoModule*)module
{
    DLogFuncName();
    DEBUG_API_LogName();
    
    NXOAuth2Account * account = [[PSNetAtmoApiAccount sharedInstance] account];
    if (!account)
    {
        NSLog(@"No Account for new meassures ... ");
        [[PSNetAtmoAccountWithAuthHandler sharedInstance] requestAccountWithPreparedAuthorizationURLHandler];
    }

    
    else // if ( [[PSNetAtmoApiAccount sharedInstance] accountIsValid:account])
    {
        NSAssert(device.deviceID,@"no device_id given");
        NSAssert(module.moduleID,@"no module_id given");

        
//    __block PSNetAtmoMeasure * measure = nil;
        [[PSNetAtmoActivity sharedInstance] show];
    [NXOAuth2Request performMethod:HTTP_METHOD
                        onResource:[NSURL URLWithString:NETATMO_URL_DEVICE_MEASSURE]
                   usingParameters:@{@"access_token" : account.accessToken.accessToken,
                                     @"device_id" : device.deviceID,
                                     @"scale" : @"max",
                                     @"module_id" : module.moduleID,
                                     @"date_end": @"last",
                                     @"type" : [module typeStringForLastMeasureRequest] }
                       withAccount:nil
               sendProgressHandler:^(unsigned long long bytesSend, unsigned long long bytesTotal)  {  }// e.g., update a progress indicator }
                   responseHandler:^(NSURLResponse *response, NSData *responseData, NSError *error){
                       // Process the response

                       
                       DEBUG_REQUEST_REPONSE_Log(@"account.accessToken.accessToken = %@", account.accessToken.accessToken);
                       DEBUG_REQUEST_REPONSE_Log(@"Responsed = %@", response);
                       DEBUG_REQUEST_REPONSE_Log(@"Error = %@", error);
                       
                       if (!error && [responseData length])
                       {
                           [module updateMeasuresWithData:responseData];
                       }

#warning todo ---
//                       Responsed = <NSHTTPURLResponse: 0xc1de140> { URL: http://api.netatmo.net/api/getmeasure?scale=max&type=Pressure%2CCo2%2CHumidity%2CTemperature%2CNoise&device_id=70%3Aee%3A50%3A01%3Ae3%3Af2&access_token=5165a31f187759e7a1000035%7C9dba18debb54d5b5f6ae4754755e9e3b&module_id=70%3Aee%3A50%3A01%3Ae3%3Af2&date_end=last } { status code: 403, headers {
//                           "Cache-Control" = "no-cache, must-revalidate";
//                           Connection = "keep-alive";
//                           "Content-Length" = 53;
//                           "Content-Type" = "application/json; charset=utf-8";
//                           Date = "Fri, 02 May 2014 21:40:22 GMT";
//                           Expires = 0;
//                           Server = "nginx/1.6.0";
//                           "X-Powered-By" = "NetatmoAPI1.0.0";
//                       } }
                       
                       
                       [[PSNetAtmoActivity sharedInstance] hide];
                   }];
    }
//    else
//    {
//        [[PSNetAtmoApiAccount sharedInstance] deleteAccount];
//    }
}


@end
