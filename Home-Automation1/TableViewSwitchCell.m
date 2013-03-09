//
//  OutletPowerCell.m
//  Home-Automation1
//
//  Created by Ben Gelsey on 3/8/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "TableViewSwitchCell.h"

@implementation TableViewSwitchCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)OnSwitchValueChanged:(id)sender {
  if (self.cellDelegate != nil && [self.cellDelegate conformsToProtocol:@protocol(TableViewSwitchCellDelegate)]) {
    if ([self.cellDelegate respondsToSelector:@selector(onTableViewSwitchCellSwitchToggle:cell:)]) {
      [self.cellDelegate onTableViewSwitchCellSwitchToggle:sender cell:self];
    }
  }
}

-(void)onTableViewSwitchCellSwitchToggle:(id)sender cell:(TableViewSwitchCell *)cell {

}

@end
