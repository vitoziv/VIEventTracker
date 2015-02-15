//
//  VIEventTracker.m
//  VIEventTracker
//
//  Created by Vito on 1/26/14.
//  Copyright (c) 2014 Vito. All rights reserved.
//

#define VI_TRACKER_FILE_PATH [[NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"vi-event-tracker.plist"]

#import "VIEventTracker.h"
#import "VIETEvent.h"

@interface VIEventTracker ()

@property (strong, nonatomic) NSDictionary *orignTrackData;
@property (strong, nonatomic) NSMutableDictionary *trackData;

@end

@implementation VIEventTracker

+ (instancetype)sharedTracker
{
    static dispatch_once_t pred;
    static VIEventTracker *instance = nil;
    dispatch_once(&pred, ^{
        instance = [[self alloc] init];
        
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        instance.trackData = [NSMutableDictionary dictionary];
        NSString *filePath = VI_TRACKER_FILE_PATH;
        if ([fileManager fileExistsAtPath:filePath]) {
            instance.trackData = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:instance
                                                 selector:@selector(eventTrackerEnterBackground:)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:[UIApplication sharedApplication]];
    });
    return instance;
}

+ (void)trackEvent:(NSString *)event step:(NSInteger)step handler:(void (^)(NSUInteger count))handler {
    VIEventTracker *tracker = [VIEventTracker sharedTracker];
    
    VIETEvent *eventModel = tracker.trackData[event];
    if (!eventModel) {
        eventModel = [[VIETEvent alloc] init];
    }
    
    if (eventModel.isTracking) {
        eventModel.count += step;
        
        tracker.trackData[event] = eventModel;
        if (handler) {
            handler(eventModel.count);
        }
    }
}

+ (void)trackEvent:(NSString *)event handler:(void(^)(NSUInteger count))handler {
    [self trackEvent:event step:1 handler:handler];
}

+ (void)trackOnceEvent:(NSString *)event handler:(void(^)(NSUInteger count))handler {
    [self trackEvent:event handler:^(NSUInteger count) {
        [self stopTrackEvent:event];
        if (handler) {
            handler(count);
        }
    }];
}

+ (void)trackDifferentAppVersionWithHandler:(void(^)(NSUInteger count))handler {
    NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
    NSString *event = [NSString stringWithFormat:@"%@(%@)", infoPlist[@"CFBundleDisplayName"], infoPlist[@"CFBundleVersion"]];
    [self trackOnceEvent:event handler:handler];
}

+ (void)stopTrackEvent:(NSString *)event {
    VIEventTracker *tracker = [VIEventTracker sharedTracker];
    
    VIETEvent *eventModel = tracker.trackData[event];
    if (!eventModel) {
        eventModel = [[VIETEvent alloc] init];
    }
    
    eventModel.tracking = NO;
    tracker.trackData[event] = eventModel;
}

+ (void)resumeEvent:(NSString *)event {
    VIEventTracker *tracker = [VIEventTracker sharedTracker];
    
    VIETEvent *eventModel = tracker.trackData[event];
    if (eventModel && !eventModel.isTracking) {
        eventModel.tracking = YES;
        tracker.trackData[event] = eventModel;
    }
}

+ (void)resetEvent:(NSString *)event {
    VIEventTracker *tracker = [VIEventTracker sharedTracker];
    
    VIETEvent *eventModel = tracker.trackData[event];
    if (eventModel) {
        eventModel.tracking = YES;
        eventModel.count = 0;
        tracker.trackData[event] = eventModel;
    }
}

+ (BOOL)isTrackingEvent:(NSString *)event {
    VIETEvent *eventModel = [VIEventTracker sharedTracker].trackData[event];
    if (eventModel) {
        return eventModel.isTracking;
    }
    
    return NO;
}

+ (NSInteger)trackCountOfEvent:(NSString *)event {
    VIETEvent *eventModel = [VIEventTracker sharedTracker].trackData[event];
    if (eventModel) {
        return eventModel.count;
    }
    
    return 0;
}

+ (BOOL)synchronize {
    VIEventTracker *tracker = [VIEventTracker sharedTracker];
    if ([tracker.trackData isEqualToDictionary:tracker.orignTrackData]) {
        // Nothing changed, no need to save.
        return YES;
    }
    
    if ([NSKeyedArchiver archiveRootObject:tracker.trackData toFile:VI_TRACKER_FILE_PATH]) {
        NSLog(@"Tracker file saved.\n%@", tracker.trackData);
        return YES;
    } else {
        NSLog(@"Tracker file not save");
        return NO;
    }
}

#pragma mark - Notification

- (void)eventTrackerEnterBackground:(NSNotification *)notification {
    [VIEventTracker synchronize];
}

@end
