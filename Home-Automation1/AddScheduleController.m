//
//  AddScheduleController.m
//  Home-Automation1
//
//  Created by Ben Gelsey on 3/9/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "AddScheduleController.h"

@interface AddScheduleController ()
@property (weak, nonatomic) IBOutlet UILabel *addScheduleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *scheduleSwitch;
@property (weak, nonatomic) IBOutlet UIPickerView *scheduleDayPicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *scheduleTimePicker;

@end

@implementation AddScheduleController

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
  [self.addScheduleLabel setText: [NSString stringWithFormat:@"Turn %@:", [self.outlet humanReadableOutletName]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([[segue identifier] isEqualToString:@"ReturnInput"]) {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"h:mm a"];
    //NSLog(@"On/Off: %@", self.scheduleSwitch.on ? @"ON" : @"OFF");
    //NSLog(@"%i", [self.scheduleDayPicker selectedRowInComponent:0]);
    //NSLog(@"%@, %@", self.scheduleTimePicker.date, self.scheduleTimePicker.date.class);
    //NSLog(@"%@", [outputFormatter stringFromDate:self.scheduleTimePicker.date]);
    
    
    NSNumber *schedule_state = self.scheduleSwitch.on ? [NSNumber numberWithInt: 1] : [NSNumber numberWithInt: 0];
    self.schedule = [[Schedule alloc] initWithScheduleId:[NSNumber numberWithInt: -1]
                                                outletId:self.outlet.userOutletNumber
                                                  userId:self.outlet.userId
                                                     day:[NSNumber numberWithInt:[self.scheduleDayPicker selectedRowInComponent:0]]
                                                    time:[Schedule machineReadableScheduleTime:[outputFormatter stringFromDate:self.scheduleTimePicker.date]]
                                                   state:schedule_state];
    //NSLog(@"%@", self.schedule.time);
     
  }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
  return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
  return 7;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
  switch (row){
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

@end
