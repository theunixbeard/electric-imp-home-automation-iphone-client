//
//  Schedule.m
//  Home-Automation1
//
//  Created by Ben Gelsey on 3/9/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "Schedule.h"

@implementation Schedule

-(id)initWithScheduleId:(NSNumber *)scheduleId outletId:(NSNumber *)outletId userId:(NSNumber *)userId day:(NSNumber *)day time:(NSNumber *)time state:(NSNumber *)state {
  
  self = [super init];
  if(self) {
    _scheduleId = scheduleId;
    _outletId = outletId;
    _userId = userId;
    _day = day;
    _time = time;
    _state = state;
    return self;
  }
  return nil;}

-(NSString *)humanReadableScheduleTime {
  
  int hour = [self.time integerValue] / 4;
  int minute = ([self.time integerValue] % 4) * 15;
  NSString *modifier = @"am";
  if (hour == 0){
    hour = 12;
  }else if(hour > 12){
    hour = hour % 12;
    modifier = @"pm";
  }
  return [NSString stringWithFormat:@"%d:%02d%@", hour, minute, modifier];
}

+(NSNumber *)machineReadableScheduleTime:(NSString *)humanTime {
  NSArray *timeComponents = [humanTime componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@": "]];
  int timeTotal = [[timeComponents objectAtIndex:0] intValue] * 4;
  timeTotal += [[timeComponents objectAtIndex:1] intValue] / 15;
  if ([[timeComponents objectAtIndex:0] isEqualToString:@"12"]) {
    timeTotal -= 48;
  }
  if ([[timeComponents objectAtIndex:2] isEqualToString:@"PM"]) {
    timeTotal += 48;
  }
  return [NSNumber numberWithInt:timeTotal];
}

@end
