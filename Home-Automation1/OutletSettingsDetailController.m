//
//  OutletSettingsDetailController.m
//  Home-Automation1
//
//  Created by Ben Gelsey on 3/8/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "OutletSettingsDetailController.h"

@interface OutletSettingsDetailController ()

@end

@implementation OutletSettingsDetailController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
  
  self.navigationItem.title = [self.outlet humanReadableOutletName];
  if ([self.outlet.state boolValue]) {
    self.outletScheduleSwitch.on = YES;
  } else {
    self.outletScheduleSwitch.on = NO;
  }
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)outletScheduleValueChanged:(id)sender {
  UISwitch *switch_sender = (UISwitch *) sender;
  NSLog([NSString stringWithFormat:@"Outlet #%@ Schedule Enable Switch Toggled to: %@", self.outlet.userOutletNumber,switch_sender.on ? @"YES" : @"NO"]);
  // Actually send this to back end here

}
@end
