//
//  Outlet.h
//  Home-Automation1
//
//  Created by Ben Gelsey on 3/7/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Outlet : NSObject


@property (copy, nonatomic) NSNumber *outletId;
@property (copy, nonatomic) NSNumber *userOutletNumber;
@property (copy, nonatomic) NSString *userOutletName;
@property (copy, nonatomic) NSNumber *state;
@property (copy, nonatomic) NSNumber *overrideActive;
@property (copy, nonatomic) NSNumber *userId;

-(id)initWithOutletId:(NSNumber *)outletId userOutletNumber:(NSNumber *)userOutletNumber userOutletName:(NSString *)userOutletName state:(NSNumber *)state overrideActive:(NSNumber *)overrideActive userId:(NSNumber *)userId;

-(NSString *)humanReadableOutletName;

@end
