//
//  OutletScheduleController.h
//  Home-Automation1
//
//  Created by Ben Gelsey on 3/8/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Outlet.h"

@interface OutletScheduleController : UITableViewController

@property (nonatomic, strong) NSMutableArray *masterScheduleList; // A 2D array, w/ 7 rows, 1 for each day of the week
@property (strong, nonatomic) Outlet *outlet;

@end
