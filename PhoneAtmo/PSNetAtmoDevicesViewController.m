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
#import "PSNetAtmoNavigationController.h"

@interface PSNetAtmoDevicesViewController ()
@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIPageControl *pageControl;
@property (nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic) PSNetAtmoNoAccountView *noAccountView;
@property (nonatomic) UILabel *noAccountLabel;
@property (nonatomic) UILabel *centeredLabel;
@end

@implementation PSNetAtmoDevicesViewController


- (id) init
{
    DLogFuncName();
    DEBUG_DEVICES_LogName();
    
    self = [super init];
    if (self)
    {
        self.title = @"Home";
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accountUpdated:) name:PSNETATMO_ACCOUNT_UPDATE_NOTIFICATION object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCurrentUser:) name:PSNETNETATMO_SET_CURRENT_USER_NOTIFICATION object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateDevices:) name:PSNETATMO_UPDATED_DEVICES_NOTIFICATION object:nil];

        self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.scrollView.delegate = self;
        self.scrollView.backgroundColor = [UIColor whiteColor];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.directionalLockEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:self.scrollView];
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-20,self.view.bounds.size.width, 20)];
        self.pageControl.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        self.pageControl.backgroundColor = [UIColor clearColor];
        self.pageControl.hidesForSinglePage = YES;
        self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        self.pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
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
        
//        self.noAccountView = [[PSNetAtmoNoAccountView alloc] initWithFrame:CGRectMake(ceil((self.view.bounds.size.width-200)/2),ceil((self.view.bounds.size.height-120)/2),200, 120)];
//        self.noAccountView.alpha = .0;
//        [self.view addSubview:self.noAccountView];
//        
//        frame = CGRectMake(0, ceil((height)/2), width, ceil(height/2));
//        self.noAccountLabel = [[UILabel alloc] initWithFrame:frame];
//        self.noAccountLabel.textAlignment = NSTextAlignmentCenter;
//        self.noAccountLabel.numberOfLines = 0;
//        self.noAccountLabel.text = @"No account, click here to authorize.";
//        self.noAccountLabel.textColor = [UIColor whiteColor];
//        
//        [self.view addSubview:self.noAccountLabel];
        
//        if ( ![[PSNetAtmoApiAccount sharedInstance] hasAccount] )
//        {
//            UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer:)];
//            [self.view addGestureRecognizer: tapRecognizer];
//            
//            [self requestAccount];
//        }
//        else
//        {
//            [self hideNoAccount];
//            
//            [PSNetAtmoApi user];
//            [PSNetAtmoApi devices];
//            [self controllerDidChangeContent:self.fetchedResultsController];
//        }
    }
    return self;
}

- (void) updateDevices:(NSNotification *)notification
{
    DLogFuncName();
    DEBUG_DEVICES_LogName();

    [self showDevices];
}


- (void) updateCurrentUser:(NSNotification *)notification
{
    DLogFuncName();
    DEBUG_DEVICES_LogName();

    // wrong notification
}


- (void) viewWillAppear:(BOOL)animated
{
    DLogFuncName();
    DEBUG_DEVICES_LogName();

    [super viewWillAppear:animated];
    
    [self controllerDidChangeContent:self.fetchedResultsController];
}


- (void) viewDidAppear:(BOOL)animated
{
    DLogFuncName();
    DEBUG_DEVICES_LogName();

    [super viewDidAppear:animated];
}


#pragma mark - Account
- (void) accountUpdated:(NSNotification*)note
{
    DLogFuncName();
    DEBUG_DEVICES_LogName();

#warning todo NXOAuth2AccountStore storeAccountsInDefaultKeychain
    [self showDevices];
}


- (void) showDevices
{
    DLogFuncName();
    DEBUG_DEVICES_LogName();

//    PSNetAtmoDevicesViewController * devicesViewController = [[PSNetAtmoDevicesViewController alloc] init];
//    [self.navigationController pushViewController:devicesViewController animated:YES];
    [self hideNoAccount];
    [self controllerDidChangeContent:self.fetchedResultsController];
//    [PSNetAtmoApi devices];
}


#pragma mark - GestureRecognizer
- (void) showNoAccount
{
    DLogFuncName();
    DEBUG_DEVICES_LogName();

    self.noAccountLabel.hidden = NO;
    self.noAccountView.hidden = NO;
}


- (void) hideNoAccount
{
    DLogFuncName();
    DEBUG_DEVICES_LogName();

    self.noAccountLabel.hidden = YES;
    self.noAccountView.hidden = YES;
}

- (void) tapGestureRecognizer:(UIGestureRecognizer*)gestureRecognizer
{
    DLogFuncName();
    DEBUG_DEVICES_LogName();

}


- (void) changePage:(id)sender
{
    DLogFuncName();
    DEBUG_DEVICES_LogName();

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
    DEBUG_DEVICES_LogName();
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
    DEBUG_DEVICES_LogName();
}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    DLogFuncName();
    DEBUG_DEVICES_LogName();
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    DLogFuncName();
    DEBUG_DEVICES_LogName();
}


- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    DLogFuncName();
    DEBUG_DEVICES_LogName();
    return YES;
}


- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    DLogFuncName();
    DEBUG_DEVICES_LogName();
}


- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    DLogFuncName();
    DEBUG_DEVICES_LogName();
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    DLogFuncName();
    DEBUG_DEVICES_LogName();
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    DLogFuncName();
    DEBUG_DEVICES_LogName();
    return nil;
}


- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    DLogFuncName();
    DEBUG_DEVICES_LogName();
}


- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    DLogFuncName();
    DEBUG_DEVICES_LogName();
}


- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    DLogFuncName();
    DEBUG_DEVICES_LogName();
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    DLogFuncName();
    DEBUG_DEVICES_LogName();
}


#pragma mark - FetchedResultsController
- (NSFetchedResultsController *)fetchedResultsController
{
    DLogFuncName();
    DEBUG_DEVICES_LogName();
    
    PSNetAtmoUser * currentUser = [PSNetAtmoUser currentuser];
//    if (!currentUser)
//    {
//        return nil;
//    }
    
//    if (_fetchedResultsController)
//    {
//        DEBUG_ACCOUNT_Log(@"return existing fetchedResultsController");
//        return _fetchedResultsController;
//    }
    
    NSFetchedResultsController *fetchedResultsController = nil;
    
    // using UIManagedDocument for Core Data storage

    DEBUG_DEVICES_Log(@"CurrentUser = %@",currentUser);
//    if (currentUser)
//    {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NETATMO_ENTITY_DEVICE];
        [request setPredicate:[NSPredicate predicateWithFormat:@"ANY owners == %@", currentUser]];

        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"deviceID" ascending:YES];
        [request setSortDescriptors:@[sortDescriptor]];
        fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:APPDELEGATE.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
        [fetchedResultsController setDelegate:self];
        
        _fetchedResultsController = fetchedResultsController;
        
        NSError *error = nil;
        [_fetchedResultsController performFetch:&error];
        return _fetchedResultsController;
//    }
//    return nil;
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    DLogFuncName();
    DEBUG_DEVICES_LogName();

//    int numberOfDevices = [[controller fetchedObjects] count];
//    [self.pageControl setNumberOfPages: numberOfDevices];
    
//    _fetchedResultsController = nil;
    [self addDevicesToScrollView];
}


- (void) clearScrollView
{
    DLogFuncName();
    DEBUG_DEVICES_LogName();

    for (UIView *view in self.scrollView.subviews)
    {
        [view removeFromSuperview];
    }
}


- (void) clearChildViewControllers
{
    DLogFuncName();
    DEBUG_DEVICES_LogName();

    for (UIViewController *viewController in [self.childViewControllers copy])
    {
        [viewController removeFromParentViewController];
    }
}


- (void) updatePageControl
{
    DLogFuncName();
    DEBUG_DEVICES_LogName();
    
}


- (void) updateTitle
{
    DLogFuncName();
    DEBUG_DEVICES_LogName();

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
    DEBUG_DEVICES_LogName();

    [self clearScrollView];
    [self clearChildViewControllers];

    if ([self.fetchedResultsController fetchedObjects])
    {
        [self hideEmptyState];
        [self loadDeviceViewControllerForDevices:[self.fetchedResultsController fetchedObjects]];
    }
    else
    {
        [self showEmptyState];
    }
}


- (void) showEmptyState
{
    DLogFuncName();
    DEBUG_DEVICES_LogName();

    if (!self.centeredLabel)
    {
        self.centeredLabel = [[UILabel alloc] initWithFrame:[self centeredFrame] ];
        [self.view addSubview:self.centeredLabel];
    }

    self.centeredLabel.hidden = NO;
    self.centeredLabel.text = @"No devices ..." ;
}


- (void) hideEmptyState
{
    DLogFuncName();
    DEBUG_DEVICES_LogName();

    if (self.centeredLabel)
    {
        self.centeredLabel.hidden = YES;
    }
}


- (CGRect) centeredFrame
{
    DLogFuncName();
    DEBUG_DEVICES_LogName();

    CGRect result = CGRectMake(0, ceil (self.view.bounds.size.height/2), self.view.bounds.size.width, 44);
    return result;
}


- (void) loadDeviceViewControllerForDevices:(NSArray *)devices
{
    DLogFuncName();
    DEBUG_DEVICES_LogName();

    for (PSNetAtmoDevice *device in devices)
    {
        int index = [devices indexOfObject:device];
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
