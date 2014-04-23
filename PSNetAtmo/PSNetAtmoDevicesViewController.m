//
//  PSNetAtmoDevicesViewController.m
//  PSNetAtmo
//
//  Created by Philip Schneider on 07.12.13.
//  Copyright (c) 2013 phschneider.net. All rights reserved.
//

#import "PSNetAtmo.h"
#import "PSNetAtmoApi.h"
#import "PSAppDelegate.h"
#import "PSNetAtmoDevicesViewController.h"
#import "PSNetAtmoDeviceViewController.h"
#import "PSNetAtmoNoAccountView.h"
#import "PSNetAtmoWebViewController.h"

@interface PSNetAtmoDevicesViewController ()
@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIPageControl *pageControl;
@property (nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) PSNetAtmoNoAccountView *noAccountView;
@property (nonatomic) UILabel *noAccountLabel;
@end

@implementation PSNetAtmoDevicesViewController

- (id) init
{
    DLogFuncName();
    self = [super init];
    if (self)
    {
//        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
//            self.edgesForExtendedLayout = UIRectEdgeNone;

        self.automaticallyAdjustsScrollViewInsets = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedAuthUrl:) name:PSNETATMO_RECEIVED_AUTH_URL object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accountUpdated:) name:PSNETATMO_ACCOUNT_UPDATE_NOTIFICATION object:nil];
        
        CGRect scrollViewFrame = self.view.bounds;
//        scrollViewFrame.size.height -= 64;
        self.scrollView = [[UIScrollView alloc] initWithFrame:scrollViewFrame];
        self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.scrollView.delegate = self;
        self.scrollView.backgroundColor = [UIColor whiteColor];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.directionalLockEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:self.scrollView];
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-50,self.view.bounds.size.width, 50)];
        self.pageControl.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        self.pageControl.backgroundColor = [UIColor clearColor];
        self.pageControl.hidesForSinglePage = YES;
        self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:self.pageControl];
        
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


- (void) viewDidAppear:(BOOL)animated
{
    DLogFuncName();
    [super viewDidAppear:animated];
    
//    if (![[PSNetAtmoAccount sharedInstance] currentAccountIsValid])
    if ( ![[PSNetAtmoAccount sharedInstance] hasAccount] )
    {
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer:)];
        [self.view addGestureRecognizer: tapRecognizer];
        
        [self requestAccount];
    }
    else
    {
        [self hideNoAccount];
        [self controllerDidChangeContent:self.fetchedResultsController];
        [PSNetAtmoApi devices];
    }
    
    
//    [self.scrollView setContentInset:UIEdgeInsetsMake(64,0,0,0)];
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
#warning todo NXOAuth2AccountStore storeAccountsInDefaultKeychain
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

- (void) changePage:(id)sender
{
    DLogFuncName();
    UIPageControl *pageControl = sender;
    int page = pageControl.currentPage;
    
    int lastPage = ((int)self.scrollView.contentOffset.x) / 320;
    // sicherheitshalber zurücksetzen auf lastpage damit beim der didScroll kein murx geschieht
    // wenn nicht zurückgesetzt hat der pagecontroll schon beim scrollen den neuen wert
    // da dieser neue wert nicht der aktuellen scrollposition entspricht, wird dieser wert wieder angepasst (zurückgesetzt)
    // wenn in der finalen scrollposition angekommen wird der wert dann wieder aktualisiert => auf neue position gesetzt
    // => pageControl flackert
    pageControl.currentPage = lastPage;
    
    DLog(@"LastPage = %d", lastPage);
    DLog(@"Page = %d", page);
    
    dispatch_async(dispatch_get_main_queue(),^{
        CGRect frame = CGRectMake(page * self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
        [self.scrollView scrollRectToVisible:frame animated:YES];
    });
}


#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    DLogFuncName();
    DLog(@"Content Offset = %@", NSStringFromCGPoint(scrollView.contentOffset));
    
    float width = self.view.bounds.size.width;
    
    // Ab einem gewissen schwellenwert, ist newpage != oldpage, die view wird aktualisiert
    int newPage = floor((scrollView.contentOffset.x - width / 2) / width) + 1;
    int oldPage = self.pageControl.currentPage;
    
    DLog(@"NewPage = %d",newPage);
    DLog(@"OldPage = %d",oldPage);
    
    BOOL shouldUpdate = (newPage != oldPage);
    if (shouldUpdate)
    {
        [self.pageControl updateCurrentPageDisplay];
        if (self.pageControl.currentPage != newPage)
        {
            self.pageControl.currentPage = newPage;
        }
        [self updateTitle];
    }
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    DLogFuncName();
}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    DLogFuncName();
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    DLogFuncName();
}


- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    DLogFuncName();
    return YES;
}


- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    DLogFuncName();
}


- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    DLogFuncName();
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    DLogFuncName();
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    DLogFuncName();
    return nil;
}


- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    DLogFuncName();
}


- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    DLogFuncName();
}


- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    DLogFuncName();
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    DLogFuncName();
}


#pragma mark - FetchedResultsController
- (NSFetchedResultsController *)fetchedResultsController
{
    DLogFuncName();
    //    if (_fetchedResultsController)
    //    {
    //        return _fetchedResultsController;
    //    }
    
    NSFetchedResultsController *fetchedResultsController = nil;
    
    // using UIManagedDocument for Core Data storage
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NETATMO_ENTITY_DEVICE];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"deviceID" ascending:YES];
    [request setSortDescriptors:@[sortDescriptor]];
    fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:APPDELEGATE.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    [fetchedResultsController setDelegate:self];
    
    _fetchedResultsController = fetchedResultsController;
    
    NSError *error = nil;
    [_fetchedResultsController performFetch:&error];
    
    return _fetchedResultsController;
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    DLogFuncName();
    int numberOfDevices = [[controller fetchedObjects] count];
    [self.pageControl setNumberOfPages: numberOfDevices];
    
    [self addDevicesToScrollView];
}


- (void) clearScrollView
{
    DLogFuncName();
    for (UIView *view in self.scrollView.subviews)
    {
        [view removeFromSuperview];
    }
}


- (void) clearChildViewControllers
{
    DLogFuncName();
    for (UIViewController *viewController in [self.childViewControllers copy])
    {
        [viewController removeFromParentViewController];
    }
}


- (void) updatePageControl
{
    DLogFuncName();

    
}


- (void) updateTitle
{
    DLogFuncName();
    
    NSArray *fetchedObjects = [self.fetchedResultsController fetchedObjects];
    if ([fetchedObjects count] > 0)
    {
        int page = self.pageControl.currentPage;
        PSNetAtmoDevice *device = [fetchedObjects objectAtIndex:(page)];
        self.title = device.stationName;
    }
}


- (void) addDevicesToScrollView
{
    DLogFuncName();

    [self clearScrollView];
    [self clearChildViewControllers];
    
    for (PSNetAtmoDevice *device in [self.fetchedResultsController fetchedObjects])
    {
        int index = [[self.fetchedResultsController fetchedObjects] indexOfObject:device];
        PSNetAtmoDeviceViewController *deviceViewController = [[PSNetAtmoDeviceViewController alloc] initWithDevice:device];
        float width = self.scrollView.bounds.size.width;
        float height = self.scrollView.bounds.size.height;
        
        float x = width * [[self.fetchedResultsController fetchedObjects] indexOfObject:device];
        float y = 0;
    
        deviceViewController.view.frame = CGRectMake(x, y, width, height);
        deviceViewController.view.tag = index;
        DLog(@"Frame = %@", NSStringFromCGRect(deviceViewController.view.frame));
        
        [self addChildViewController:deviceViewController];
        [deviceViewController willMoveToParentViewController:self];
//        [self.scrollView setContentOffset:CGPointMake(self.view.bounds.size.width * [[self.fetchedResultsController fetchedObjects] indexOfObject:device],0)];
        [self.scrollView addSubview:deviceViewController.view];
        [deviceViewController didMoveToParentViewController:self];
        
        [self.scrollView setContentSize:CGSizeMake(width * (index + 1), height)];
    }
    
    [self.scrollView bringSubviewToFront:self.pageControl];
    [self.pageControl setNumberOfPages:[[self.fetchedResultsController fetchedObjects] count]];
    DLog(@"Frame = %@", NSStringFromCGRect(self.scrollView.frame));
    DLog(@"Bounds = %@", NSStringFromCGRect(self.scrollView.bounds));
    DLog(@"ContentSize = %@", NSStringFromCGSize(self.scrollView.contentSize));
    DLog(@"Inset = %@", NSStringFromUIEdgeInsets(self.scrollView.contentInset));
    [self updateTitle];
}
@end
