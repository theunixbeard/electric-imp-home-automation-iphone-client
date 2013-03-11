//
//  OutletSettingsController.h
//  Home-Automation1
//
//  Created by Ben Gelsey on 3/8/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalAppDataSingleton.h"

@interface OutletSettingsMasterController : UITableViewController

@property (nonatomic, strong) NSMutableArray *masterOutletList;
@property (nonatomic, strong) GlobalAppDataSingleton *appData;

@end
