//
//  comMasterViewController.h
//  HeliosGreenGadget
//
//  Created by Jan Damek on /136/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class comDetailViewController;

@interface comMasterViewController : UITableViewController;

@property (strong, nonatomic) comDetailViewController *detailViewController;

@end
