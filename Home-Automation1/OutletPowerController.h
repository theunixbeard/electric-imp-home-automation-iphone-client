//
//  OutletPowerController.h
//  Home-Automation1
//
//  Created by Ben Gelsey on 3/3/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewSwitchCell.h"
#import "GlobalAppDataSingleton.h"

@interface OutletPowerController : UITableViewController <TableViewSwitchCellDelegate>

@property (nonatomic, strong) NSMutableArray *masterOutletList;
@property (nonatomic, strong) GlobalAppDataSingleton *appData;

@end
