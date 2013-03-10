//
//  Schedule.h
//  Home-Automation1
//
//  Created by Ben Gelsey on 3/9/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Schedule : NSObject

@property (copy, nonatomic) NSNumber *scheduleId;
@property (copy, nonatomic) NSNumber *outletId;
@property (copy, nonatomic) NSNumber *userId;
@property (copy, nonatomic) NSNumber *day;
@property (copy, nonatomic) NSNumber *time;
@property (copy, nonatomic) NSNumber *state;



-(id)initWithScheduleId:(NSNumber *)scheduleId outletId:(NSNumber *)outletId userId:(NSNumber *)userId day:(NSNumber *)day time:(NSNumber *)time state:(NSNumber *)state;

-(NSString *)humanReadableScheduleTime;
+(NSNumber *)machineReadableScheduleTime:(NSString *)humanTime;
@end
