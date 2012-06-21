//
//  comDetailViewController.h
//  HeliosGreenGadget
//
//  Created by Jan Damek on /136/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface comDetailViewController : UIViewController <UISplitViewControllerDelegate>{
    bool _is_loading;
}

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
