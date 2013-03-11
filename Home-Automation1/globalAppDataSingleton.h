//
//  globalAppDataSingleton.h
//  Home-Automation1
//
//  Created by Ben Gelsey on 3/10/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalAppDataSingleton : NSObject

@property (nonatomic, strong) NSMutableArray *masterOutletList;

+(GlobalAppDataSingleton *)globalAppDataSingleton;

-(void)initMasterOutletListFromBackendAndUpdateTable:(UITableView *)tableView;
@end
