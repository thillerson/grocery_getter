//
//  GroceryGetterViewController.m
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/21/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "GroceryGetterAppDelegate.h"
#import "GroceryListViewController.h"

@implementation GroceryListViewController

- (void) showAddItemView {
	[appDelegate showAddItemView];
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
		if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
			cell.accessoryType = UITableViewCellAccessoryNone;
		} else {
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
		}
	}
}

#pragma mark Table Data Source Methods

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"groceryListItem"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"groceryListItem"] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    cell.text = @"Foobag";
    return cell;
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
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showAddItemView)] autorelease];
	self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}

@end
