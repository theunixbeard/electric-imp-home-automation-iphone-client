//
//  Outlet.m
//  Home-Automation1
//
//  Created by Ben Gelsey on 3/7/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "Outlet.h"

@implementation Outlet

-(id)initWithoutletId:(NSNumber *)outletId userOutletNumber:(NSNumber *)userOutletNumber userOutletName:(NSString *)userOutletName state:(NSNumber *)state overrideActive:(NSNumber *)overrideActive userId:(NSNumber *)userId {
  
  self = [super init];
  if(self) {
    _outletId = outletId;
    _userOutletNumber = userOutletNumber;
    _userOutletName = userOutletName;
    _state = state;
    _overrideActive = overrideActive;
    _userId = userId;
    return self;
  }
  return nil;
}

-(NSString *)humanReadableOutletName {
  if (self.userOutletName == (id)[NSNull null] || self.userOutletName.length == 0) {
    return [NSString stringWithFormat:@"Outlet #%@", self.userOutletNumber];
  }else { // Outlet name NOT null
    return self.userOutletName;
  }
}

@end
