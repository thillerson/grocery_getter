//
//  AddQuickAddItemViewController.m
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/28/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GroceryGetterAppDelegate.h"
#import "AddQuickAddItemViewController.h"
#import "QuickListItem.h"

@implementation AddQuickAddItemViewController

@synthesize itemToEdit;

- (void) saveItem {
	if ([textField.text length] > 0) {
		if (nil != itemToEdit) {
			itemToEdit.title = textField.text;
		} else {
			[appDelegate addItemToQuickList:[[QuickListItem alloc] initWithTitle:textField.text]];
		}
	}
}

- (void) doneEditingItem {
	[self saveItem];
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction) cancel:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction) save:(id)sender {
	[self saveItem];
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark Text Field methods

- (void)textFieldDidBeginEditing:(UITextField *)tf {
	if (nil != itemToEdit) {
		[textField setText:itemToEdit.title];
	}
}

- (void)textFieldDidEndEditing:(UITextField *)tf {
	[self dismissModalViewControllerAnimated:YES];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addQuickListItemCell"];
    if (cell == nil) {
        cell = tableCell;
    }
    return cell;
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
	[tableView dealloc];
}


@end
