//
//  comLogonViewController.m
//  HeliosGreenGadget
//
//  Created by Jan Damek on /216/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "comLogonViewController.h"
#import "comAppDelegate.h"

@interface comLogonViewController ()

@end

@implementation comLogonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction) logon_touch:(id)sender
{
    comAppDelegate *d = (comAppDelegate*)[[UIApplication sharedApplication] delegate];
    [d do_logon];
    [self dismissModalViewControllerAnimated:YES];
        
}

@end
