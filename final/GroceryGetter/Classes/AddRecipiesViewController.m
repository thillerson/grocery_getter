//
//  AddRecipiesViewController.m
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "AddRecipiesViewController.h"
#import "GroceryGetterViewController.h"

@implementation AddRecipiesViewController

- (IBAction) save:(id)sender {
	[recipesController addNewRecipeNamed:textField.text];
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction) cancel:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}

- (void) textFieldDidEndEditing:(UITextField *)tf {
	[recipesController addNewRecipeNamed:textField.text];
	[self dismissModalViewControllerAnimated:YES];
}

- (BOOL) textFieldShouldReturn:(UITextField *)tf {
	[tf resignFirstResponder];
	return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:@"textFieldCell"];
	if (nil == cell) {
		cell = textFieldCell;
	}
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}


@end
