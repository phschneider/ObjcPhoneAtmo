//
//  PSNetAtmo.h
//  PSNetAtmo
//
//  Created by Philip Schneider on 23.11.13.
//  Copyright (c) 2013 phschneider.net. All rights reserved.
//

#ifndef PSNetAtmo_PSNetAtmo_h
#define PSNetAtmo_PSNetAtmo_h


#define CLIENT_ID       @"528755651b77593b2a8b4573"
#define CLIENT_SECRET   @"tDraccNdc0XCum5QCFhoFPDugKW8"
#define REQUEST_TOKEN   @"http://api.netatmo.net/oauth2/token"
#define AUTH_URL        @"http://api.netatmo.net/oauth2/authorize"
#define ACCOUNT_TYPE    @"GeekTool"

#define USER_NAME       @"info@philip-schneider.com"
#define USER_PASS       @"7qUQVRLdPffg6p"

#define DEFAULTS_APP_FIRST_START_DATE        @"firstStartDate"

#define DEFAULTS_APP_LAST_VERSION            @"lastVersion"
#define DEFAULTS_APP_LAST_VERSION_DATE       @"lastVersionDate"

#define NETATMO_URL_USER            @"http://api.netatmo.net/api/getuser"
#define NETATMO_URL_DEVICE_LIST     @"http://api.netatmo.net/api/devicelist"
#define NETATMO_URL_DEVICE_MEASSURE @"http://api.netatmo.net/api/getmeasure"

#define NETATMO_ENTITY_DEVICE_PLACE     @"PSNetAtmoDevicePlace"
#define NETATMO_ENTITY_DEVICE           @"PSNetAtmoDevice"
#define NETATMO_ENTITY_PRIVATE_DEVICE   @"PSNetAtmoPrivateDevice"
#define NETATMO_ENTITY_PUBLIC_DEVICE    @"PSNetAtmoPublicDevice"
#define NETATMO_ENTITY_MODULE           @"PSNetAtmoModule"
#define NETATMO_ENTITY_MODULE_MEASURE   @"PSNetAtmoModuleMeasure"
#define NETATMO_ENTITY_MODULE_DATA_TYPE @"PSNetAtmoModuleDataType"

#import <NXOAuth2Client/NXOAuth2.h>

#import "PSNetAtmoApi.h"

#import "PSNetAtmoAccount.h"

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
