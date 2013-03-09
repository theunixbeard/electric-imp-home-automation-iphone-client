//
//  OutletSettingsCell.h
//  Home-Automation1
//
//  Created by Ben Gelsey on 3/8/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OutletSettingsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *outletName;
@property (weak, nonatomic) IBOutlet UIButton *outletSettingsButton;

@property (weak, nonatomic) IBOutlet id cellDelegate;

-(IBAction)OnButtonPressed:(id)sender;

@end

@protocol OutletSettingsCellDelegate

@optional
-(void)onOutletSettingsCellButtonPressed:(id)sender cell:(OutletSettingsCell *)cell;

@end
