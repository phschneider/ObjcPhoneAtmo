//
//  PSNetAtmoWebViewController.m
//  PSNetAtmo
//
//  Created by Philip Schneider on 05.12.13.
//  Copyright (c) 2013 phschneider.net. All rights reserved.
//

#import "PSNetAtmo.h"
#import "PSNetAtmoWebViewController.h"

@interface PSNetAtmoWebViewController ()
@property (nonatomic) UIWebView * webView;
@property (nonatomic) NSURL * url;
@end

@implementation PSNetAtmoWebViewController

- (id)initWithUrl:(NSURL*)url
{
    DLogFuncName();
    self = [super init];
    if (self)
    {
        self.url = url;
        
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        [[NSURLCache sharedURLCache] setDiskCapacity:0];
        [[NSURLCache sharedURLCache] setMemoryCapacity:0];
        
        NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:0 diskCapacity:0 diskPath:nil];
        [NSURLCache setSharedURLCache:sharedCache];
        sharedCache = nil;
        
        // Remove all credential on release, but memory used doesn't move!
        NSURLCredentialStorage *credentialsStorage = [NSURLCredentialStorage sharedCredentialStorage];
        NSDictionary *allCredentials = [credentialsStorage allCredentials];
        for (NSURLProtectionSpace *protectionSpace in allCredentials) {
            NSDictionary *credentials = [credentialsStorage credentialsForProtectionSpace:protectionSpace];
            for (NSString *credentialKey in credentials) {
                [credentialsStorage removeCredential:[credentials objectForKey:credentialKey] forProtectionSpace:protectionSpace];
            }
        }
    }
    return self;
}


- (void) viewDidAppear:(BOOL)animated
{
    DLogFuncName();
    [super viewDidAppear:animated];
    if (!self.webView)
    {
        self.view.backgroundColor = [UIColor whiteColor];
        
        self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.webView.delegate = self;
        [self.view addSubview:self.webView];
    }
    
    if (self.url)
    {
//        NSURLRequest * request = [NSURLRequest requestWithURL:self.url];
        NSMutableURLRequest * request =[NSMutableURLRequest requestWithURL:self.url];
        [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        
        [self.webView loadRequest:request];
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"cancel",nil) style:UIBarButtonItemStyleDone target:self action:@selector(cancelButtonTouched)];
}


- (void) viewDidDisappear:(BOOL)animated
{
    DLogFuncName();
    [super viewDidDisappear:animated];
    
    [self.webView loadHTMLString:@"" baseURL:[NSURL URLWithString:@""]];
}


- (void) cancelButtonTouched
{
    DLogFuncName();
    
    // löst implizit einen didFailLoadWithError Aus ...
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self.webView stopLoading];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - WebViewDelegate
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    DLogFuncName();
    NSLog(@"Error = %@", error);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    DLogFuncName();
    
#warning todo // <NSMutableURLRequest: 0xc4d1880> { URL: http://phoneatmoapp.com/?error=access_denied }
#warning todo // <NSMutableURLRequest: 0xe05d3d0> { URL: http://phoneatmoapp.com/?code=43de28d6d40fd4edc786edbc24167c9b }
    
//    NSLog(@"Request = %@ (%d)",[request.URL absoluteString],navigationType);
//    if ([[request.URL absoluteString] hasPrefix:@"http://api.netatmo.net/oauth2/dashatmo?code="])
//    {
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }
//    
//    return YES;

    if ([[request.URL absoluteString] hasPrefix:@"http://phoneatmoapp.com"])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:PSNETATMO_RECEIVED_REDIRECT_URL object:nil userInfo:@{@"url" : request.URL}];
        [self cancelButtonTouched];
        return NO;
    }
    return YES;
    
//    if (navigationType == 1 || navigationType == 5)
//    {
//        return YES;
//    }
//    return NO;
}


- (NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)script
{
    DLogFuncName();
    NSLog(@"Script = %@", script);
    return script;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    DLogFuncName();
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    DLogFuncName();
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}


@end
