//
//  Event.h
//  EventTracking
//
//  Created by Bali on 22/11/14.
//  Copyright (c) 2014 Keepworks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject
{
    NSString *eventImage;
    NSString *eventName;
    NSString *eventPlace;
    NSString *eventType;
}

- (void)setEventImage:(NSString *)image;
- (void)setEventName:(NSString *)name;
- (void)setEventPlace:(NSString *)place;
- (void)setEntryType:(NSString *)type;

- (NSString *)getEventImage;
- (NSString *)getEventName;
- (NSString *)getEventPlace;
- (NSString *)getEntryType;

@end
