//
//  AddScheduleController.h
//  Home-Automation1
//
//  Created by Ben Gelsey on 3/9/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Schedule.h"
#import "Outlet.h"

@interface AddScheduleController : UIViewController  <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) Schedule *schedule;
@property (strong, nonatomic) Outlet *outlet;

@end
