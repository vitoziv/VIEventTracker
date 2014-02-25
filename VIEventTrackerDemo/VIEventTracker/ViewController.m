//
//  ViewController.m
//  VIEventTracker
//
//  Created by Vito on 1/26/14.
//  Copyright (c) 2014 Vito. All rights reserved.
//

#import "ViewController.h"
#import "VIEventTracker.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [VIEventTracker trackEvent:@"test" handler:^(NSUInteger times) {
        NSLog(@"count: %ld", (long)times);
    }];
    
    [VIEventTracker stopTrackEvent:@"test"];
    
    if ([VIEventTracker isTrackingEvent:@"test"]) {
        NSLog(@"is Tracking Event");
    } else {
        NSLog(@"not tracking Event");
    }
    
    [VIEventTracker trackAppVersionWithHandler:^(NSUInteger count) {
        NSLog(@"trackDifferentAppVersionWithResult count: %ld", (long)count);
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
