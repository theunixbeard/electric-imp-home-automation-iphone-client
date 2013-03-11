//
//  OutletSettingsDetailController.m
//  Home-Automation1
//
//  Created by Ben Gelsey on 3/8/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "OutletSettingsDetailController.h"
#import "OutletRenameController.h"
#import "OutletScheduleController.h"
#import "AFNetworking.h"

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
  if ([self.outlet.overrideActive boolValue]) {
    self.outletScheduleSwitch.on = NO;
  } else {
    self.outletScheduleSwitch.on = YES;
  }
  
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)outletScheduleValueChanged:(id)sender {
  UISwitch *switch_sender = (UISwitch *) sender;
  // Actually send this to back end here and update the model
  NSNumber *switchValue = switch_sender.on ? [NSNumber numberWithInt:1] : [NSNumber numberWithInt:0];
  self.outlet.overrideActive = switch_sender.on ? [NSNumber numberWithInt:0] : [NSNumber numberWithInt:1];
  NSURL *urlBase = [NSURL URLWithString:@"http://localhost:9292/"];
  NSString *urlRelative = [NSString stringWithFormat:@"/outlets/%@/schedule-toggle", self.outlet.outletId];
  
  AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:urlBase];
  NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                          switchValue, @"value",
                          nil];
  [httpClient postPath:urlRelative parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    NSLog(@"Request Successful, response '%@'", responseStr);
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
  }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
  if([segue.identifier isEqualToString:@"RenameSegue"]){
    OutletRenameController *controller = [segue destinationViewController];
    controller.outlet = self.outlet;
  } else if ([segue.identifier isEqualToString:@"ScheduleSegue"]){
    OutletScheduleController *controller = [segue destinationViewController];
    controller.outlet = self.outlet;
  }
}

- (IBAction)unwindFromRename:(UIStoryboardSegue *)segue {
  if([[segue identifier] isEqualToString:@"unwindFromRename"]) {
    OutletRenameController *controller = [segue sourceViewController];
    if (![controller.renameOutletTextField.text isEqualToString:@""]) {
      self.navigationItem.title = controller.renameOutletTextField.text;
    }
  }
}

@end
