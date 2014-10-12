//
//  PSNetAtmoModuleView.h
//  PSNetAtmo
//
//  Created by Philip Schneider on 23.11.13.
//  Copyright (c) 2013 phschneider.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSNetAtmoModuleView : UIView

- (id)initWithModule:(PSNetAtmoModule *)module andFrame:(CGRect)frame;

- (void) setValuesFromDict:(NSDictionary*)dict;
- (void) unfold;
- (void) unfoldAnimated:(BOOL)animated;

@end
