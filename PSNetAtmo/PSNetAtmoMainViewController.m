//
//  PSNetAtmoMainViewController.m
//  PSNetAtmo
//
//  Created by Philip Schneider on 07.12.13.
//  Copyright (c) 2013 phschneider.net. All rights reserved.
//

#import "PSNetAtmo.h"
#import "PSNetAtmoMainViewController.h"
#import "PSNetAtmoWebViewController.h"
#import "PSNetAtmoDevicesViewController.h"
#import "PSNetAtmoNoAccountView.h"

@interface PSNetAtmoMainViewController ()
@property (nonatomic) PSNetAtmoNoAccountView *noAccountView;
@property (nonatomic) UILabel *noAccountLabel;
@end

// Prüft nur auf Account und zeigt ggf. die WebView an
// Wenn Account zeigt Devices an
@implementation PSNetAtmoMainViewController

- (id) init
{
    DLogFuncName();
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedAuthUrl:) name:PSNETATMO_RECEIVED_AUTH_URL object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accountUpdated:) name:PSNETATMO_ACCOUNT_UPDATE_NOTIFICATION object:nil];
        
        CGRect frame = CGRectZero;
        float width = self.view.bounds.size.width;
        float height = self.view.bounds.size.height;
        if(self.view.bounds.size.height > self.view.bounds.size.width)
        {
            width = self.view.bounds.size.height;
            height = self.view.bounds.size.width;
        }
        
        
        self.noAccountView = [[PSNetAtmoNoAccountView alloc] initWithFrame:CGRectMake(ceil((width-200)/2),ceil((height-120)/2),200, 120)];
        [self.view addSubview:self.noAccountView];
        
        frame = CGRectMake(0, ceil((height)/2), width, ceil(height/2));
        self.noAccountLabel = [[UILabel alloc] initWithFrame:frame];
        self.noAccountLabel.textAlignment = UITextAlignmentCenter;
        self.noAccountLabel.numberOfLines = 0;
        self.noAccountLabel.text = @"No account, click here to authorize.";
        self.noAccountLabel.textColor = [UIColor whiteColor];
        
        [self.view addSubview:self.noAccountLabel];
    }
    return self;
}


#pragma mark
- (void) viewDidAppear:(BOOL)animated
{
    DLogFuncName();
    [super viewDidAppear:animated];
    
    if (![[PSNetAtmoAccount sharedInstance] currentAccountIsValid])
    {
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer:)];
        [self.view addGestureRecognizer: tapRecognizer];
        
        [self requestAccount];
    }
    else
    {
        [self hideNoAccount];
        [self showDevices];
    }
}


#pragma mark - AuthUrl
- (void) receivedAuthUrl:(NSNotification*) note
{
    DLogFuncName();
    if (![NSThread isMainThread])
    {
        [self receivedAuthUrl:note];
        return;
    }
    
    [self showWebViewForUrl:[note.userInfo objectForKey:@"url"]];
}


- (void) showWebViewForUrl:(NSURL*)url
{
    DLogFuncName();
    PSNetAtmoWebViewController * webViewController = [[PSNetAtmoWebViewController alloc] initWithUrl:url];
    webViewController.title = NSLocalizedString(@"Authorization",nil);

    UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController:webViewController];
    [self presentModalViewControllerInFormSheetSizeWithoutKeyboardDismissBug:navController];
}


#pragma mark - Account
- (void) accountUpdated:(NSNotification*)note
{
    DLogFuncName();
    [self showDevices];
}


- (void) showDevices
{
    DLogFuncName();
    PSNetAtmoDevicesViewController * devicesViewController = [[PSNetAtmoDevicesViewController alloc] init];
    [self.navigationController pushViewController:devicesViewController animated:YES];
}


#pragma mark - GestureRecognizer
- (void) showNoAccount
{
    DLogFuncName();
    
    self.noAccountLabel.hidden = NO;
    self.noAccountView.hidden = NO;
}


- (void) hideNoAccount
{
    DLogFuncName();

    self.noAccountLabel.hidden = YES;
    self.noAccountView.hidden = YES;
}

- (void) tapGestureRecognizer:(UIGestureRecognizer*)gestureRecognizer
{
    DLogFuncName();
    [self requestAccount];
}


- (void) requestAccount
{
    DLogFuncName();
    //        [[PSNetAtmoAccount sharedInstance] requestAccount];
#warning todo - alertView / Modale View einbauen
    [[PSNetAtmoAccount sharedInstance] requestAccountWithPreparedAuthorizationURLHandler];
}

@end
