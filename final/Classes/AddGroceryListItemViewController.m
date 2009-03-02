//
//  AddGroceryListItem.m
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/21/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GroceryGetterAppDelegate.h"
#import "AddGroceryListItemViewController.h"
#import "GroceryListItem.h"

@implementation AddGroceryListItemViewController

@synthesize itemToEdit;

- (void) saveItem {
	if ([textField.text length] > 0) {
		if (nil != itemToEdit) {
			itemToEdit.title = textField.text;
			[itemToEdit save];
		} else {
			[appDelegate addItemToList:textField.text];
		}
	}
}

- (void) doneEditingItem {
	[self saveItem];
	[appDelegate doneEditingItem];
}

#pragma mark Text Field methods

- (void)textFieldDidBeginEditing:(UITextField *)tf {
	if (nil != itemToEdit) {
		[textField setText:itemToEdit.title];
	}
}

- (void)textFieldDidEndEditing:(UITextField *)tf {
	[appDelegate doneEditingItem];
}

- (BOOL)textFieldShouldReturn:(UITextField *)tf {
	[self saveItem];
	[textField resignFirstResponder];
	return YES;
}

#pragma mark Table Data Source Methods

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
	return 1; // just the editing cell
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"editListItemCell"];
    if (cell == nil) {
        cell = tableViewCell;
    }
    return cell;
}

#pragma mark Standard Methods

- (void) viewDidLoad {
	[super viewDidLoad];
	self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:appDelegate action:@selector(doneEditingItem)] autorelease];
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(doneEditingItem)] autorelease];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[textField becomeFirstResponder];
}

- (void) viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	itemToEdit = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}


@end
