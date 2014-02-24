//
//  VIEventTracker.h
//  VIEventTracker
//
//  Created by Vito on 1/26/14.
//  Copyright (c) 2014 Vito. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VIEventTracker : NSObject

+ (instancetype)sharedTracker;

+ (void)trackEvent:(NSString *)event handler:(void(^)(NSUInteger count))handler;
+ (void)trackOnceEvent:(NSString *)event handler:(void(^)(NSUInteger count))handler;
+ (void)trackAppVersionWithHandler:(void(^)(NSUInteger count))handler;

+ (void)untrackEvent:(NSString *)event;

/**
 *  Restart track event. Simplely set tracking = YES
 *
 *  @param event
 */
+ (void)retrackEvent:(NSString *)event;

/**
 *  Reset event count = 0, tracking = YES
 *
 *  @param event
 */
+ (void)resetEvent:(NSString *)event;

+ (BOOL)isTrackingEvent:(NSString *)event;

@end
