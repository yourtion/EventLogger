//
//  ViewController.m
//  EventLoggerDemo
//
//  Created by YourtionGuo on 1/28/15.
//  Copyright (c) 2015 GYX. All rights reserved.
//

#import "ViewController.h"
#import "EventLogger.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[EventLogger sharedInstance] addCountEventWithTag:@"viewDidLoad"];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cleanAll:(id)sender {
    [[EventLogger sharedInstance] cleanAll];
}
- (IBAction)printAll:(id)sender {
    NSLog(@"timeEventList: %@", [EventLogger sharedInstance].timeEventList);
    NSLog(@"countEventList: %@", [EventLogger sharedInstance].countEventList);
    NSLog(@"timeEventArray: %@", [[EventLogger sharedInstance] getEventArray]);
}
- (IBAction)addCount1:(id)sender {
    [[EventLogger sharedInstance] addCountEventWithTag:@"EventCount1"];
}
- (IBAction)addCount2:(id)sender {
    [[EventLogger sharedInstance] addCountEventWithTag:@"EventCount2"];
}

- (IBAction)e1:(id)sender {
    [[EventLogger sharedInstance] startTimeEventWithTag:@"TimeEven1" andInfo:@{@"file1":@"111"}];
}
- (IBAction)e12:(id)sender {
    [[EventLogger sharedInstance] addTimeEventPoint:@"e12" withTag:@"TimeEven1" andInfo:@{@"file2":@"22222"} timeFromPoint:nil];
}
- (IBAction)e13:(id)sender {
    [[EventLogger sharedInstance] addTimeEventPoint:@"e13" withTag:@"TimeEven1" andInfo:nil timeFromPoint:@"e12"];
}

- (IBAction)e2:(id)sender {
    [[EventLogger sharedInstance] startTimeEventWithTag:@"TimeEven2" andInfo:nil];
}
- (IBAction)e21:(id)sender {
    [[EventLogger sharedInstance] addTimeEventPoint:@"op1" withTag:@"TimeEven2" andInfo:@{@"file2":@"22222"} timeFromPoint:nil];
}
- (IBAction)e22:(id)sender {
    [[EventLogger sharedInstance] addTimeEventPoint:@"sacn" withTag:@"TimeEven2" andInfo:@{@"info":@"22222"} timeFromPoint:nil];
}
- (IBAction)e23:(id)sender {
    [[EventLogger sharedInstance] addTimeEventPoint:@"network" withTag:@"TimeEven2" andInfo:nil timeFromPoint:@"sacn"];
}

@end
