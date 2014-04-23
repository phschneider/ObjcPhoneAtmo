//
//  PSNetAtmoDeviceViewController.m
//  PSNetAtmo
//
//  Created by Philip Schneider on 21.04.14.
//  Copyright (c) 2014 phschneider.net. All rights reserved.
//

#import "PSNetAtmo.h"
#import "PSNetAtmoApi.h"
#import "PSNetAtmoModule+Helper.h"
#import "PSNetAtmoDeviceViewController.h"
#import "PSNetAtmoModulesViewController.h"
#import "PSNetAtmoModuleTableViewCell.h"

@interface PSNetAtmoDeviceViewController ()
@property (nonatomic) PSNetAtmoDevice *device;
//@property (nonatomic) UITableView *tableView;
//@property (nonatomic) UIRefreshControl *myrefreshControl;
@end

@implementation PSNetAtmoDeviceViewController

- (id) init
{
    DLogFuncName();
    self = [super init];
    if (self)
    {
//        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
//            self.edgesForExtendedLayout = UIRectEdgeNone;
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.tableView.separatorColor = [UIColor whiteColor];
        self.tableView.rowHeight = 100;
//        self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//        [self.view addSubview:self.tableView];

        self.refreshControl = [[UIRefreshControl alloc] init];
        [self.refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
//        [self.tableView addSubview:self.refreshControl];
//        [tablview addSubview:self.refreshControl];
        
        [[NSNotificationCenter defaultCenter] addObserverForName:PSNETATMO_DEVICE_UPDATE_NOTIFICATION
                                                          object:nil
                                                           queue:nil
                                                      usingBlock:^(NSNotification *aNotification){
                                                          
                                                          [self.tableView reloadData];
                                                      }];
        
        self.tableView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void) handleRefresh:(UIControl*)sender
{
    DLogFuncName();
    [self.tableView reloadData];
    [self.tableView scrollsToTop];
    [self.refreshControl endRefreshing];
}


- (id) initWithDevice:(PSNetAtmoDevice*)device
{
    DLogFuncName();
    
    self = [self init];
    if (self)
    {
        _device = device;
//        [self.tableView reloadData];
//        DLog(@"Bounds = %@", NSStringFromCGRect(self.view.bounds));
//        DLog(@"Frame = %@", NSStringFromCGRect(self.view.frame));
//        DLog(@"Bounds = %@", NSStringFromCGRect(self.tableView.bounds));
//        DLog(@"Frame = %@", NSStringFromCGRect(self.tableView.frame));
//        self.tableView.rowHeight = ceil(self.view.bounds.size.height/[[self.device modules] count]);
    }
    return self;
}


- (void) viewDidAppear:(BOOL)animated
{
    DLogFuncName();
    [super viewDidAppear:animated];
    [self.tableView setContentInset:UIEdgeInsetsMake(64,0,64,0)];
    //
    //    CGRect frame = self.tableView.frame;
    //    frame.size.height = 504;
    //    self.tableView.frame = frame;

//    self.tableView.frame = self.view.bounds;
    DLog(@"Bounds = %@", NSStringFromCGRect(self.view.bounds));
    DLog(@"Frame = %@", NSStringFromCGRect(self.view.frame));
    DLog(@"Bounds = %@", NSStringFromCGRect(self.tableView.bounds));
    DLog(@"Frame = %@", NSStringFromCGRect(self.tableView.frame));
//    self.tableView.rowHeight = ceil(self.view.bounds.size.height/[[self.device modules] count]);
//    [self.tableView reloadData];
}


#pragma mark - TableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLogFuncName();
    static NSString *CellIdentifier = @"Cell";
    
    PSNetAtmoModuleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[PSNetAtmoModuleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    PSNetAtmoModule *deviceModule = [[[self.device modules] allObjects] objectAtIndex:indexPath.row];
    [deviceModule requestLastMeasure];
    [cell setDeviceModule:deviceModule];
    
    return cell;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    DLogFuncName();
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DLogFuncName();
    return [[self.device modules] count];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLogFuncName();
    return;
    PSNetAtmoModulesViewController * modulesViewController = [[PSNetAtmoModulesViewController alloc] initWithDevice:self.device];
    [self.parentViewController.navigationController pushViewController:modulesViewController animated:YES];
}


#pragma mark - FetchedResultsController

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView reloadData];
}

@end
