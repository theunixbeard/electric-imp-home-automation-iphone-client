//
//  OutletRenameController.m
//  Home-Automation1
//
//  Created by Ben Gelsey on 3/8/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "OutletRenameController.h"
#import "AFNetworking.h"

@interface OutletRenameController ()

@end

@implementation OutletRenameController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
  self.navigationItem.title = [NSString stringWithFormat:@"Rename Outlet #%i",
                               [self.outlet.userOutletNumber integerValue] + 1];
  self.oldOutletLabel.text = [NSString stringWithFormat:@"Old Name: %@", [self.outlet humanReadableOutletName]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)renameOutlet:(id)sender {
  NSLog(@"Outlet #%@ Renamed to: %@", self.outlet.userOutletNumber, self.renameOutletTextField.text);
  // Send to back end and update model
  NSURL *urlBase = [NSURL URLWithString:@"http://localhost:9292/"];
  NSString *urlRelative = [NSString stringWithFormat:@"/outlets/%@/rename", self.outlet.outletId];
  
  AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:urlBase];
  NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                          self.renameOutletTextField.text, @"name",
                          nil];
  [httpClient postPath:urlRelative parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    NSLog(@"Request Successful, response '%@'", responseStr);
    if(![responseStr isEqualToString:@"bad name"]) {
      self.outlet.userOutletName = responseStr; 
    }
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
  }];
  
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
  if (theTextField == self.renameOutletTextField) {
    [theTextField resignFirstResponder];
  }
  return YES;
}
@end
