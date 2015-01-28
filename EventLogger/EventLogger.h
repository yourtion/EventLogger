//
//  EventLogger.h
//  EventLoggerrDemo
//
//  Created by YourtionGuo on 1/28/15.
//  Copyright (c) 2015 GYX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventLogger : NSObject
@property(strong, readonly) NSMutableDictionary *countEventList;
@property(strong, readonly) NSMutableDictionary *timeEventList;

/**
 *  EventLogger sharedInstance
 *
 *  @return EventLogger
 */
+ (EventLogger *)sharedInstance;

/**
 *  Clean all logs
 */
- (void)cleanAll;

/**
 *  Get all evets array
 *
 *  @return Event array
 */
- (NSArray *)getEventArray;

/**
 *  Add counts to a count event with tag
 *
 *  @param tag Event tag to identify an event
 */
- (void)addCountEventWithTag:(NSString *)tag;

/**
 *  Start a time event
 *
 *  @param tag  Event tag to identify an event
 *  @param info Addtion info dictionary
 */
- (void)startTimeEventWithTag:(NSString *)tag andInfo:(NSDictionary *)info;

/**
 *  Add a time point to time event with tag
 *
 *  @param point     Event point to identify an event check point
 *  @param tag       Event tag to identify an event
 *  @param info      Addtion info dictionary
 *  @param fromPoint Is event time count from a particular event point
 */
- (void)addTimeEventPoint:(NSString *)point withTag:(NSString *)tag andInfo:(NSDictionary *)info timeFromPoint:(NSString *)fromPoint;
@end
