//
//  EventLoggerTest.m
//  EventLoggerDemo
//
//  Created by YourtionGuo on 1/28/15.
//  Copyright (c) 2015 GYX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "EventLogger.h"

@interface EventLoggerTest : XCTestCase
@property (nonatomic, strong)EventLogger *logger;
@end
#define C1 @"C1"
#define C2 @"C2"
#define C3 @"C3"
#define T1 @"T1"
#define T2 @"T2"
#define T3 @"T3"
#define T4 @"T4"

@implementation EventLoggerTest

- (void)setUp {
    [super setUp];
    _logger = [EventLogger sharedInstance];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)testCleanAll {
    [_logger addCountEventWithTag:C1];
    [_logger startTimeEventWithTag:T1 andInfo:nil];
    [_logger cleanAll];
    XCTAssertEqual([_logger.countEventList count], 0);
    XCTAssertEqual([_logger.timeEventList count], 0);
}

- (void)testGetEventArray{
    [_logger startTimeEventWithTag:T1 andInfo:nil];
    NSArray *a = [_logger getEventArray];
    XCTAssertEqual([a count], 1);
    NSDictionary *d = a[0];
    XCTAssertEqual([d objectForKey:@"event"], T1);
}

-(void)testAddCountEventWithTag{
    [_logger cleanAll];
    [_logger addCountEventWithTag:C1];
    XCTAssertEqual([[_logger.countEventList objectForKey:C1] intValue], 1);
    
    [_logger addCountEventWithTag:C1];
    [_logger addCountEventWithTag:C2];
    [_logger addCountEventWithTag:C1];
    XCTAssertEqual([[_logger.countEventList objectForKey:C1] intValue], 3);
    XCTAssertEqual([[_logger.countEventList objectForKey:C2] intValue], 1);
}

-(void)testTimeEventWithTag{
    [_logger cleanAll];
    XCTAssertEqualObjects([_logger.timeEventList objectForKey:T1], nil);
    
    [_logger startTimeEventWithTag:T1 andInfo:nil];
    XCTAssertNotEqualObjects([_logger.timeEventList objectForKey:T1], nil);
    
    [_logger addTimeEventPoint:C1 withTag:T1 andInfo:nil timeFromPoint:nil];
    XCTAssertGreaterThan([[[_logger.timeEventList objectForKey:T1] objectForKey:C1] floatValue],0);
    
    [_logger addTimeEventPoint:C2 withTag:T1 andInfo:nil timeFromPoint:C1];
    [_logger addTimeEventPoint:C3 withTag:T1 andInfo:nil timeFromPoint:nil];
    XCTAssertLessThan([[[_logger.timeEventList objectForKey:T1] objectForKey:C2] floatValue],
                      [[[_logger.timeEventList objectForKey:T1] objectForKey:C3] floatValue]);
}

-(void)testTimeEventWithTagAndInfo{
    [_logger cleanAll];
    XCTAssertEqualObjects([_logger.timeEventList objectForKey:T1], nil);
    
    [_logger startTimeEventWithTag:T1 andInfo:@{T1: C1}];
    XCTAssertEqual([[_logger.timeEventList objectForKey:T1] containsObject:C1], YES);
    
    [_logger addTimeEventPoint:C1 withTag:T1 andInfo:@{T2: C2} timeFromPoint:nil];
    XCTAssertEqualObjects([[_logger.timeEventList objectForKey:T1] objectForKey:T2], C2);
    XCTAssertEqual([[_logger.timeEventList objectForKey:T1] containsObject:C2], YES);
    
    [_logger addTimeEventPoint:C2 withTag:T1 andInfo:@{T3: T1} timeFromPoint:C1];
    [_logger addTimeEventPoint:C3 withTag:T1 andInfo:@{T4: T2} timeFromPoint:nil];
    XCTAssertEqual([[[_logger.timeEventList objectForKey:T1] allKeys] count],7);
}

@end
