//
//  PSNetAtmoAccountWithLogin.h
//  PSNetAtmo
//
//  Created by Philip Schneider on 02.05.14.
//  Copyright (c) 2014 phschneider.net. All rights reserved.
//

#import "PSNetAtmoApiAccount.h"

@interface PSNetAtmoAccountWithLogin : PSNetAtmoApiAccount

- (void) requestAccountWithUser:(NSString*)user andPass:(NSString*)pass;

@end
