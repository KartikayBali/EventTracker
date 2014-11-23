//
//  EventDetailViewController.m
//  EventTracking
//
//  Created by Bali on 22/11/14.
//  Copyright (c) 2014 Keepworks. All rights reserved.
//

#import "EventDetailViewController.h"
#import "AppDelegate.h"
//#import "DataManager.h"
#import "TrackingListViewController.h"
#import "Event.h"

@interface EventDetailViewController () <ToDetailDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *eventImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *placeValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *entryTypeValueLabel;
@property (strong, nonatomic) IBOutlet UIButton *trackingButton;

- (IBAction)trackingButtonClicked:(id)sender;
- (IBAction)swipeLeft:(id)sender;

@end

@implementation EventDetailViewController

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
    
    self.navigationItem.title = [self.event getEventName];
    
    self.eventImageView.image = [UIImage imageNamed:[self.event getEventImage]];
    self.nameValueLabel.text = [self.event getEventName];
    self.placeValueLabel.text = [self.event getEventPlace];
    self.entryTypeValueLabel.text = [self.event getEntryType];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self getTrackingStatus];
}

- (void)getTrackingStatus
{
    NSString *username = [[AppDelegate sharedInstance] username];
    NSArray *trackingArray = [[NSUserDefaults standardUserDefaults] valueForKey:username];
    NSInteger index = [trackingArray indexOfObject:[self.event getEventName]];
    if (index != NSNotFound) {
        [self.trackingButton setTitle:@"Yes" forState:UIControlStateNormal];
    }
    else {
        [self.trackingButton setTitle:@"No" forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)trackingButtonClicked:(id)sender
{
    NSString *username = [[AppDelegate sharedInstance] username];
    NSArray *valueArray = [[NSUserDefaults standardUserDefaults] valueForKey:username];
    NSMutableArray *trackingArray = [NSMutableArray arrayWithArray:valueArray];
    
    if ([self.trackingButton.titleLabel.text isEqualToString:@"Yes"]) {
        [self.trackingButton setTitle:@"No" forState:UIControlStateNormal];
        [trackingArray removeObject:[self.event getEventName]];
    }
    else {
        [self.trackingButton setTitle:@"Yes" forState:UIControlStateNormal];
        [trackingArray addObject:[self.event getEventName]];
    }
    
    [[NSUserDefaults standardUserDefaults] setValue:trackingArray forKey:username];
}

- (IBAction)swipeLeft:(id)sender
{
    [self performSegueWithIdentifier:@"ToTrackingListFromDetail" sender:nil];
}

#pragma mark - Navigation

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ToTrackingListFromDetail"]) {
        TrackingListViewController *obj = segue.destinationViewController;
        obj.delegate = self;
    }
}

#pragma mark - ToDetail delegate

- (void)gotoEventDetailWithName:(NSString *)eventName
{
    [self.navigationController popViewControllerAnimated:NO];
    [self.delegate gotoEventDetailWithName:eventName];
}

@end
