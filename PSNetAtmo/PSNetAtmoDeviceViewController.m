//
//  PSNetAtmoDeviceViewController.m
//  PSNetAtmo
//
//  Created by Philip Schneider on 21.04.14.
//  Copyright (c) 2014 phschneider.net. All rights reserved.
//

#import "PSNetAtmo.h"
#import "PSNetAtmoApi.h"
#import "PSNetAtmoDeviceViewController.h"
#import "PSNetAtmoModulesViewController.h"

@interface PSNetAtmoDeviceViewController ()
@property (nonatomic) UITableView * tableView;
@end

@implementation PSNetAtmoDeviceViewController

- (id) init
{
    DLogFuncName();
    self = [super init];
    if (self)
    {
        self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.rowHeight = 10;
        self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self.view addSubview:self.tableView];

        
        [[NSNotificationCenter defaultCenter] addObserverForName:PSNETATMO_DEVICE_UPDATE_NOTIFICATION
                                                          object:nil
                                                           queue:nil
                                                      usingBlock:^(NSNotification *aNotification){
                                                          
                                                          [self.tableView reloadData];
                                                      }];
    }
    return self;
}


- (id) initWithDevice:(PSNetAtmoDevice*)device
{
    DLogFuncName();
    
    self = [self init];
    if (self)
    {
        
    }
    return self;
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
    
    cell.textLabel.text = @"blaa";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
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
    return 4;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLogFuncName();
    PSNetAtmoModulesViewController * modulesViewController = [[PSNetAtmoModulesViewController alloc] initWithDevice:device];
    [self.navigationController pushViewController:modulesViewController animated:YES];
}


#pragma mark - FetchedResultsController

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView reloadData];
}

@end
