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



/**
 *  Track event with a call back handler.
 *
 *  @param event   Event name
 *  @param handler Call back handler
 */
+ (void)trackEvent:(NSString *)event handler:(void(^)(NSUInteger count))handler;
+ (void)trackEvent:(NSString *)event step:(NSInteger)step handler:(void (^)(NSUInteger count))handler;

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
 *  Call this method will untrack the Event, that means the handler for the event will never be called.
 *  @code 
 *  // Invoke this method will not call the handler block
 *  + (void)trackEvent:(NSString *)event 
 *             handler:(void(^)(NSUInteger count))handler;
 *
 *  @endcode
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
 *  Call this method will untrack the Event, that means the handler for the event will not be called until next launch or unlock event.
 *  @code 
 *  // Invoke this method will not call the handler block
 *  + (void)trackEvent:(NSString *)event 
 *             handler:(void(^)(NSUInteger count))handler;
 *
 *  @endcode
 *
 *  @param event Event name
 */
+ (void)lockTrackEvent:(NSString *)event;

/**
 *  If event is lock then unlock event.
 *
 *  @param event Event name
 */
+ (void)unlockEvent:(NSString *)event;

/**
 *  Reset event to original state
 *
 *  @param event Event name
 */
+ (void)resetEvent:(NSString *)event;

/**
 Clean all data
 */
+ (void)removeAllEvent;
+ (void)removeEvent:(NSString *)event;

+ (BOOL)isTrackingEvent:(NSString *)event;
+ (NSInteger)trackCountOfEvent:(NSString *)event;


/**
 *  Writes any modifications to the persistent domains to disk and updates all unmodified persistent domains to what is on disk.
 *
 *  This method will call automically when app enter background
 *
 *  @return Synchronize success
 */
+ (BOOL)synchronize;

@end
