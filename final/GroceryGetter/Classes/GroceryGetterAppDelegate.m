//
//  GroceryGetterAppDelegate.m
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/21/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "GroceryGetterAppDelegate.h"
#import "GroceryListViewController.h"
#import "AddGroceryListItemViewController.h"

@implementation GroceryGetterAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize groceryListController;
@synthesize addListItemController;

#pragma mark Interface Builder Actions

- (void) showAddItemView {
	addListItemController.title = @"Add an Item";
	[navigationController pushViewController:addListItemController animated:YES];
}

- (IBAction) showQuickAddList {
	
}

- (IBAction) showSettingsView {
	
}

#pragma mark Standard Methods

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	navigationController.viewControllers = [NSArray arrayWithObject:groceryListController];
    
    [window insertSubview:navigationController.view belowSubview:toolbar];
    [window makeKeyAndVisible];
}


- (void)dealloc {
	[toolbar release];
	[navigationController release];
    [groceryListController release];
    [window release];
    [super dealloc];
}


@end
