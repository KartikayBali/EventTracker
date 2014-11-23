//
//  EventDetailViewController.h
//  EventTracking
//
//  Created by Bali on 22/11/14.
//  Copyright (c) 2014 Keepworks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"

@class Event;

@interface EventDetailViewController : UIViewController

@property (nonatomic, strong) Event *event;
@property (nonatomic, weak) id <ToDetailDelegate> delegate;

@end
