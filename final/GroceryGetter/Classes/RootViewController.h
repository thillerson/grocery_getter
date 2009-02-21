//
//  RootViewController.h
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/16/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GroceryListViewController;
@class FlipsideViewController;

@interface RootViewController : UIViewController {
	UINavigationController *mainNavController;
	UIToolbar *toolbar;
    UIBarButtonItem *settingsButton;
    GroceryListViewController *mainViewController;
    FlipsideViewController *flipsideViewController;
    UINavigationBar *flipsideNavigationBar;
}

@property (nonatomic, retain) IBOutlet UINavigationController *mainNavController;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *settingsButton;
@property (nonatomic, retain) GroceryListViewController *mainViewController;
@property (nonatomic, retain) UINavigationBar *flipsideNavigationBar;
@property (nonatomic, retain) FlipsideViewController *flipsideViewController;

- (IBAction)toggleView;

@end
