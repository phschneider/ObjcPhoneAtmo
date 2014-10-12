//
// Created by Philip Schneider on 02.05.14.
// Copyright (c) 2014 phschneider.net. All rights reserved.
//

#import "PSNetAtmoProfilesViewController.h"
#import "PSNetAtmo.h"
#import "PSAppDelegate.h"
#import "PSNetAtmoAccountWithAuthHandler.h"
#import "SVProgressHUD.h"


@interface PSNetAtmoProfilesViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@end

@implementation PSNetAtmoProfilesViewController


- (id) init
{
    DLogFuncName();
    self = [super init];
    if (self)
    {
        self.title = @"Profiles";
        self.view.backgroundColor = [UIColor whiteColor];

        self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        [self.view addSubview:self.tableView];

        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    }
    return self;
}


#pragma mark - View
- (void) viewWillDisappear:(BOOL)animated
{
    DLogFuncName();
    [SVProgressHUD dismiss];
}


- (void) add
{
    DLogFuncName();

    [SVProgressHUD show];
    [[PSNetAtmoAccountWithAuthHandler sharedInstance] requestAccountWithPreparedAuthorizationURLHandler];
}


#pragma mark - TableView
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DLogFuncName();
    return [[self.fetchedResultsController fetchedObjects] count];
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLogFuncName();
    static NSString *cellIdentifier = @"ProfilesCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    PSNetAtmoUser *user = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = user.mail;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Expires at %@",user.expireString];
    
    return cell;
}


- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    DLogFuncName();
    return 1;
}


- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLogFuncName();
    switch (editingStyle)
    {
        case UITableViewCellEditingStyleDelete:
            {
                PSNetAtmoUser *user = [self.fetchedResultsController objectAtIndexPath:indexPath];
                [[NXOAuth2AccountStore sharedStore] removeAccount:user.oAuthAccount];
                [user delete];
            
                [APPDELEGATE saveContext];
            }
            break;
            
        default:
            break;
    }
}


#pragma mark - Fetchedresultscontroller
- (NSFetchedResultsController *) fetchedResultsController
{
    DLogFuncName();
    NSFetchedResultsController *fetchedResultsController = nil;

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NETATMO_ENTITY_USER];
    // [request setPredicate:[NSPredicate predicateWithFormat:@"ANY owners == %@", currentUser]];

    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"userID" ascending:YES];
    [request setSortDescriptors:@[sortDescriptor]];
    fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:APPDELEGATE.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    [fetchedResultsController setDelegate:self];

    _fetchedResultsController = fetchedResultsController;

    NSError *error = nil;
    [_fetchedResultsController performFetch:&error];
    return _fetchedResultsController;
}


- (void) controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    DLogFuncName();

    [self.tableView reloadData];
}

@end