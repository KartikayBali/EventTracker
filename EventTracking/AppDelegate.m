//
//  AppDelegate.m
//  EventTracking
//
//  Created by Bali on 22/11/14.
//  Copyright (c) 2014 Keepworks. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "Event.h"

static AppDelegate *sharedInstance = nil;

@implementation AppDelegate

+(AppDelegate *)sharedInstance{
    if (!sharedInstance) {
        sharedInstance = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return sharedInstance;
}

- (void)initializeEventArray
{
    self.eventDict = [NSMutableDictionary dictionary];
    self.eventArray = [NSMutableArray array];
    NSArray *tempArray = @[@[@"Metallica Concert",@"Palace Grounds", @"paid entry", @"MetallicaConcert.jpg"],
                            @[@"Saree Exhibition",@"Malleswaram Grounds", @"free entry", @"SareeExhibition.jpg"],
                            @[@"Wine tasting event",@"Links Brewery", @"paid entry", @"WineTasting.jpg"],
                            @[@"Startups Meet",@"Kanteerava Indoor Stadium", @"paid entry", @"StartupMeet.gif"],
                            @[@"Summer Noon Party",@"Kumara Park", @"paid entry", @"SummerParty.jpg"],
                            @[@"Rock and Roll nights",@"Sarjapur Road", @"paid entry", @"RockAndRoll.jpg"],
                            @[@"Barbecue Fridays",@"Whitefield", @"paid entry", @"Barbeque.jpg"],
                            @[@"Summer workshop",@"Indiranagar", @"free entry", @"SummerWorkshop.jpg"],
                            @[@"Impressions & Expressions",@"MG Road", @"free entry", @"ImpressionExpression.jpg"],
                            @[@"Italian carnival",@"Electronic City", @"free entry", @"ItalianCarnival.jpg"]];
    
    for (int i = 0; i < tempArray.count; i ++) {
        NSArray *innerArray = tempArray[i];
        Event *ob = [[Event alloc] init];
        [ob setEventName:innerArray[0]];
        [ob setEventPlace:innerArray[1]];
        [ob setEntryType:innerArray[2]];
        [ob setEventImage:innerArray[3]];
        
        [self.eventArray addObject:ob];
        self.eventDict[innerArray[0]] = ob;
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    [self initializeEventArray];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HomeViewController *obj = storyboard.instantiateInitialViewController;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:obj];
    nav.navigationBar.translucent = NO;
    self.window.rootViewController = nav;
        
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
