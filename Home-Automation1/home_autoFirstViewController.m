//
//  home_autoFirstViewController.m
//  Home-Automation1
//
//  Created by Ben Gelsey on 3/3/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "home_autoFirstViewController.h"
#import "AFNetworking.h"


@interface home_autoFirstViewController ()

@end

@implementation home_autoFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  // Or make any internet requests to populate w/ dynamically generated data!!
  self.testLabel1.text = @"WOOHOO";
  NSURL *url = [NSURL URLWithString:@"http://localhost:9292/test.json"];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  AFJSONRequestOperation *operation;
  operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                              success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                NSLog(@"Response: %@", JSON);
                                                              } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                NSLog(@"Received an HTTP %d", response.statusCode);
                                                                NSLog(@"The error was: %@", error);
                                                              }];
  [operation start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
