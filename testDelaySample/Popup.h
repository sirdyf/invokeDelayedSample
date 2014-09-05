//
//  Popup.h
//  testDelaySample
//
//  Created by user on 05.09.14.
//  Copyright (c) 2014 gaincode. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DelayedActionsProxy.h"
#import "PopupProtocol.h"

/* Обычное всплывающее окно, которое показывает сообщение. */
@interface Popup : NSObject <PopupProtocol>
/* Ключ необходим для того, чтобы можно было разделять, какие отложенные сообщения кто обрабатывает */
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *message;

/* мы не будем напрямую обращаться к прокси, обращаясь к нему только в контексте создаваемых объектов, как и в случае UIAppearance */
+ (DelayedActionsProxy *)delayedInitializerForKey:(NSString *)key;
/* Показать всплывающее окошко. Собственно это место и является точкой, когда будут применены отложенные настройки */
- (void)showPopup;
@end