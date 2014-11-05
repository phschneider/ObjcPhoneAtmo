//
//  PSNetAtmoNavigationController.m
//  PSNetAtmo
//
//  Created by Philip Schneider on 18.01.14.
//  Copyright (c) 2014 phschneider.net. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>
#import "PSAppDelegate.h"
#import "PSNetAtmoDevicesViewController.h"
#import "PSNetAtmoNavigationController.h"
#import "PSNetAtmoProfileViewController.h"
#import "PSNetAtmoWebViewController.h"

@interface PSNetAtmoNavigationController ()

@end

@implementation PSNetAtmoNavigationController


- (void) viewDidLoad
{
    DLogFuncName();
    [super viewDidLoad];
    
//    __typeof (self) __weak weakSelf = self;
//    REMenuItem *homeItem = [[REMenuItem alloc] initWithTitle:@"Home"
//                                                    subtitle:@"Return to Home Screen"
//                                                       image:[UIImage imageNamed:@"Icon_Home"]
//                                            highlightedImage:nil
//                                                      action:^(REMenuItem *item) {
//                                                          [weakSelf setViewControllers:@[APPDELEGATE.devicesViewController] animated:NO];
//                                                      }];
//    
//    REMenuItem *exploreItem = [[REMenuItem alloc] initWithTitle:@"Settings"
//                                                       subtitle:@"Change app settings"
//                                                          image:[UIImage imageNamed:@"Icon_Explore"]
//                                               highlightedImage:nil
//                                                         action:^(REMenuItem *item) {
//                                                             [weakSelf setViewControllers:@[APPDELEGATE.settingsViewController] animated:NO];
//                                                         }];
//    
////    REMenuItem *activityItem = [[REMenuItem alloc] initWithTitle:@"Activity"
////                                                        subtitle:@"Perform 3 additional activities"
////                                                           image:[UIImage imageNamed:@"Icon_Activity"]
////                                                highlightedImage:nil
////                                                          action:^(REMenuItem *item) {
////                                                              NSLog(@"Item: %@", item);
////                                                          }];
//
//
//    REMenuItem *profileItem = [[REMenuItem alloc] initWithTitle:@"Profiles"
//                                                       subtitle:@"Login / logout"
//                                                          image:[UIImage imageNamed:@"Icon_Profile"]
//                                               highlightedImage:nil
//                                                         action:^(REMenuItem *item) {
//                                                             NSLog(@"Item: %@", item);
//                                                             
//                                                             [weakSelf setViewControllers:@[APPDELEGATE.profilesViewController] animated:NO];
//                                                         }];
//
//    REMenuItem *imprintItem = [[REMenuItem alloc] initWithTitle:@"Imprint"
//                                                       subtitle:@""
//                                                          image:[UIImage imageNamed:@"Icon_Profile"]
//                                               highlightedImage:nil
//                                                         action:^(REMenuItem *item) {
//                                                             NSLog(@"Item: %@", item);
//
//                                                         }];
//    
//    self.menu = [[REMenu alloc] initWithItems:@[homeItem, profileItem]];
//    [self.menu showFromNavigationController:self.navigationController];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedAuthUrl:) name:PSNETATMO_RECEIVED_AUTH_URL object:nil];
}


#pragma mark - Menu
//- (void)toggleMenu
//{
//    DLogFuncName();
//    if (self.menu.isOpen)
//    {
//        return [self.menu close];
//    }
//    
//    [self.menu showFromNavigationController:self];
//}


#pragma mark - UI ...
- (NSUInteger)supportedInterfaceOrientations
{
    DLogFuncName();
    return UIInterfaceOrientationMaskPortrait;
}


#pragma mark - OAth
- (void) receivedAuthUrl:(NSNotification *)notification
{
    DLogFuncName();

    if (![NSThread isMainThread])
    {
        [self receivedAuthUrl:notification];
        return;
    }

    [SVProgressHUD dismiss];
    if ([[notification.userInfo allKeys] containsObject:@"url"])
    {
        [self showWebViewForUrl:[notification.userInfo objectForKey:@"url"]];
    }
}


- (void) showWebViewForUrl:(NSURL*)url
{
    DLogFuncName();
    PSNetAtmoWebViewController * webViewController = [[PSNetAtmoWebViewController alloc] initWithUrl:url];
    webViewController.title = NSLocalizedString(@"Authorization",nil);

    PSNetAtmoNavigationController * navController = [[PSNetAtmoNavigationController alloc] initWithRootViewController:webViewController];
    [self presentModalViewControllerInFormSheetSizeWithoutKeyboardDismissBug:navController];
}


- (void)presentModalViewControllerInFormSheetSizeWithoutKeyboardDismissBug:(UIViewController*)viewController
{
    viewController.modalPresentationStyle = UIModalPresentationPageSheet;
    viewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

    [self presentViewController: viewController animated:YES completion:nil];

    viewController.view.superview.autoresizingMask =
            UIViewAutoresizingFlexibleTopMargin |
                    UIViewAutoresizingFlexibleBottomMargin;
    viewController.view.superview.frame = CGRectMake(viewController.view.superview.frame.origin.x,
            viewController.view.superview.frame.origin.y,
            540.0f,
            529.0f);

    //    CGRect bounds = [self.view bounds];
    //    CGPoint centerPoint = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));

    viewController.view.superview.center = self.view.center;
}

@end
