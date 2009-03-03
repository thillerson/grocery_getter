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
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FmdbMigrationManager.h"
#import "CreateGroceryList.h"
#import "CreateQuickList.h"

@implementation GroceryGetterAppDelegate

@synthesize window, navigationController, groceryListController, addListItemController, fullGroceryList, incompleteGroceryList, completeGroceryList, quickAddList;

#pragma mark -
#pragma mark List Item API

- (void) addItemToList:(NSString *)title {
	[fullGroceryList addObject:[GroceryListItem createWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:title, @"title",
																	  [NSNumber numberWithInt:[fullGroceryList count] - 1], @"position",
																	  [NSNumber numberWithInt:0], @"complete", nil]]];
}

- (void) addItemsToList:(NSArray *)newItems {
	[fullGroceryList addObjectsFromArray:newItems];
}

- (void) deleteItemAtIndex:(NSInteger)index {
	GroceryListItem *item = (GroceryListItem *)[fullGroceryList objectAtIndex:index];
	[item destroy];
	[fullGroceryList removeObjectAtIndex:index];
}

- (void) groceryListOrderDidChange {
	GroceryListItem *item;
	for (int i=0; i<[fullGroceryList count]; i++) {
		item = [fullGroceryList objectAtIndex:i];
		item.position = [NSNumber numberWithInt:i];
	}
}

- (void) reloadGroceryList {
	self.fullGroceryList = (NSMutableArray *)[GroceryListItem find:ARFindAll filter:nil join:nil order:@"complete, position" limit:0];
	self.completeGroceryList = (NSMutableArray *)[GroceryListItem find:ARFindAll filter:@"complete=1" join:nil order:@"complete, position" limit:0];
	self.incompleteGroceryList = (NSMutableArray *)[GroceryListItem find:ARFindAll filter:@"complete=0" join:nil order:@"complete, position" limit:0];
}

- (void) addItemToQuickList:(NSString *)title {
	[quickAddList addObject:[QuickListItem createWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:title, @"title",
																[NSNumber numberWithInt:[quickAddList count] - 1], @"position", nil]]];
}

- (void) deleteQuickListItemAtIndex:(NSInteger)index {
	QuickListItem *item = (QuickListItem *)[quickAddList objectAtIndex:index];
	[item destroy];
	[quickAddList removeObjectAtIndex:index];
}

- (void) quickListOrderDidChange {
	QuickListItem *item;
	for (int i=0; i<[quickAddList count]; i++) {
		item = [quickAddList objectAtIndex:i];
		item.position = [NSNumber numberWithInt:i];
	}
}

#pragma mark -
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

- (void) migrate {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"groceries.db"];
	ARSQLiteConnection *connection = [ARSQLiteConnection
									  openConnectionWithInfo:[NSDictionary dictionaryWithObject:path forKey:@"path"]
									  error:nil];
	[ARBase setDefaultConnection:connection];
	//	[ARBase setDelayWriting:YES];
	NSArray *migrations = [NSArray arrayWithObjects:
						   [CreateGroceryList migration],
						   [CreateQuickList migration],
						   nil];
	[FmdbMigrationManager executeForDatabasePath:path withMigrations:migrations];
}

- (void) initializeData {
	[self reloadGroceryList];
	self.quickAddList = (NSMutableArray *)[QuickListItem find:ARFindAll filter:nil join:nil order:@"position" limit:0];
}

#pragma mark -
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

#pragma mark -
#pragma mark Standard Methods

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    [self createEditableCopyOfDatabaseIfNeeded];
	[self migrate];
	[self initializeData];
	navigationController.viewControllers = [NSArray arrayWithObject:groceryListController];
    
    [window insertSubview:navigationController.view belowSubview:toolbar];
    [window makeKeyAndVisible];
}


- (void)dealloc {
	[db close];
	[db release];
	[toolbar release];
	[navigationController release];
    [groceryListController release];
    [window release];
    [super dealloc];
}

@end
