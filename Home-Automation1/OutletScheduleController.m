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
  }else {
    Schedule *schedule = [dayArray objectAtIndex:indexPath.row];
    [[cell textLabel] setText:[schedule humanReadableScheduleTime]];
    [[cell detailTextLabel] setText:[schedule.state boolValue] ? @"on" : @"off"];
  }
  return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
  return UITableViewCellEditingStyleDelete;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
  [super setEditing:editing animated:animated];

  NSMutableArray* paths = [[NSMutableArray alloc] init];
  for (int i = 0; i < 7; ++i) {
    NSInteger rowCount = [[self.masterScheduleList objectAtIndex:i] count] - 1;
    NSIndexPath *path = [NSIndexPath indexPathForRow:rowCount inSection:i];
    [paths addObject:path];
  }
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
      // Delete the row from the data source
      // Send to backend as well here??????????????
      NSNumber *scheduleId = [[[self.masterScheduleList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] scheduleId];
      NSURL *urlBase = [NSURL URLWithString:@"http://localhost:9292/"];
      NSString *urlRelative = [NSString stringWithFormat:@"/outlets/%@/schedules/%@/delete", self.outlet.outletId, scheduleId];
      
      AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:urlBase];
      NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                              nil];
      [httpClient postPath:urlRelative parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"Request Successful, response '%@'", responseStr);
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
      }];
      NSLog(@"Deleted a row with id #%@", [[[self.masterScheduleList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] scheduleId]);
      [[self.masterScheduleList objectAtIndex:indexPath.section] removeObjectAtIndex:indexPath.row];
      [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
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
    NSUInteger alreadyExists = [dayArray indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop){
      Schedule *schedule = (Schedule *)obj;
      if([schedule.time isEqualToNumber: addScheduleController.schedule.time]){
        NSLog(@"Found same time");
        return YES;
      }
      return NO;
    }];
    NSLog(@"already exists: %i", alreadyExists);
    if(alreadyExists == NSNotFound) {
      [dayArray addObject:addScheduleController.schedule];
      [dayArray sortUsingComparator:^NSComparisonResult(id a, id b) {
        NSNumber *first = [(Schedule *)a time];
        NSNumber *second = [(Schedule *)b time];
        return [first compare:second];
      }];
      //SEND TO BACKEND TO PERSIST DATA!!!!
      NSURL *urlBase = [NSURL URLWithString:@"http://localhost:9292/"];
      NSString *urlRelative = [NSString stringWithFormat:@"/outlets/%@/schedules/new", self.outlet.outletId];
      
      AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:urlBase];
      NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                              addScheduleController.schedule.state, @"state",
                              addScheduleController.schedule.time, @"time",
                              addScheduleController.schedule.day, @"day",
                              addScheduleController.schedule.outletId, @"outlet_id",
                              addScheduleController.schedule.userId, @"user_id",
                              nil];
      [httpClient postPath:urlRelative parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"Request Successful, response '%@'", responseStr);
        if(![responseStr isEqualToString:@"bad schedule"]) {
          addScheduleController.schedule.scheduleId = [NSNumber numberWithInt:[responseStr intValue]];
        }
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
      }];
    }
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
