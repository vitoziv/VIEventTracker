//
//  VIETEvent.h
//  VIEventTracker
//
//  Created by Vito on 1/26/14.
//  Copyright (c) 2014 Vito. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VIETEvent : NSObject <NSCoding>

@property (nonatomic) NSInteger count;
@property (nonatomic, getter = isTracking) BOOL tracking;

@end
