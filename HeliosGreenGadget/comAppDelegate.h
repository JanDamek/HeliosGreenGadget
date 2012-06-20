//
//  comAppDelegate.h
//  HeliosGreenGadget
//
//  Created by Jan Damek on /136/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetRedirectDataExample.h"
#import "GetServiceServiceGateExample.h"
#import "comMasterViewController.h"

@interface comAppDelegate : UIResponder <UIApplicationDelegate>{
    comMasterViewController *masterViewController;
}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) GetRedirectDataExample *redirectSOAP;
@property (readonly, strong, nonatomic) GetServiceServiceGateExample *serviceSOAP;
@property (readonly, strong, nonatomic) NSUserDefaults *defaults;
@property (readonly, strong, nonatomic) NSMutableArray *gadgetList;
@property (readwrite) NSString *URLSOAP;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (void)getSOAP;
- (void)gg_added;

@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) UISplitViewController *splitViewController;

@end
