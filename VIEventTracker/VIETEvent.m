//
//  VIETEvent.m
//  VIEventTracker
//
//  Created by Vito on 1/26/14.
//  Copyright (c) 2014 Vito. All rights reserved.
//

#import "VIETEvent.h"

#define kCodingEventCountKey @"count"
#define kCodingEventTrackingKey @"tracking"

@implementation VIETEvent

- (instancetype)init {
    self = [super init];
    if (self) {
        _tracking = YES;
        _count = 0;
        _locked = NO;
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _tracking = [aDecoder decodeBoolForKey:kCodingEventTrackingKey];
        _count = [aDecoder decodeIntegerForKey:kCodingEventCountKey];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:_count forKey:kCodingEventCountKey];
    [aCoder encodeBool:_tracking forKey:kCodingEventTrackingKey];
}


@end
