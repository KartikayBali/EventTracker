//
//  Event.m
//  EventTracking
//
//  Created by Bali on 22/11/14.
//  Copyright (c) 2014 Keepworks. All rights reserved.
//

#import "Event.h"

@implementation Event

- (id)init
{
    if (self) {
        self = [super init];
    }
    return self;
}

- (void)setEventName:(NSString *)name
{
    eventName = name;
}

- (void)setEventPlace:(NSString *)place
{
    eventPlace = place;
}

- (void)setEntryType:(NSString *)type
{
    eventType = type;
}

- (void)setEventImage:(NSString *)image
{
    eventImage = image;
}

- (NSString *)getEventImage
{
    return eventImage;
}

- (NSString *)getEventName
{
    return eventName;
}

- (NSString *)getEventPlace
{
    return eventPlace;
}

- (NSString *)getEntryType
{
    return eventType;
}

@end
