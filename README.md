#VIEventTracker

A simple way to handle special event at special time.

![TrackDemo.gif](http://i.imgur.com/pqtHBYJ.gif)

##Installation with CocoaPods

1. Add ``pod "VIEventTracker", "~> 0.1"`` to your Podfile
2. Run `pod install`

##How to use

Anywhere you want use VIEventTracker, simply add ``#import "VIEventTracker.h"``

###Track an event with a call back handler

**Simple Demo**

Track event with a call back.

```Objc
[VIEventTracker trackEvent:@"test" handler:^(NSUInteger times) {
    NSLog(@"count: %ld", (long)times);
}];
```

**Another demo**

Track a event, when this method called 3 times, do something you want.

```Objc
[VIEventTracker trackEvent:@"test" handler:^(NSUInteger times) {
    if (times == 3) {
        // Handle some special action when this event tracked 3 times
        //......
        NSLog("Already track 3 times, cool!!!");

        // Stop track the event when you complete track, then this block will never be called.
        [VIEventTracker stopTrackEvent:@"test"];
    }
}];
```

###Stop track event

```Objc
[VIEventTracker stopTrackEvent:@"test"];
```

Call this method will untrack the Event, that means the handler for the event will never be called.

---

##More

The event track status will be saved when app enter background. If you want to save the status immediately, you can call ``[VIEventTracker synchronize];``.

More other API see the ``VIEventTracker.h`` file.

##License

VIEventTracker is available under the MIT license. See the LICENSE file for more info.


