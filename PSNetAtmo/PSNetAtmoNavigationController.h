//
//  PSNetAtmoNavigationController.h
//  PSNetAtmo
//
//  Created by Philip Schneider on 18.01.14.
//  Copyright (c) 2014 phschneider.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REMenu.h";

@interface PSNetAtmoNavigationController : UINavigationController

@property (nonatomic) REMenu *menu;
- (void)toggleMenu;

@end

