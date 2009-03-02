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

- (void) addItemsToList:(NSArray *)newItems {
	[currentGroceryList addObjectsFromArray:newItems];
}

- (void) updateItem:(GroceryListItem *)item atIndex:(NSInteger)index {
}

- (void) deleteItemAtIndex:(NSInteger)index {
	[currentGroceryList removeObjectAtIndex:index];
}

- (void) quickListOrderDidChange {
	QuickListItem *item;
	for (int i=0; i<[quickAddList count]; i++) {
		item = [quickAddList objectAtIndex:i];
		item.position = i;
		item.save;
	}
}

- (void) addItemToQuickList:(NSString *)title {
	QuickListItem *newItem = [[QuickListItem alloc] initWithDatabase:db];
	newItem.title = title;
	newItem.position = [quickAddList count] - 1;
	newItem.create;
	[quickAddList addObject:newItem];
	[newItem release];
}

- (void) deleteQuickListItemAtIndex:(NSInteger)index {
	QuickListItem *item = (QuickListItem *)[quickAddList objectAtIndex:index];
	item.destroy;
	[quickAddList removeObjectAtIndex:index];
}

#pragma mark Database Methods

- (void)createEditableCopyOfDatabaseIfNeeded {
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"groceries.db"];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success) return;
    // The writable database does not exist, so copy the default to the appropriate location.
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"groceries.db"];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) {
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}

- (void) setUpData {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"groceries.db"];
    if (sqlite3_open([path UTF8String], &db) == SQLITE_OK) {
		self.quickAddList = (NSMutableArray *)[QuickListItem findAllQuickListItemsInOrderInDatabase:db];
	} else {
        sqlite3_close(db);
        NSAssert1(0, @"Failed to open database: '%s'.", sqlite3_errmsg(db));
	}
	self.currentGroceryList = [NSMutableArray arrayWithObjects:[[GroceryListItem alloc] initWithTitle:@"Foo"], [[GroceryListItem alloc] initWithTitle:@"Bar"], nil];
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
    [self createEditableCopyOfDatabaseIfNeeded];
	[self setUpData];
	navigationController.viewControllers = [NSArray arrayWithObject:groceryListController];
    
    [window insertSubview:navigationController.view belowSubview:toolbar];
    [window makeKeyAndVisible];
}


- (void)dealloc {
	[QuickListItem deletePreparedStatements];
	[toolbar release];
	[navigationController release];
    [groceryListController release];
    [window release];
    [super dealloc];
}

@end
