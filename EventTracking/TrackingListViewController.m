//
//  TrackingListViewController.m
//  EventTracking
//
//  Created by Bali on 23/11/14.
//  Copyright (c) 2014 Keepworks. All rights reserved.
//

#import "TrackingListViewController.h"
#import "HomeListViewCell.h"
#import "AppDelegate.h"

@interface TrackingListViewController ()
{
    UIBarButtonItem *editButton;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)swipeLeft:(id)sender;

@end

@implementation TrackingListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"Tracking List";
    
    editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleDone target:self action:@selector(editButtonClicked)];
    self.navigationItem.rightBarButtonItem = editButton;
    
    UINib *nib = [UINib nibWithNibName:@"HomeListViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"HomeListViewCellIdentifier"];
    
    self.tableView.editing = NO;
}

- (void) editButtonClicked
{
    if (self.tableView.editing) {
        editButton.title = @"Edit";
        self.tableView.editing = NO;
    }
    else {
        editButton.title = @"Done";
        self.tableView.editing = YES;
    }
}

#pragma mark - UITableView datasource

- (int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *username = [[AppDelegate sharedInstance] username];
    NSArray *trackingList = [[NSUserDefaults standardUserDefaults] valueForKey:username];
    return trackingList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *username = [[AppDelegate sharedInstance] username];
    NSArray *trackingList = [[NSUserDefaults standardUserDefaults] valueForKey:username];
    
    cell.textLabel.text = trackingList[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController popViewControllerAnimated:NO];
    NSString *username = [[AppDelegate sharedInstance] username];
    NSArray *trackingList = [[NSUserDefaults standardUserDefaults] valueForKey:username];
    [self.delegate gotoEventDetailWithName:trackingList[indexPath.row]];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
        return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
        return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString *username = [[AppDelegate sharedInstance] username];
        NSArray *trackingList = [[NSUserDefaults standardUserDefaults] valueForKey:username];
        
        NSMutableArray *tempTrackingList = [NSMutableArray arrayWithArray:trackingList];
        [tempTrackingList removeObjectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults] setValue:tempTrackingList forKey:username];
        [tableView reloadData];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *username = [[AppDelegate sharedInstance] username];
    NSArray *trackingList = [[NSUserDefaults standardUserDefaults] valueForKey:username];
    
    NSMutableArray *tempTrackingList = [NSMutableArray arrayWithArray:trackingList];
        
    if (sourceIndexPath.row <= destinationIndexPath.row) {
        [tempTrackingList insertObject:tempTrackingList[sourceIndexPath.row] atIndex:destinationIndexPath.row + 1];
        [tempTrackingList removeObjectAtIndex:sourceIndexPath.row];
    }
    else {
        [tempTrackingList insertObject:tempTrackingList[sourceIndexPath.row] atIndex:destinationIndexPath.row];
        [tempTrackingList removeObjectAtIndex:sourceIndexPath.row + 1];
    }

    [[NSUserDefaults standardUserDefaults] setValue:tempTrackingList forKey:username];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)swipeLeft:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
