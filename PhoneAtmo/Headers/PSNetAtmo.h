//
//  PSNetAtmo.h
//  PSNetAtmo
//
//  Created by Philip Schneider on 23.11.13.
//  Copyright (c) 2013 phschneider.net. All rights reserved.
//

#ifndef PSNetAtmo_PSNetAtmo_h
#define PSNetAtmo_PSNetAtmo_h


#define CLIENT_ID       @"535ab3011e77596328f2e27b"
#define CLIENT_SECRET   @"VLEkW9KIu1Npnj30q41UZVBwbSwaba9"
#define ACCOUNT_TYPE    @"PhoneAtmo"

#define DEFAULTS_APP_FIRST_START_DATE        @"firstStartDate"

#define DEFAULTS_APP_LAST_VERSION            @"lastVersion"
#define DEFAULTS_APP_LAST_VERSION_DATE       @"lastVersionDate"

#define HTTP_METHOD @"POST"

#define NETATMO_URL                 @"https://api.netatmo.net/"
#define REQUEST_TOKEN               [NSString stringWithFormat:@"%@%@",NETATMO_URL,@"oauth2/token"]
#define AUTH_URL                    [NSString stringWithFormat:@"%@%@",NETATMO_URL,@"oauth2/authorize"]
#define NETATMO_URL_API             [NSString stringWithFormat:@"%@%@",NETATMO_URL,@"api/"]
#define NETATMO_URL_USER            [NSString stringWithFormat:@"%@%@",NETATMO_URL_API,@"getuser"]
#define NETATMO_URL_DEVICE_LIST     [NSString stringWithFormat:@"%@%@",NETATMO_URL_API,@"devicelist"]
#define NETATMO_URL_DEVICE_MEASSURE [NSString stringWithFormat:@"%@%@",NETATMO_URL_API,@"getmeasure"]

#define NETATMO_ENTITY_DEVICE_PLACE     @"PSNetAtmoDevicePlace"
#define NETATMO_ENTITY_DEVICE           @"PSNetAtmoDevice"
#define NETATMO_ENTITY_PRIVATE_DEVICE   @"PSNetAtmoPrivateDevice"
#define NETATMO_ENTITY_PUBLIC_DEVICE    @"PSNetAtmoPublicDevice"
#define NETATMO_ENTITY_USER             @"PSNetAtmoUser"
#define NETATMO_ENTITY_MODULE           @"PSNetAtmoModule"
#define NETATMO_ENTITY_MODULE_MEASURE   @"PSNetAtmoModuleMeasure"
#define NETATMO_ENTITY_MODULE_DATA_TYPE @"PSNetAtmoModuleDataType"

#import <NXOAuth2Client/NXOAuth2.h>

#import "PSNetAtmoNotifications.h"

#import "PSNetAtmoApi.h"

#import "PSNetAtmoApiAccount.h"

#import "PSNetAtmoUser.h"
#import "PSNetAtmoUser+Helper.h"

#import "PSNetAtmoDevice.h"
#import "PSNetAtmoDevice+Helper.h"

#import "PSNetAtmoPublicDevice.h"
#import "PSNetAtmoPublicDevice+Helper.h"

#import "PSNetAtmoPrivateDevice.h"
#import "PSNetAtmoPrivateDevice+Helper.h"

#import "PSNetAtmoModule.h"
#import "PSNetAtmoModule+Helper.h"

#import "PSNetAtmoModuleDataType.h"

#import "PSNetAtmoModuleMeasure.h"
#import "PSNetAtmoModuleMeasure+Helper.h"

#endif
