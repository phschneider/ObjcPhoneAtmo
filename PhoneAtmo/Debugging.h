//
//  Header.h
//  PSNetAtmo
//
//  Created by Philip Schneider on 02.05.14.
//  Copyright (c) 2014 phschneider.net. All rights reserved.
//

#ifndef PSNetAtmo_Header_h
#define PSNetAtmo_Header_h


#define THREAD_LOG                      (([NSThread isMainThread]) ? @"" : @"[THREAD NOT MAINTHREAD]")

//#ifdef DEBUG
//    #define DLogFuncName()                  NSLog((@"[FUNCNAME] %@ %s [Line %d] "), THREAD_LOG, __PRETTY_FUNCTION__, __LINE__);
//    #define DLog(fmt, ...)                  NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__,  ##__VA_ARGS__);
//#else
    #define DLogFuncName()
    #define DLog(fmt, ...)
//#endif

#ifdef DEBUG_REQUEST_REPONSE
    #define DEBUG_REQUEST_REPONSE_Log(fmt, ...)         NSLog((@"[REQUEST RESPONSE] %@ %s [Line %d] " fmt), THREAD_LOG, __PRETTY_FUNCTION__, __LINE__,  ##__VA_ARGS__);
    #define DEBUG_REQUEST_REPONSE_LogName()             NSLog((@"[REQUEST RESPONSE] %@ %s [Line %d] "), THREAD_LOG, __PRETTY_FUNCTION__, __LINE__);
#else
    #define DEBUG_REQUEST_REPONSE_Log(fmt, ...)
    #define DEBUG_REQUEST_REPONSE_LogName()
#endif


#ifdef DEBUG_ACCOUNT
    #define DEBUG_ACCOUNT_Log(fmt, ...)         NSLog((@"[ACCOUNT] %@ %s [Line %d] " fmt), THREAD_LOG, __PRETTY_FUNCTION__, __LINE__,  ##__VA_ARGS__);
    #define DEBUG_ACCOUNT_LogName()             NSLog((@"[ACCOUNT] %@ %s [Line %d] "), THREAD_LOG, __PRETTY_FUNCTION__, __LINE__);
#else
    #define DEBUG_ACCOUNT_Log(fmt, ...)
    #define DEBUG_ACCOUNT_LogName()
#endif


#ifdef DEBUG_DEVICES
    #define DEBUG_DEVICES_Log(fmt, ...)         NSLog((@"[DEVICES] %@ %s [Line %d] " fmt), THREAD_LOG, __PRETTY_FUNCTION__, __LINE__,  ##__VA_ARGS__);
    #define DEBUG_DEVICES_LogName()             NSLog((@"[DEVICES] %@ %s [Line %d] "), THREAD_LOG, __PRETTY_FUNCTION__, __LINE__);
#else
    #define DEBUG_DEVICES_Log(fmt, ...)
    #define DEBUG_DEVICES_LogName()
#endif


#ifdef DEBUG_ACTIVITY
    #define DEBUG_ACTIVITY_Log(fmt, ...)         NSLog((@"[ACTIVITY] %@ %s [Line %d] " fmt), THREAD_LOG, __PRETTY_FUNCTION__, __LINE__,  ##__VA_ARGS__);
    #define DEBUG_ACTIVITY_LogName()             NSLog((@"[ACTIVITY] %@ %s [Line %d] "), THREAD_LOG, __PRETTY_FUNCTION__, __LINE__);
#else
    #define DEBUG_ACTIVITY_Log(fmt, ...)
    #define DEBUG_ACTIVITY_LogName()
#endif


#ifdef DEBUG_API
    #define DEBUG_API_Log(fmt, ...)         NSLog((@"[API] %@ %s [Line %d] " fmt), THREAD_LOG, __PRETTY_FUNCTION__, __LINE__,  ##__VA_ARGS__);
    #define DEBUG_API_LogName()             NSLog((@"[API] %@ %s [Line %d] "), THREAD_LOG, __PRETTY_FUNCTION__, __LINE__);
#else
    #define DEBUG_API_Log(fmt, ...)
    #define DEBUG_API_LogName()
#endif


#ifdef DEBUG_APPCYCLE
    #define DEBUG_APPCYCLE_Log(fmt, ...)         NSLog((@"[APPCYCLE] %@ %s [Line %d] " fmt), THREAD_LOG, __PRETTY_FUNCTION__, __LINE__,  ##__VA_ARGS__);
    #define DEBUG_APPCYCLE_LogName()             NSLog((@"[APPCYCLE] %@ %s [Line %d] "), THREAD_LOG, __PRETTY_FUNCTION__, __LINE__);
#else
    #define DEBUG_APPCYCLE_Log(fmt, ...)
    #define DEBUG_APPCYCLE_LogName()
#endif



#ifdef DEBUG_CORE_DATA
    #define DEBUG_CORE_DATA_Log(fmt, ...)         NSLog((@"[CORE-DATA] %@ %s [Line %d] " fmt), THREAD_LOG, __PRETTY_FUNCTION__, __LINE__,  ##__VA_ARGS__);
    #define DEBUG_CORE_DATA_LogName()             NSLog((@"[CORE-DATA] %@ %s [Line %d] "), THREAD_LOG, __PRETTY_FUNCTION__, __LINE__);
#else
    #define DEBUG_CORE_DATA_Log(fmt, ...)
    #define DEBUG_CORE_DATA_LogName()
#endif

#endif
