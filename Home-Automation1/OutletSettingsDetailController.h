//
//  OutletSettingsDetailController.h
//  Home-Automation1
//
//  Created by Ben Gelsey on 3/8/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Outlet.h"
#import "GlobalAppDataSingleton.h"

@interface OutletSettingsDetailController : UITableViewController

@property (nonatomic, strong) GlobalAppDataSingleton *appData;
@property (strong, nonatomic) Outlet *outlet;
@property (weak, nonatomic) IBOutlet UISwitch *outletScheduleSwitch;
- (IBAction)outletScheduleValueChanged:(id)sender;

@end
