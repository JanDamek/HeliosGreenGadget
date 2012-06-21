//
//  comAppDelegate.m
//  HeliosGreenGadget
//
//  Created by Jan Damek on /136/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "comAppDelegate.h"
#import "comMasterViewController.h"
#import "comDetailViewController.h"
#import "comLogonViewController.h"

@implementation comAppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;
@synthesize splitViewController = _splitViewController;
@synthesize redirectSOAP = _redirectSOAP;
@synthesize serviceSOAP =_serviceSOAP;
@synthesize defaults = _defaults;
@synthesize URLSOAP = _URLSOAP;
@synthesize gadgetList = _gadgetList;

-(void) getSOAP
{
    _serviceSOAP = [[GetServiceServiceGateExample alloc]init];
    [_serviceSOAP run];    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    _gadgetList = [[NSMutableArray alloc]init];
    
    NSDictionary *userDefaultsDefaults = [NSDictionary dictionaryWithObjectsAndKeys:
                                          @"https://open.lcs.cz/extranet42", @"server_url",
                                          @"CZ", @"lang_gadget",
                                          nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:userDefaultsDefaults];    
    _defaults = [NSUserDefaults standardUserDefaults];
    
    _redirectSOAP = [[GetRedirectDataExample alloc]init];
    [self do_logon];
    
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        masterViewController = [[comMasterViewController alloc] initWithNibName:@"comMasterViewController_iPhone" bundle:nil];
        self.navigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
        self.window.rootViewController = self.navigationController;

    } else {
        masterViewController = [[comMasterViewController alloc] initWithNibName:@"comMasterViewController_iPad" bundle:nil];
        UINavigationController *masterNavigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
        
        comDetailViewController *detailViewController = [[comDetailViewController alloc] initWithNibName:@"comDetailViewController_iPad" bundle:nil];
        UINavigationController *detailNavigationController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    	
    	masterViewController.detailViewController = detailViewController;
        
        self.splitViewController = [[UISplitViewController alloc] init];
        self.splitViewController.delegate = detailViewController;
        self.splitViewController.viewControllers = [NSArray arrayWithObjects:masterNavigationController, detailNavigationController, nil];
        
        self.window.rootViewController = self.splitViewController;

    }
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [_serviceSOAP.service LogOff:self action:@selector(LogOffHandler:) sessionToken:_serviceSOAP.sessionToken];

}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    return nil;
}

- (void)gg_added
{
    [masterViewController.tableView reloadData];  
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void) logon
{
    comLogonViewController *login;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        login = [[comLogonViewController alloc]initWithNibName:@"comLogonViewController_iPhone" bundle:nil];
    }else {
        login = [[comLogonViewController alloc]initWithNibName:@"comLogonViewController_iPad" bundle:nil];
    }
    [[self navigationController]pushViewController:login animated:YES];
}

- (void) do_logon
{
    [_redirectSOAP run];    
}

@end
