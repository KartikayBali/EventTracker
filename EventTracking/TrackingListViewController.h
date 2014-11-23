//
//  TrackingListViewController.h
//  EventTracking
//
//  Created by Bali on 23/11/14.
//  Copyright (c) 2014 Keepworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"

@interface TrackingListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<ToDetailDelegate> delegate;

@end
