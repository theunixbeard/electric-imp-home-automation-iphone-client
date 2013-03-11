//
//  globalAppDataSingleton.m
//  Home-Automation1
//
//  Created by Ben Gelsey on 3/10/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "GlobalAppDataSingleton.h"
#import "AFNetworking.h"
#include "Outlet.h"

@implementation GlobalAppDataSingleton

+(GlobalAppDataSingleton *)globalAppDataSingleton {
  
  static GlobalAppDataSingleton * single=nil;
  
  @synchronized(self)
  {
    if(!single)
    {
      single = [[GlobalAppDataSingleton alloc] init];
    }
  }
  return single;
}

-(void)initMasterOutletListFromBackendAndUpdateTable:(UITableView *)tableView {
  self.urlBase = [NSURL URLWithString:@"http://ec2-184-169-233-178.us-west-1.compute.amazonaws.com/"];
  //self.urlBase = [NSURL URLWithString:@"http://localhost:9292/"];
  if (self.masterOutletList == nil){
    self.masterOutletList = [[NSMutableArray alloc] init];
    [self refreshMasterOutletListFromBackendAndUpdateTable:tableView];
  }
}

-(void)refreshMasterOutletListFromBackendAndUpdateTable:(UITableView *)tableView {
  NSURL *url = [NSURL URLWithString:@"/outlets.json" relativeToURL:self.urlBase];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  AFJSONRequestOperation *operation;
  operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                              success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                NSLog(@"ViewDidLoad OutletPowerController Success");
                                                                //NSLog(@"Response: %@", JSON);
                                                                for (NSDictionary *jsonDict in JSON) {
                                                                  [self.masterOutletList addObject:[[Outlet alloc]
                                                                                                    initWithOutletId:[jsonDict objectForKey:@"id"]
                                                                                                    userOutletNumber:[jsonDict objectForKey:@"user_outlet_number"]
                                                                                                    userOutletName:[jsonDict objectForKey:@"user_outlet_name"]
                                                                                                    state:[jsonDict objectForKey:@"state"]
                                                                                                    overrideActive:[jsonDict objectForKey:@"override_active"]
                                                                                                    userId:[jsonDict objectForKey:@"user_id"]]];
                                                                }
                                                                [tableView reloadData];
                                                              } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                NSLog(@"Received an HTTP %d", response.statusCode);
                                                                NSLog(@"The error was: %@", error);
                                                              }];
  [operation start];
}



@end
