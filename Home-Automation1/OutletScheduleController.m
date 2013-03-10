//
//  OutletScheduleController.m
//  Home-Automation1
//
//  Created by Ben Gelsey on 3/8/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "OutletScheduleController.h"
#import "AFNetworking.h"
#import "Outlet.h"
#import "Schedule.h"
#import "AddScheduleController.h"

@interface OutletScheduleController ()

@end

@implementation OutletScheduleController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;
 
  // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
  /* editing #1
  self.navigationItem.rightBarButtonItem = self.editButtonItem;
   */
  self.masterScheduleList = [[NSMutableArray alloc] init];
  // Add 7 arrays, 1 for each day of the week
  for (int i = 0; i < 7; ++i) {
    [self.masterScheduleList addObject:[[NSMutableArray alloc] init]];
  }
  
  NSString *url_string = [NSString stringWithFormat:@"http://localhost:9292/outlets/%@/schedules.json", self.outlet.outletId];
  NSURL *url = [NSURL URLWithString:url_string];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  AFJSONRequestOperation *operation;
  operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                              success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                                NSLog(@"ViewDidLoad OutletScheduleController Success");
                                                                //NSLog(@"Response: %@", JSON);
                                                                for (NSDictionary *jsonDict in JSON) {
                                                                  NSUInteger day_key = [[jsonDict objectForKey:@"day"] integerValue];
                                                                  [[self.masterScheduleList objectAtIndex:day_key] addObject:[[Schedule alloc]
                                                                                                  initWithScheduleId:[jsonDict objectForKey:@"id"]
                                                                                                  outletId:[jsonDict objectForKey:@"outlet_id"]
                                                                                                  userId:[jsonDict objectForKey:@"user_id"]
                                                                                                  day:[jsonDict objectForKey:@"day"]
                                                                                                  time:[jsonDict objectForKey:@"time"]
                                                                                                  state:[jsonDict objectForKey:@"state"]]];
                                                                }
                                                                [self.tableView reloadData];
                                                                
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 7;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  // The header for the section is the region name -- get this from the region at the section index.
  switch (section){
    case 0:
      return @"Sunday";
    case 1:
      return @"Monday";
    case 2:
      return @"Tuesday";
    case 3:
      return @"Wednesday";
    case 4:
      return @"Thursday";
    case 5:
      return @"Friday";
    case 6:
      return @"Saturday";
  }
  return @"INVALID SECTION NUMBER";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
  NSMutableArray *dayArray = (NSMutableArray *) [self.masterScheduleList objectAtIndex:section];
/*  editing #2
 if (self.tableView.editing) {
    return dayArray.count + 1;
  }
 */
  return dayArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  //indexPath has BOTH section and row!
  static NSString *CellIdentifier = @"ScheduleCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
  // Configure the cell...
  NSMutableArray *dayArray = [self.masterScheduleList objectAtIndex:indexPath.section];
  if (indexPath.row == [dayArray count]) {
    /* editing #3
    [[cell textLabel] setText: @"Add New Time"];
    [[cell detailTextLabel] setText:@""];
     */
  }else {
    Schedule *schedule = [dayArray objectAtIndex:indexPath.row];
    [[cell textLabel] setText:[schedule humanReadableScheduleTime]];
    [[cell detailTextLabel] setText:[schedule.state boolValue] ? @"on" : @"off"];
  }
  return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
  /* editing #4
  if (indexPath.row == [[self.masterScheduleList objectAtIndex: indexPath.section] count]) {
    return UITableViewCellEditingStyleInsert;
  }
  */
  return UITableViewCellEditingStyleDelete;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
  [super setEditing:editing animated:animated];

  NSMutableArray* paths = [[NSMutableArray alloc] init];
  for (int i = 0; i < 7; ++i) {
    /* editing #5
    NSInteger rowCount = [[self.masterScheduleList objectAtIndex:i] count];
    */
    NSInteger rowCount = [[self.masterScheduleList objectAtIndex:i] count] - 1;
    NSIndexPath *path = [NSIndexPath indexPathForRow:rowCount inSection:i];
    [paths addObject:path];
  }
  /* editing #6
  if (editing) {
    [self.tableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationBottom];
  } else {
    [self.tableView deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationBottom];
  }
   */
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
      // Delete the row from the data source
      // Send to backend as well here??????????????
      [[self.masterScheduleList objectAtIndex:indexPath.section] removeObjectAtIndex:indexPath.row];
      [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    /* editing #7
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
      NSNumber *dummy = [NSNumber numberWithInt: 5];
      [[self.masterScheduleList objectAtIndex:indexPath.section] addObject:[[Schedule alloc]
                                                                            initWithScheduleId:dummy
                                                                            outletId:dummy
                                                                            userId:dummy
                                                                            day:dummy
                                                                            time:dummy
                                                                            state:dummy]];
      [tableView insertRowsAtIndexPaths:(NSArray *)@[indexPath] withRowAnimation:(UITableViewRowAnimation)UITableViewRowAnimationAutomatic];
    }   
    */
}

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

// Segue to addScheduleController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([[segue identifier] isEqualToString:@"AddScheduleSegue"]) {
    AddScheduleController *controller = [segue destinationViewController];
    controller.outlet = self.outlet;
  }
}

// Modal done/cancel segues
- (IBAction)done:(UIStoryboardSegue *)segue {
  if ([[segue identifier] isEqualToString:@"ReturnInput"]) {
    AddScheduleController *addScheduleController = [segue sourceViewController];
    NSLog(@"%@", addScheduleController.schedule.time);
    NSMutableArray *dayArray = [self.masterScheduleList objectAtIndex:[addScheduleController.schedule.day intValue]];
    [dayArray addObject:addScheduleController.schedule];
    [dayArray sortUsingComparator:^NSComparisonResult(id a, id b) {
      NSNumber *first = [(Schedule *)a time];
      NSNumber *second = [(Schedule *)b time];
      return [first compare:second];
    }];
    //SEND TO BACKEND TO PERSIST DATA!!!!
    [[self tableView] reloadData];
    [self dismissViewControllerAnimated:YES completion:NULL];
  }
}

- (IBAction)cancel:(UIStoryboardSegue *)segue
{
  if([[segue identifier] isEqualToString:@"CancelInput"]) {
    [self dismissViewControllerAnimated:YES completion:NULL];
  }
}

@end
