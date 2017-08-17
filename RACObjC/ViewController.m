//
//  ViewController.m
//  RACObjC
//
//  Created by Markus Chmelar on 16/08/2017.
//  Copyright © 2017 Innovaptor OG. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface ViewController()
@property (weak) IBOutlet NSButton *button;
@property(nonatomic, strong) RACSubject *origin;
@property(nonatomic)NSInteger number;
@end

@implementation ViewController

- (IBAction)buttonPress:(id)sender {
  [self.origin sendNext:@(self.number++)];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.origin= [RACSubject subject];
  
    RACSignal* CS1 = [self.origin map:^id _Nullable(NSNumber * _Nullable value) {
      return value;
    }];
  
    RACSignal *filtered = [self.origin filter:^BOOL(NSNumber * _Nullable value) {
      return (value.integerValue % 2) == 0;
    }];
  
    RACSignal *delayed = [filtered flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
      // Build a new signal that returns just this one value,
      // but delayed and only if no event arrives on CS1
      return [[[RACSignal return:value]
               delay:3]
              takeUntil:CS1];
    }];
  
    RACSignal* CS2 = [delayed map:^id _Nullable(NSNumber * _Nullable value) {
      return @(-value.integerValue);
    }] ;
  
  
    RACSignal* CS3 = [RACSignal merge:@[CS1, CS2]];
  
  [CS3 subscribeNext:^(id  _Nullable x) {
    NSLog(@"Next: %@", x);
  }];
}


- (void)setRepresentedObject:(id)representedObject {
  [super setRepresentedObject:representedObject];
  
  // Update the view, if already loaded.
}


@end
