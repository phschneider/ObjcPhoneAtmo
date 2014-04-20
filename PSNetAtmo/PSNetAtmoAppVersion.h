//
//  PSNetAtmoAppVersion.h
//  PSNetAtmo
//
//  Created by Philip Schneider on 14.12.13.
//  Copyright (c) 2013 phschneider.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSNetAtmoAppVersion : NSObject

+ (PSNetAtmoAppVersion *)sharedInstance;

- (NSString*)currentAppVersion;
- (NSString*)lastAppVersion;

@end
