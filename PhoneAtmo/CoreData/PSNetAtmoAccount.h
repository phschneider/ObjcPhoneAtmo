//
//  PSNetAtmoAccount.h
//  PSNetAtmo
//
//  Created by Philip Schneider on 02.05.14.
//  Copyright (c) 2014 phschneider.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PSNetAtmoAccount : NSManagedObject

@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * password;

@end
