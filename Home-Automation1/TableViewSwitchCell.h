//
//  OutletPowerCell.h
//  Home-Automation1
//
//  Created by Ben Gelsey on 3/8/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewSwitchCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cellLabel;
@property (weak, nonatomic) IBOutlet UISwitch *cellSwitch;

@property (weak, nonatomic) IBOutlet id cellDelegate;

-(IBAction)OnSwitchValueChanged:(id)sender;

@end

@protocol TableViewSwitchCellDelegate

@optional
-(void)onTableViewSwitchCellSwitchToggle:(id)sender cell:(TableViewSwitchCell *)cell;

@end