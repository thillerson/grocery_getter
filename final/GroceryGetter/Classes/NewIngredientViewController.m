//
//  NewIngredientViewController.m
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NewIngredientViewController.h"
#import "GroceryGetterViewController.h"


@implementation NewIngredientViewController

- (void) setEditing:(BOOL)editing animated:(BOOL)animated {
	[super setEditing:editing animated:animated];
	if (NO == editing) {
		[(UINavigationController *)self.parentViewController
		 popViewControllerAnimated:YES];
	}
}

- (void)textFieldDidEndEditing:(UITextField *)tf {
	if(tf.text.length > 0) {
		[recipesController addIngredient:tf.text forRecipe:self.recipeName];
	}
	[self setEditing:NO animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)tf {
	[textField resignFirstResponder];
	return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"textFieldCell"];
	if(nil == cell) {
		cell = textFieldCell;
	}
	return cell;
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
	return 1;
}

- (void) viewDidLoad {
	self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
	textField.text = @"";
	[self setEditing:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
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
