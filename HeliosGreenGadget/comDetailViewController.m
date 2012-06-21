//
//  comDetailViewController.m
//  HeliosGreenGadget
//
//  Created by Jan Damek on /136/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "comDetailViewController.h"
#import "comAppDelegate.h"
#import "XMLReader.h"

@interface comDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation comDetailViewController

@synthesize detailItem = _detailItem;
@synthesize detailDescriptionLabel = _detailDescriptionLabel;
@synthesize masterPopoverController = _masterPopoverController;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
    
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void) GettingGadgetHandler: (id) value {
	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"ERROR ProcessXml 5485:%@", value);
		return;
	}
    
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"FAULT ProcessXml 5485:%@", value);
		return;
	}				
    
	// Do something with the NSString* result
    NSString* result = (NSString*)value;
	NSLog(@"ProcessXml 5485 returned the value: %@", result);
    
    if (![result isEqualToString:@""]){
        //provest nacteni potrebnych dat
        NSDictionary* xmlDict = [XMLReader dictionaryForXMLString:result error:nil];
        if (xmlDict.count>0){
            NSMutableArray *gadgets=[xmlDict valueForKey:@"RUNRESULT"];
            
            if (gadgets!=nil && [gadgets count]>0){
                NSMutableDictionary *gg = [gadgets valueForKey:@"USERDATA"];
                NSLog(@"UD:%@", gg);

                NSMutableDictionary *g = [gg valueForKey:@"JssScripts"];
                NSString *js = [g valueForKey:@"text"];
                if (js == nil){
                    js = @"";
                }

                g = [gg valueForKey:@"CssStyles"];
                NSString *css = [g valueForKey:@"text"];
                if (css == nil){
                    css = @"";
                }

                g = [gg valueForKey:@"HtmlData"];
                NSString *html = [g valueForKey:@"text"];
                if (html == nil){
                    html = @"";
                }
                
                NSString *html_web = @"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\"><html xmlns=\"http://www.w3.org/1999/xhtml\"><head>";
                
                if ([css length]>0){
                    html_web = [html_web stringByAppendingFormat:@"<style type=\"text/css\">%@</style>", css];  
                }
                
                if ([js length]>0){
                    html_web = [html_web stringByAppendingFormat:@"<script type=\"text/javascript\">%@</script>", js];
                }
                html_web = [html_web stringByAppendingFormat:@"</head><body>%@</body></html>", html];

            }
        }
    }
    _is_loading = NO;
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        NSDictionary *gg = [_detailItem valueForKey:@"gadget"];
        if ([gg count]>0){
            // html je nacteno zobrazit
            
        }else if (!_is_loading){
            _is_loading = YES;
            self.detailDescriptionLabel.text = NSLocalizedString(@"Loadidng", nil);
            
            //[self.detailItem valueForKey:@"name"];
            
            // nacist html
            comAppDelegate *d = (comAppDelegate*)[[UIApplication sharedApplication] delegate];
            NSLog(@"%@", self.detailItem);
            NSString *gg_id = [self.detailItem valueForKey:@"id"];
            NSString *xml = [NSString stringWithFormat:@"<RUN FUNCTIONID=\"5485\"><USERDATA><Version>43.40.00.02</Version><SelectedGadgets><Id>%@</Id></SelectedGadgets></USERDATA></RUN>", gg_id];
            GetServiceServiceGateExample *ser = d.serviceSOAP;
            [ser.service ProcessXml:self action:@selector(GettingGadgetHandler:) sessionToken:ser.sessionToken inputXml:xml];
            
        }
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    _is_loading = NO;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.detailDescriptionLabel = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Detail", @"Detail");
    }
    return self;
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
