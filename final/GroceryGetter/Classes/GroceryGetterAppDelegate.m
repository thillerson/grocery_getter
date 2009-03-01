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
#import "SettingsViewController.h"
#import "QuickAddViewController.h"
#import "GroceryListItem.h"
#import "QuickListItem.h"

@implementation GroceryGetterAppDelegate

@synthesize window, navigationController, groceryListController, addListItemController, currentGroceryList, quickAddList;

#pragma mark List Item API

- (void) addItemToList:(GroceryListItem *)newItem {
	[currentGroceryList addObject:newItem];
}

- (void) addItemToQuickList:(QuickListItem *)newItem {
	[quickAddList addObject:newItem];
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

- (void) toggleSettingsView {
    UIView *mainView = navigationController.view;
    UIView *settingsView = settingsViewController.view;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition:([mainView superview] ? UIViewAnimationTransitionFlipFromRight : UIViewAnimationTransitionFlipFromLeft) forView:window cache:YES];
    if ([mainView superview] != nil) {
        [settingsViewController viewWillAppear:YES];
        [groceryListController viewWillDisappear:YES];
        [mainView removeFromSuperview];
        [toolbar removeFromSuperview];
        [window addSubview:settingsView];
        [groceryListController viewDidDisappear:YES];
        [settingsViewController viewDidAppear:YES];
		
    } else {
        [groceryListController viewWillAppear:YES];
        [settingsViewController viewWillDisappear:YES];
        [settingsView removeFromSuperview];
        [window addSubview:toolbar];
        [window insertSubview:mainView belowSubview:toolbar];
        [settingsViewController viewDidDisappear:YES];
        [groceryListController viewDidAppear:YES];
    }
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
	[self toggleSettingsView];
}

- (void) settingsViewDone {
	[self toggleSettingsView];
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
