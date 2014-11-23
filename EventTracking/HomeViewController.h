//
//  ViewController.h
//  EventTracking
//
//  Created by Bali on 22/11/14.
//  Copyright (c) 2014 Keepworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ToDetailDelegate <NSObject>

- (void)gotoEventDetailWithName:(NSString *)eventName;

@end

@interface HomeViewController : UIViewController

@end
