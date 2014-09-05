//
//  Popup.m
//  testDelaySample
//
//  Created by user on 05.09.14.
//  Copyright (c) 2014 gaincode. All rights reserved.
//

#import "Popup.h"

#define NSLog(FORMAT, ...) printf("%s [Line %d][mt:%d] %s %s\n", [[[NSDate date] description] UTF8String], __LINE__ , [NSThread isMainThread]?1:0 ,__PRETTY_FUNCTION__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])

@implementation Popup

- (void)showPopup {
  [DelayedActionsProxy invokeDelayedInvocationsWithTarget:self];
  NSLog(@"Popup %@ Showing!!",_key);
  /*...*/
}

+(DelayedActionsProxy*) delayedInitializerForKey:(NSString*)key {
  return [DelayedActionsProxy sharedProxyForKey:key fromClass:[self class]];
}
#pragma mark -
- (void)method1 { NSLog(@"."); }
- (void)method2 { NSLog(@"."); }
- (void)method3 { NSLog(@"."); }

@end