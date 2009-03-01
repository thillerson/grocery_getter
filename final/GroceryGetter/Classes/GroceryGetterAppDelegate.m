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
#import "QuickAddViewController.h"
#import "GroceryListItem.h"
#import "QuickListItem.h"

@implementation GroceryGetterAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize groceryListController;
@synthesize addListItemController;
@synthesize currentGroceryList;
@synthesize quickAddList;

#pragma mark List Item API

- (void) addItemToList:(GroceryListItem *)newItem {
	[currentGroceryList addObject:newItem];
}

- (void) addItemsToList:(NSArray *)newItems {
	[currentGroceryList addObjectsFromArray:newItems];
}

- (void) updateItem:(GroceryListItem *)item atIndex:(NSInteger)index {
}

- (void) deleteItemAtIndex:(NSInteger)index {
	[currentGroceryList removeObjectAtIndex:index];
}

- (void) deleteQuickListItemAtIndex:(NSInteger)index {
	[quickAddList removeObjectAtIndex:index];
}

- (void) setUpData {
	self.currentGroceryList = [NSMutableArray arrayWithObjects:[[GroceryListItem alloc] initWithTitle:@"Foo"], [[GroceryListItem alloc] initWithTitle:@"Bar"], nil];
	self.quickAddList = [NSMutableArray arrayWithObjects:[[QuickListItem alloc] initWithTitle:@"Milk"], [[QuickListItem alloc] initWithTitle:@"Water"], nil];
}

#pragma mark Navigation Actions

- (void) showToolbar {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition:UIViewAnimationCurveLinear forView:toolbar cache:YES];
	[window addSubview:toolbar];
	[UIView commitAnimations];
}

- (void) hideToolbar {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition:UIViewAnimationCurveLinear forView:toolbar cache:YES];
	[toolbar removeFromSuperview];
	[UIView commitAnimations];
}

- (IBAction) doneEditingItem {
	[self showToolbar];
	[navigationController popViewControllerAnimated:YES];
}

- (void) showAddItemView {
	[self hideToolbar];
	addListItemController.title = @"Add Item";
	[navigationController pushViewController:addListItemController animated:YES];
}

- (void) showEditItemViewForItem:(GroceryListItem *)item {
	[self hideToolbar];
	addListItemController.itemToEdit = item;
	addListItemController.title = @"Edit Item";
	[navigationController pushViewController:addListItemController animated:YES];
}

- (IBAction) showQuickAdd:(id)sender {
	[self hideToolbar];
	[navigationController pushViewController:quickAddViewController animated:YES];
}

- (IBAction) showSettingsView:(id)sender {
	[self hideToolbar];
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
