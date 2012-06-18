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

@interface comAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) GetRedirectDataExample *redirectSOAP;
@property (readonly, strong, nonatomic) GetServiceServiceGateExample *serviceSOAP;
@property (readonly, strong, nonatomic) NSUserDefaults *defaults;
@property (readwrite) NSString *URLSOAP;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (void)getSOAP;

@property (strong, nonatomic) UINavigationController *navigationController;

@property (strong, nonatomic) UISplitViewController *splitViewController;

@end
