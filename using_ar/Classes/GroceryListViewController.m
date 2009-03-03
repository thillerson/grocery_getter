//
//  GroceryGetterViewController.m
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/21/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "GroceryGetterAppDelegate.h"
#import "GroceryListViewController.h"
#import "GroceryListItem.h"

@implementation GroceryListViewController

- (void) showAddItemView {
	[appDelegate showAddItemView];
}

- (void) checkCell:(UITableViewCell *)cell checked:(BOOL)b {
	if (b) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	} else {
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
}

- (NSMutableArray *) groceryListForSection:(NSInteger)section {
	if (sortAfterComplete) {
		if (0 == section) {
			return appDelegate.incompleteGroceryList;
		} else {
			return appDelegate.completeGroceryList;
		}
	} else {
		return appDelegate.fullGroceryList;
	}
	
}

#pragma mark Editing Methods

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	[super setEditing:editing animated:animated];
	[tableView setEditing:editing animated:animated];
	if(editing) {
		self.navigationItem.rightBarButtonItem.enabled = NO;
	} else {
		self.navigationItem.rightBarButtonItem.enabled = YES;
	}
}

#pragma mark Table Delegate Methods

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	if (self.editing) {
		[appDelegate showEditItemViewForItem:[appDelegate.fullGroceryList objectAtIndex:indexPath.row]];
	} else {
		// toggle checked value of item at index path
		NSArray *list = [self groceryListForSection:indexPath.section];
		UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
		GroceryListItem *item = [list objectAtIndex:indexPath.row];
		[item toggleComplete];
		[self checkCell:cell checked:[item.complete boolValue]];
		if (sortAfterComplete) {
			[appDelegate reloadGroceryList];
			[tableView reloadData];
		}
	}
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
	[appDelegate.fullGroceryList exchangeObjectAtIndex:destinationIndexPath.row withObjectAtIndex:sourceIndexPath.row];
	[appDelegate groceryListOrderDidChange];
}

#pragma mark Table Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	if (sortAfterComplete) {
		return 2;
	} else {
		return 1;
	}
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
	if (sortAfterComplete) {
		if (0 == section) {
			return [appDelegate.incompleteGroceryList count];
		} else {
			return [appDelegate.completeGroceryList count];
		}
	} else {
		return [appDelegate.fullGroceryList count];
	}
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (sortAfterComplete) {
		if (0 == section) {
			return @"Incomplete";
		} else {
			return @"Complete";
		}
	} else {
		return nil;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"groceryListItem"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"groceryListItem"] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
	NSArray *list = [self groceryListForSection:indexPath.section];
	GroceryListItem *itemAtIndex = [list objectAtIndex:indexPath.row];
    cell.text = itemAtIndex.title;
	[self checkCell:cell checked:[itemAtIndex.complete boolValue]];
    return cell;
}

- (void) tableView:(UITableView *)tv commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		NSMutableArray *list = [self groceryListForSection:indexPath.section];
		GroceryListItem *item = [list objectAtIndex:indexPath.row];
		item.destroy;
		[list removeObjectAtIndex:indexPath.row];
		[tv reloadData];
	}
}

#pragma mark Standard Methods

- (void)viewWillAppear:(BOOL)animated {
	// reload the "should sort on complete setting"
	NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
	sortAfterComplete = [settings boolForKey:@"shouldSortAfterComplete"];
	[appDelegate reloadGroceryList];
	[tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
	[self setEditing:NO animated:YES];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showAddItemView)] autorelease];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}

@end
