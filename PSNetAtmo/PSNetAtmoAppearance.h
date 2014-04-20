//
//  PSNetAtmoAppearance.h
//  PSNetAtmo
//
//  Created by Philip Schneider on 18.01.14.
//  Copyright (c) 2014 phschneider.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PSNetAtmoAppearance : NSObject

+ (PSNetAtmoAppearance*) sharedInstance;

- (void)applyComposerInterfaceApperance;
- (void)applyGlobalInterfaceAppearance;

- (UIImage *)fullScreenImage;
- (UIImage *)infoImage;
- (UIImage *)locateImage;
- (UIImage *)locateImageActive;
- (UIImage *)locateImageInactive;
- (UIImage *)locateImageError;
@end
