//
//  PSNetAtmoDeviceViewController.h
//  PSNetAtmo
//
//  Created by Philip Schneider on 21.04.14.
//  Copyright (c) 2014 phschneider.net. All rights reserved.
//

#import "PSNetAtmoTableViewController.h"

@interface PSNetAtmoDeviceViewController : PSNetAtmoTableViewController <NSFetchedResultsControllerDelegate>

- (id) initWithDevice:(PSNetAtmoDevice*)device;

@end
