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

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.tableView reloadData];
}

- (void)viewDidLoad{
  [super viewDidLoad];
  
  //Tab bar delegate setup
  [self tabBarController].delegate = self;
  
  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;
 
  // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
  //self.navigationItem.rightBarButtonItem = self.editButtonItem;
  
  self.appData = [GlobalAppDataSingleton globalAppDataSingleton];
  [self.appData initMasterOutletListFromBackendAndUpdateTable:self.tableView];
  self.masterOutletList = self.appData.masterOutletList;
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
  NSNumber *value = switch_sender.on ? [NSNumber numberWithInt:1] : [NSNumber numberWithInt:0];
  NSLog(@"Outlet #%@ Power Switch Toggled to: %@", toggledOutlet.outletId, value);
  // Actually send this to back end here (Using outletId NOT userOutletNumber...!)
  NSURL *urlBase = self.appData.urlBase;
  NSString *urlRelative = [NSString stringWithFormat:@"/outlets/%@/power-toggle", toggledOutlet.outletId];
  
  AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:urlBase];
  NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                          value, @"value",
                          nil];
  [httpClient postPath:urlRelative parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    NSLog(@"Request Successful, response '%@'", responseStr);
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
  }];
}

@end
