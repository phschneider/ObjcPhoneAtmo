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

@interface PSNetAtmoDevicesViewController ()
@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIPageControl *pageControl;
@property (nonatomic) NSFetchedResultsController *fetchedResultsController;
@end

@implementation PSNetAtmoDevicesViewController

- (id) init
{
    DLogFuncName();
    self = [super init];
    if (self)
    {
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        [self.view addSubview:self.scrollView];
        
        self.pageControl = [[UIPageControl alloc] initWithFrame:self.view.bounds];
        self.pageControl.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        [self.view addSubview:self.scrollView];
    }
    return self;
}


- (void) viewDidAppear:(BOOL)animated
{
    DLogFuncName();
    [super viewDidAppear:animated];
    
    if ([[PSNetAtmoAccount sharedInstance] currentAccountIsValid])
    {
        [PSNetAtmoApi devices];
    }
}


#pragma mark - TableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLogFuncName();
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    PSNetAtmoDevice * device = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = device.deviceID;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLogFuncName();
    PSNetAtmoDevice * device = [self.fetchedResultsController objectAtIndexPath:indexPath];
    PSNetAtmoModulesViewController * modulesViewController = [[PSNetAtmoModulesViewController alloc] initWithDevice:device];
    [self.navigationController pushViewController:modulesViewController animated:YES];
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
    [self.tableView reloadData];
}

@end
