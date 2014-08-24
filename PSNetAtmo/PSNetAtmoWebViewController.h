//
//  PSNetAtmoWebViewController.h
//  PSNetAtmo
//
//  Created by Philip Schneider on 05.12.13.
//  Copyright (c) 2013 phschneider.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSNetAtmoViewController.h"

// Wird geöffnet wenn der Auth-Vorgang stattfindet
@interface PSNetAtmoWebViewController : PSNetAtmoViewController <UIWebViewDelegate>

- (id)initWithUrl:(NSURL*)url;

@end
