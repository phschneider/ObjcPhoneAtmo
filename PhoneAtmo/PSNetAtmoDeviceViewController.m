//
//  PSNetAtmoDeviceViewController.m
//  PSNetAtmo
//
//  Created by Philip Schneider on 21.04.14.
//  Copyright (c) 2014 phschneider.net. All rights reserved.
//

#import "PSNetAtmo.h"
#import "PSAppDelegate.h"
#import "PSNetAtmoApi.h"
#import "PSNetAtmoModule+Helper.h"
#import "PSNetAtmoDeviceViewController.h"
#import "PSNetAtmoModuleTableViewCell.h"

@interface PSNetAtmoDeviceViewController ()
@property (nonatomic) PSNetAtmoDevice *device;
@property (nonatomic) NSFetchedResultsController *fetchedResultsController;
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
//    [self.tableView reloadData];
//    [self.tableView scrollsToTop];
    
    for (PSNetAtmoModule *module in [self.fetchedResultsController fetchedObjects])
    {
        [module requestLastMeasure];
    }
    
    [self.refreshControl endRefreshing];
}


- (id) initWithDevice:(PSNetAtmoDevice*)device
{
    DLogFuncName();
    
    self = [self init];
    if (self)
    {
        _device = device;
    }
    return self;
}


- (void) viewDidAppear:(BOOL)animated
{
    DLogFuncName();
    [super viewDidAppear:animated];
    [self.tableView setContentInset:UIEdgeInsetsMake(64,0,0,0)];
    //
    //    CGRect frame = self.tableView.frame;
    //    frame.size.height = 504;
    //    self.tableView.frame = frame;

//    self.tableView.frame = self.view.bounds;
    DLog(@"Bounds = %@", NSStringFromCGRect(self.view.bounds));
    DLog(@"Frame = %@", NSStringFromCGRect(self.view.frame));
    DLog(@"Bounds = %@", NSStringFromCGRect(self.tableView.bounds));
    DLog(@"Frame = %@", NSStringFromCGRect(self.tableView.frame));
}


#pragma mark - TableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int numberOfDevices = [[self.fetchedResultsController fetchedObjects] count];
    NSLog(@"number of devices = %d", numberOfDevices);
    UINavigationBar *navBar = self.navigationController.navigationBar;
    float height = self.view.bounds.size.height - navBar.frame.size.height - [[UIApplication sharedApplication] statusBarFrame].size.height;
    NSLog(@"Height = %f",height);

    NSLog(@"RowHeight = %f",ceil( height /numberOfDevices));
    
#warning todo - minheight
#warning todo - maxheight
    
    return ceil( height /numberOfDevices);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLogFuncName();
    static NSString *CellIdentifier = @"Cell";
    
    PSNetAtmoModuleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[PSNetAtmoModuleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
//    PSNetAtmoModule *deviceModule = [[[self.device modules] allObjects] objectAtIndex:indexPath.row];
    PSNetAtmoModule *deviceModule = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell setDeviceModule:deviceModule];
    
    return cell;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    DLogFuncName();
//    return 1;
    return [[self.fetchedResultsController sections] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DLogFuncName();
//    return [[self.device modules] count];
    return [[self.fetchedResultsController fetchedObjects] count];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLogFuncName();

    return;

//    PSNetAtmoModule *deviceModule = [self.fetchedResultsController objectAtIndexPath:indexPath];
//    [self.parentViewController.navigationController pushViewController:modulesViewController animated:YES];
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
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NETATMO_ENTITY_MODULE];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"moduleID" ascending:YES];
    [request setSortDescriptors:@[sortDescriptor]];
    fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:APPDELEGATE.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    [fetchedResultsController setDelegate:self];
    [request setPredicate:[NSPredicate predicateWithFormat:@"device == %@", self.device]];

    
    _fetchedResultsController = fetchedResultsController;
    
    NSError *error = nil;
    [_fetchedResultsController performFetch:&error];
    
    return _fetchedResultsController;
}


//- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
//{
//    DLogFuncName();
//
//    [self.tableView reloadData];
//}


-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    DLogFuncName();
    NSArray *indexPaths = nil;
    if (!indexPath)
    {
        NSLog(@"No indexpath, reloading tableview");
        [self.tableView reloadData];
        return;
    }
    
    if ([indexPath isEqual:newIndexPath])
    {
        indexPaths = @[indexPath];
    }
    else
    {
        indexPaths = @[indexPath, newIndexPath];
    }
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            NSLog(@"TODO NSFetchedResultsChangeInsert");
            break;
            
        case NSFetchedResultsChangeDelete:
            NSLog(@"TODO NSFetchedResultsChangeDelete");
            break;
            
        case NSFetchedResultsChangeMove:
            NSLog(@"TODO NSFetchedResultsChangeMove");
            break;
            
        case NSFetchedResultsChangeUpdate:
        {
            [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        }
            break;
            
        default:
            break;
    }
}
@end
