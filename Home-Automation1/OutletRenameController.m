//
//  OutletRenameController.m
//  Home-Automation1
//
//  Created by Ben Gelsey on 3/8/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "OutletRenameController.h"

@interface OutletRenameController ()
@property (weak, nonatomic) IBOutlet UILabel *oldOutletLabel;
@property (weak, nonatomic) IBOutlet UITextField *renameOutletTextField;
- (IBAction)renameOutlet:(id)sender;

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
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
  if (theTextField == self.renameOutletTextField) {
    [theTextField resignFirstResponder];
  }
  return YES;
}
@end
