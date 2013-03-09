//
//  OutletPowerController.m
//  Home-Automation1
//
//  Created by Ben Gelsey on 3/3/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "OutletPowerController.h"
#import "AFNetworking.h"
#import "Outlet.h"
#import "TableViewSwitchCell.h"

@interface OutletPowerController ()

@end

@implementation OutletPowerController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
  [super viewDidLoad];

  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;
 
  // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
  //self.navigationItem.rightBarButtonItem = self.editButtonItem;
  
  self.masterOutletList = [[NSMutableArray alloc] init];
  
  NSURL *url = [NSURL URLWithString:@"http://localhost:9292/outlets.json"];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  static NSString *CellIdentifier = @"OutletPowerCell";
  

  TableViewSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  Outlet *outlet = [self.masterOutletList objectAtIndex:indexPath.row];
  [[cell cellLabel] setText:[outlet humanReadableOutletName]];
  if ([outlet.state boolValue]) {
    cell.cellSwitch.on = YES;
  } else {
    cell.cellSwitch.on = NO;
  }

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

-(void)onTableViewSwitchCellSwitchToggle:(id)sender cell:(TableViewSwitchCell *)cell {
  
  NSIndexPath* path = [self.tableView indexPathForCell:cell];
  Outlet* toggledOutlet = [self.masterOutletList objectAtIndex:path.row];
  
  UISwitch *switch_sender = (UISwitch *) sender;
  NSLog([NSString stringWithFormat:@"Outlet #%@ Power Switch Toggled to: %@", toggledOutlet.userOutletNumber, switch_sender.on ? @"YES" : @"NO"]);
  // Actually send this to back end here (Using outletId NOT userOutletNumber...!)
}

@end
