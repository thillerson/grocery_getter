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
#import "GroceryListItem.h"

@implementation GroceryGetterAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize groceryListController;
@synthesize addListItemController;
@synthesize currentGroceryList;

#pragma mark List Item API

- (void) addItemToList:(GroceryListItem *)newItem {
	[currentGroceryList addObject:newItem];
}

- (void) updateItem:(GroceryListItem *)item atIndex:(NSInteger)index {
	
}

- (void) deleteItemAtIndex:(NSInteger)index {
	[currentGroceryList removeObjectAtIndex:index];
}

- (void) setUpData {
	self.currentGroceryList = [NSMutableArray arrayWithObjects:[[GroceryListItem alloc] initWithTitle:@"Foo"], [[GroceryListItem alloc] initWithTitle:@"Bar"], nil];
}

#pragma mark Navigation Actions

- (IBAction) doneEditingItem {
	//TODO make sure the editing view is actually the top?
	[navigationController popViewControllerAnimated:YES];
}

- (void) showAddItemView {
	[navigationController pushViewController:addListItemController animated:YES];
}

- (IBAction) showQuickAddList {
	
}

- (IBAction) showSettingsView {
	
}

#pragma mark Standard Methods

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	[self setUpData];
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
