//
//  OutletRenameController.h
//  Home-Automation1
//
//  Created by Ben Gelsey on 3/8/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Outlet.h"

@interface OutletRenameController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) Outlet *outlet;

@end
