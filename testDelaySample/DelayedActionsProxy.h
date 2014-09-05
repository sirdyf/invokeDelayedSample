//
//  DelayedActionsProxy.h
//  testDelaySample
//
//  Created by user on 05.09.14.
//  Copyright (c) 2014 gaincode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PopupProtocol.h"

@class Popup;

@interface DelayedActionsProxy : NSProxy <PopupProtocol>
+ (void) invokeDelayedInvocationsWithTarget:(Popup *)target;
+ (instancetype) sharedProxyForKey:(NSString *)key fromClass:(Class )objectClass;

@end
