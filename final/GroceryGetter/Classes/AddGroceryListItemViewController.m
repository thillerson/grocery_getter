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

#pragma mark Text Field methods

- (void)textFieldDidEndEditing:(UITextField *)tf {
	[appDelegate doneEditingItem];
}

- (BOOL)textFieldShouldReturn:(UITextField *)tf {
	if ([textField.text length] > 0) {
		[appDelegate addItemToList:[[GroceryListItem alloc] initWithTitle:textField.text]];
	}
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

- (void)viewWillAppear:(BOOL)animated {
	[textField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}


@end
