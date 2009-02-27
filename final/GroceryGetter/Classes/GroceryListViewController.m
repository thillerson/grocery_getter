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

#pragma mark Editing Methods

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	if(self.editing != editing) {
		[super setEditing:editing animated:animated];
		[tableView setEditing:editing animated:animated];
	}
}

#pragma mark Table Delegate Methods

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// deselect row
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	if (self.editing) {
		
	} else {
		// toggle checked value of item at index path
		UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
		GroceryListItem *item = [appDelegate.currentGroceryList objectAtIndex:indexPath.row];
		[item toggleComplete];
		[self checkCell:cell checked:item.complete];
	}
}

#pragma mark Table Data Source Methods

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
	return [appDelegate.currentGroceryList count];
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"groceryListItem"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"groceryListItem"] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
	GroceryListItem *itemAtIndex = [appDelegate.currentGroceryList objectAtIndex:indexPath.row];
    cell.text = itemAtIndex.title;
	[self checkCell:cell checked:itemAtIndex.complete];
    return cell;
}

- (void) tableView:(UITableView *)tv commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		[appDelegate deleteItemAtIndex:indexPath.row];
		[tv reloadData];
	}
}

#pragma mark Standard Methods

- (void)viewWillAppear:(BOOL)animated {
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
