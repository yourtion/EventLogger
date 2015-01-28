//
//  EventLogger.m
//  EventLoggerrDemo
//
//  Created by YourtionGuo on 1/28/15.
//  Copyright (c) 2015 GYX. All rights reserved.
//

#import "EventLogger.h"

@interface EventLogger()
@property(strong, nonatomic, readwrite) NSMutableDictionary *countEventList;
@property(strong, nonatomic) NSMutableDictionary *timeList;
@property(strong, nonatomic, readwrite) NSMutableDictionary *timeEventList;
@end

@implementation EventLogger
+ (EventLogger *)sharedInstance
{
    static EventLogger*_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[EventLogger alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.countEventList = [[NSMutableDictionary alloc]init];
        self.timeList = [[NSMutableDictionary alloc]init];
        self.timeEventList = [[NSMutableDictionary alloc]init];
    }
    return self;
}

- (void)cleanAll
{
    [_countEventList removeAllObjects];
    [_timeList removeAllObjects];
    [_timeEventList removeAllObjects];
}

- (void)addCountEventWithTag:(NSString *)tag
{
    NSNumber *count = [_countEventList objectForKey:tag];
    if (count) {
        NSInteger number = [count integerValue];
        number+=1;
        [_countEventList setObject:[NSNumber numberWithInteger:number] forKey:tag];
    }else{
        [_countEventList setObject:[NSNumber numberWithInteger:1] forKey:tag];
    }
}

- (void)startTimeEventWithTag:(NSString *)tag andInfo:(NSDictionary *)info
{
    [_timeList setObject:[NSDate date] forKey:tag];
    NSMutableDictionary *allInfo = [[NSMutableDictionary alloc]initWithDictionary:[_timeEventList objectForKey:tag] copyItems:YES];
    [allInfo addEntriesFromDictionary:info];
    [_timeEventList setObject:allInfo forKey:tag];
}

- (void)addTimeEventPoint:(NSString *)point withTag:(NSString *)tag andInfo:(NSDictionary *)info timeFromPoint:(NSString *)fromPoint
{
    [_timeList setObject:[NSDate date] forKey:[NSString stringWithFormat:@"%@_%@",tag, point]];
    NSMutableDictionary *allInfo = [[NSMutableDictionary alloc]initWithDictionary:[_timeEventList objectForKey:tag] copyItems:YES];
    [allInfo addEntriesFromDictionary:info];
    if (fromPoint) {
        NSNumber *time = [NSNumber numberWithDouble:[[NSDate date] timeIntervalSinceDate:[_timeList objectForKey:[NSString stringWithFormat:@"%@_%@",tag, fromPoint]]]];
        [allInfo setObject:time forKey:point];
    }else{
        NSNumber *time = [NSNumber numberWithDouble:[[NSDate date] timeIntervalSinceDate:[_timeList objectForKey:tag]]];
        [allInfo setObject:time forKey:point];
    }
    [_timeEventList setObject:allInfo forKey:tag];
}

-(NSArray *)getEventArray
{
    NSMutableArray *event = [[NSMutableArray alloc]init];
    for (id akey in [_timeEventList allKeys]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:[_timeEventList objectForKey:akey]];
        [dic setObject:akey forKey:@"event"];
        [event addObject:dic];
    }
    return event;
}
@end
