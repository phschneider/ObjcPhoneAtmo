//
//  NSDictionary+Validator.h
//  PSNetAtmo
//
//  Created by Philip Schneider on 27.07.14.
//  Copyright (c) 2014 phschneider.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Validator)

- (NSString*)validateStringForKey:(NSString*)key;
- (NSNumber*)validateNumberForKey:(NSString *)key;
- (BOOL) hasKey:(NSString*)key;

@end
