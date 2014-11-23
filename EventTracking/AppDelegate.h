//
//  AppDelegate.h
//  EventTracking
//
//  Created by Bali on 22/11/14.
//  Copyright (c) 2014 Keepworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSMutableArray *eventArray;
@property (strong, nonatomic) NSMutableDictionary *eventDict;

+ (AppDelegate *)sharedInstance;

@end
