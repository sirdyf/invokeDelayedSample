//
//  DelayedActionsProxy.m
//  testDelaySample
//
//  Created by user on 05.09.14.
//  Copyright (c) 2014 gaincode. All rights reserved.
//

#import "DelayedActionsProxy.h"
#import "Popup.h"

@interface DelayedActionsProxy()
/* ключ нас интересует для разделения поступающих в прокси отложенных вызовов по разным объектам, а класс объекта - для корректного построения сигнатуры вызова */
@property (nonatomic, strong) NSString *currentKey;
@property (nonatomic, assign) Class currentClass;
@property (nonatomic, strong) NSMutableDictionary *delayedInvocations;
@end

@implementation DelayedActionsProxy

-(instancetype) init
{
  self.delayedInvocations = [NSMutableDictionary new];
  return self;
}

static DelayedActionsProxy *proxy = nil;
+(instancetype) sharedProxyForKey:(NSString*)key fromClass:(Class)objectClass
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    proxy = [[self alloc] init];
  });
  proxy.currentKey = key;
  proxy.currentClass = objectClass;
  return proxy;
}

/* Предполагается использование класса в виде [[Popup delayedInitializerForKey:@"key"] setText:@"someText"], то есть к моменту вызова - еще не существует вызываемого объекта, и уже заполнятся поля currentKey и currentClass */

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
  /* Так как currentClass представляет собой класс, а не объект, мы должны воспользоваться методом instanceMethodSignature вместо methodSignature */
  return [self.currentClass instanceMethodSignatureForSelector:selector];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
  if (!self.delayedInvocations[self.currentKey])
  {
    self.delayedInvocations[self.currentKey] = [NSMutableArray new];
  }
  /* мы не форвардим получаемые сообщения, а аккуратненько их складываем */
  [self.delayedInvocations[self.currentKey] addObject:invocation];
}

/* чтобы вызвать их по требованию */
+ (void) invokeDelayedInvocationsWithTarget:(Popup *)target {
  for (NSInvocation *invocation in proxy.delayedInvocations[target.key])//proxy.currentKey])
  {
    [invocation invokeWithTarget:target];
  }
  [proxy.delayedInvocations removeObjectForKey:target.key];//proxy.currentKey];
}

@end

