//
//  OutletSettingsController.m
//  Home-Automation1
//
//  Created by Ben Gelsey on 3/8/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "OutletSettingsMasterController.h"
#import "AFNetworking.h"
#import "Outlet.h"
#import "OutletSettingsDetailController.h"

@interface OutletSettingsMasterController ()

@end

@implementation OutletSettingsMasterController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
  NSLog(@"ViewDidLoad OutletSettingsController");
  [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
  
  self.masterOutletList = [[NSMutableArray alloc] init];
  
  NSURL *url = [NSURL URLWithString:@"http://localhost:9292/outlets.json"];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  AFJSONRequestOperation *operation;
  operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                              success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                NSLog(@"ViewDidLoad OutletSettingsController Success");
                                                                //NSLog(@"Response: %@", JSON);
                                                                for (NSDictionary *jsonDict in JSON) {
                                                                  [self.masterOutletList addObject:[[Outlet alloc]
                                                                                                    initWithoutletId:[jsonDict objectForKey:@"id"]
                                                                                                    userOutletNumber:[jsonDict objectForKey:@"user_outlet_number"]
                                                                                                    userOutletName:[jsonDict objectForKey:@"user_outlet_name"]
                                                                                                    state:[jsonDict objectForKey:@"state"]
                                                                                                    overrideActive:[jsonDict objectForKey:@"override_active"]
                                                                                                    userId:[jsonDict objectForKey:@"user_id"]]];
                                                                }
                                                                [self.tableView reloadData];
                                                                
                                                              } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                                NSLog(@"Received an HTTP %d", response.statusCode);
                                                                NSLog(@"The error was: %@", error);
                                                              }];
  [operation start];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.masterOutletList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"OutletSettingsCell";
  
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  Outlet *outlet = [self.masterOutletList objectAtIndex:indexPath.row];
  [[cell textLabel] setText:[outlet humanReadableOutletName]];
  
  return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
  if([segue.identifier isEqualToString:@"ShowDetailSegue"]){
    OutletSettingsDetailController *controller = [segue destinationViewController];
    controller.outlet = [self.masterOutletList objectAtIndex:[self.tableView indexPathForSelectedRow].row];
  }
}

@end
