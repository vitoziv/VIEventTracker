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

/**
 *  Only track the event once, that means handler will invoked one time
 *
 *  @param event   Event name
 *  @param handler Your handler
 */
+ (void)trackOnceEvent:(NSString *)event handler:(void(^)(NSUInteger count))handler;

/**
 *  Each version of app will invoke the handler one time
 *
 *  @param handler Your handler
 */
+ (void)trackDifferentAppVersionWithHandler:(void(^)(NSUInteger count))handler;

/**
 *  Call this method will untrack the Event, that means the handler of `+ (void)trackEvent:(NSString *)event handler:(void(^)(NSUInteger count))handler;` will never be called.
 *
 *  @param event Event name
 */
+ (void)stopTrackEvent:(NSString *)event;

/**
 *  If event is stop then resume event.
 *
 *  @param event Event name
 */
+ (void)resumeEvent:(NSString *)event;

/**
 *  Reset event to original state
 *
 *  @param event Event name
 */
+ (void)resetEvent:(NSString *)event;

+ (BOOL)isTrackingEvent:(NSString *)event;

/**
 *  Writes any modifications to the persistent domains to disk and updates all unmodified persistent domains to what is on disk.
 *
 *  This method will call automically when app enter background
 *
 *  @return Synchronize success
 */
+ (BOOL)synchronize;

@end
