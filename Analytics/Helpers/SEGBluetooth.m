//
//  SIOBluetooth.m
//  Analytics
//
//  Created by Travis Jeffery on 4/23/14.
//  Copyright (c) 2014 Segment.io. All rights reserved.
//

#import "SEGBluetooth.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface SEGBluetooth () <CBCentralManagerDelegate>

@property (nonatomic, strong) CBCentralManager *manager;
@property (nonatomic, strong) dispatch_queue_t queue;

@end

@implementation SEGBluetooth

- (id)init {
  if (![CBCentralManager class]) return nil;
  if (!(self = [super init])) return nil;

  _queue = dispatch_queue_create("io.segment.bluetooth.queue", NULL);

  if ([CBCentralManager instancesRespondToSelector:@selector(initWithDelegate:queue:options:)]) {
    _manager = [[CBCentralManager alloc] initWithDelegate:self queue:_queue options:@{ CBCentralManagerOptionShowPowerAlertKey: @NO }];
  } else {
    _manager = [[CBCentralManager alloc] initWithDelegate:self queue:_queue];
  }

  return self;
}

- (BOOL)hasKnownState {
    return _manager && (_manager.state != CBCentralManagerStateUnknown);
}

- (BOOL)isEnabled {
    return _manager.state == CBCentralManagerStatePoweredOn;
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {}

@end
