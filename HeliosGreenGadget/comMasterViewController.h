//
//  comMasterViewController.h
//  HeliosGreenGadget
//
//  Created by Jan Damek on /136/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class comDetailViewController;

#import <CoreData/CoreData.h>

@interface comMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) comDetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
