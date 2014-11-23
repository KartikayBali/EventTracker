//
//  ViewController.m
//  EventTracking
//
//  Created by Bali on 22/11/14.
//  Copyright (c) 2014 Keepworks. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import "HomeListViewCell.h"
#import "EventDetailViewController.h"
#import "TrackingListViewController.h"
#import "GridCollectionViewCell.h"
#import "Event.h"

@interface HomeViewController () <UIAlertViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate, ToDetailDelegate>
{
    NSString *username;
    UIBarButtonItem *viewButton;
}

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *eventArray;
@property (strong, nonatomic) NSMutableDictionary *eventIdNameDict;

- (IBAction)swipeLeft:(id)sender;

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self showUsernamePopup];
}

- (void) showUsernamePopup
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Hi"
                                                        message:@"Enter your name" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            UITextField *textfield = [alertView textFieldAtIndex:0];
            if ([self validateName:textfield.text]) {
                [self loadData:textfield.text];
            }
            else {
                [self showUsernamePopup]; //show alert again
            }
        }
            break;
            
        default:
            break;
    }
}

- (BOOL)validateName:(NSString *)name
{
    if (name.length > 0) {
        username = name;
        return YES;
    }
    else {
        return NO;
    }
}

- (void) loadData:(NSString *)name
{
    self.navigationItem.title = [NSString stringWithFormat:@"Welcome %@", name];
    
    viewButton = [[UIBarButtonItem alloc] initWithTitle:@"Grid" style:UIBarButtonItemStyleDone target:self action:@selector(toggleButtonClicked)];
    self.navigationItem.rightBarButtonItem = viewButton;
    
    [[AppDelegate sharedInstance] setUsername:name];
    NSArray *trackingArray = [[NSUserDefaults standardUserDefaults] valueForKey:username];
    if (trackingArray == nil) {
        trackingArray = [NSArray array];
        [[NSUserDefaults standardUserDefaults] setValue:trackingArray forKey:username];
    }
    
    self.collectionView.alpha = 0;
    
    UINib *nib = [UINib nibWithNibName:@"HomeListViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"HomeListViewCellIdentifier"];
        
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    self.eventArray = [[AppDelegate sharedInstance] eventArray];
    
    [self.tableView reloadData];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.collectionView reloadData];
}

- (void)toggleButtonClicked
{
    if ([viewButton.title isEqualToString:@"Grid"]) {
        viewButton.title = @"List";
        self.tableView.alpha = 0;
        self.collectionView.alpha = 1;
    }
    else {
        viewButton.title = @"Grid";
        self.tableView.alpha = 1;
        self.collectionView.alpha = 0;
    }
}

#pragma mark - UITableView datasource

- (int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.eventArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeListViewCellIdentifier"];
    
    cell.nameLabelWidth.constant = (tableView.frame.size.width - 25 - cell.imageViewWidth.constant) * 0.4;
    cell.placeLabelWidth.constant = (tableView.frame.size.width - 25 - cell.imageViewWidth.constant) * 0.4;
    
    if (indexPath.row == 0) {
        cell.nameLabel.text = @"Name";
        cell.placeLabel.text = @"Place";
        cell.entryTypeLabel.text = @"Entry Type";
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameLabel.font = cell.placeLabel.font = cell.entryTypeLabel.font = [UIFont boldSystemFontOfSize:17];
    }
    else {        
        Event *ob = self.eventArray[indexPath.row - 1];
        cell.eventImageView.image = [UIImage imageNamed:[ob getEventImage]];
        cell.nameLabel.text = [ob getEventName];
        cell.placeLabel.text = [ob getEventPlace];
        cell.entryTypeLabel.text = [ob getEntryType];
        
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.nameLabel.font = cell.placeLabel.font = cell.entryTypeLabel.font = [UIFont systemFontOfSize:17];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 44;
    }
    else {
        return 60;
    }
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 0) {
        [self performSegueWithIdentifier:@"ToEventDetail" sender:self.eventArray[indexPath.row - 1]];
    }
}

#pragma mark - UICollectionView datasource

- (int)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.eventArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GridCollectionViewCell *cell = (GridCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"GridCollectionViewCellIdentifier" forIndexPath:indexPath];
 
    Event *event = self.eventArray[indexPath.row];
    cell.gridImageView.image = [UIImage imageNamed:[event getEventImage]];
    cell.nameLabel.text = [event getEventName];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //setting up the size of collection view cell
    CGFloat inset = 20;
    CGFloat width = (collectionView.frame.size.width - 4 * inset) / 2;
    CGFloat height = 266;
    return CGSizeMake(width, height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"ToEventDetail" sender:self.eventArray[indexPath.row]];
}

#pragma mark - Set Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ToEventDetail"]) {
        Event *event = sender;
        EventDetailViewController *obj = segue.destinationViewController;
        obj.event = event;
        obj.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"ToTrackingListFromHome"]) {
        TrackingListViewController *obj = segue.destinationViewController;
        obj.delegate = self;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ToDetail delegate

- (void) gotoEventDetailWithName:(NSString *)eventName
{
    NSMutableDictionary *eventDict = [[AppDelegate sharedInstance] eventDict];
    Event *obj = eventDict[eventName];
    [self.tableView reloadData];
    [self performSegueWithIdentifier:@"ToEventDetail" sender:obj];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.tableView reloadData];
    [self.collectionView reloadData];
}

- (IBAction)swipeLeft:(id)sender
{
    [self performSegueWithIdentifier:@"ToTrackingListFromHome" sender:nil];
}

@end
