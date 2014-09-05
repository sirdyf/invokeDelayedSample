//
//  ViewController.m
//  testDelaySample
//
//  Created by user on 05.09.14.
//  Copyright (c) 2014 gaincode. All rights reserved.
//

#import "ViewController.h"
#import "Popup.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  [[Popup delayedInitializerForKey:@"key1"] method1];
  [[Popup delayedInitializerForKey:@"key2"] method3];
  [[Popup delayedInitializerForKey:@"key1"] method2];
  
  [[Popup delayedInitializerForKey:@"key2"] method2];
  [[Popup delayedInitializerForKey:@"key2"] method1];
  [[Popup delayedInitializerForKey:@"key1"] method3];
  
  Popup *p1 = [Popup new];
  [p1 setKey:@"key1"];

  Popup *p2 = [Popup new];
  [p2 setKey:@"key2"];

  [p1 showPopup];
  [p2 showPopup];
  
}
#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
