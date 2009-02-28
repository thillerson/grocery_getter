//
//  QuickAddViewController.m
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "QuickAddViewController.h"
#import "GroceryGetterAppDelegate.h"
#import "QuickListItem.h"
#import "GroceryListItem.h"

@implementation QuickAddViewController

- (void) doneChoosingItems {
	for (NSString *title in [chosenItemTitles allKeys]) {
		[appDelegate addItemToList:[[GroceryListItem alloc] initWithTitle:title]];
	}
	[appDelegate doneEditingItem];
}

- (IBAction) editButtonPressed:(id)sender {
	if (self.editing) {
		[self setEditing:NO animated:YES];
	} else {
		[self setEditing:YES animated:YES];
	}
}

#pragma mark Editing Methods

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	[super setEditing:editing animated:animated];
	[tableView setEditing:editing animated:animated];
	if(editing) {
		self.navigationItem.rightBarButtonItem.enabled = NO;
		[editButton setTitle:@"Done Editing"];
	} else {
		self.navigationItem.rightBarButtonItem.enabled = YES;
		[editButton setTitle:@"Edit Quick List"];
	}
}

#pragma mark Table Delegate Methods

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	if (self.editing) {
		
	} else {
		// toggle checked value of item at index path
		UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
		QuickListItem *item = [appDelegate.quickAddList objectAtIndex:indexPath.row];
		if (cell.accessoryType == UITableViewCellAccessoryNone) {
			[chosenItemTitles setValue:item.title forKey:item.title];
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		} else {
			[chosenItemTitles removeObjectForKey:item.title];
			cell.accessoryType = UITableViewCellAccessoryNone;
		}
	}
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
	QuickListItem *item = [appDelegate.quickAddList objectAtIndex:sourceIndexPath.row];
	item.position = destinationIndexPath.row;
}

#pragma mark Table Data Source Methods

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
	return [appDelegate.quickAddList count];
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"quickAddItem"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"quickAddItem"] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
	QuickListItem *item = [appDelegate.quickAddList objectAtIndex:indexPath.row];
	cell.accessoryType = UITableViewCellAccessoryNone;
    cell.text = item.title;
    return cell;
}

#pragma mark Standard Methods

- (void) viewDidLoad {
	[super viewDidLoad];
	self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:appDelegate action:@selector(doneEditingItem)] autorelease];
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneChoosingItems)] autorelease];
}

- (void)viewWillAppear:(BOOL)animated {
	[tableView reloadData];
	if (nil == chosenItemTitles) {
		chosenItemTitles = [[NSMutableDictionary alloc] init];
		[chosenItemTitles retain];
	}
	[chosenItemTitles removeAllObjects];
}

- (void)viewWillDisappear:(BOOL)animated {
	[self setEditing:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
	[chosenItemTitles dealloc];
}


@end