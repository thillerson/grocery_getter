//
//  IngredientsViewController.m
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "IngredientsViewController.h"
#import "GroceryGetterAppDelegate.h"
#import "GroceryGetterViewController.h"

@implementation IngredientsViewController

@synthesize ingredients;

- (void) setIngredients:(NSArray *)newIngredients {
	[ingredients release];
	ingredients = [newIngredients retain];
	[tableView reloadData];
}

- (void) removeIngredient:(NSString *)ingredientName {
	[recipesController removeIngredient:ingredientName forRecipe:self.title];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSInteger count = self.ingredients.count;
	if (self.editing) {
		count++;
	}
	return count;
}

- (void) setEditing:(BOOL)editing animated:(BOOL)animated {
	if (self.editing != editing) {
		[super setEditing:editing animated:animated];
		[tableView setEditing:editing animated:animated];
		NSArray *indexPaths = [NSArray arrayWithObject:
							   [NSIndexPath indexPathForRow:
							    self.ingredients.count inSection:0]];
		if (YES == editing) {
			[tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationLeft];
		} else {
			[tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
		}
	}
}

- (void) tableView:(UITableView *)tv commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete && indexPath.row < self.ingredients.count) {
		[self removeIngredient:[[tv cellForRowAtIndexPath:indexPath] text]];
		[tv deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}
}

- (void) tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row >= ingredients.count) {
		[recipesController displayAddNewIngredientsScreen:self.title];
	}
}

- (UITableViewCellEditingStyle) tableView:(UITableView *)tv editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row < [self.ingredients count]) {
		return UITableViewCellEditingStyleDelete;
	} else {
		return UITableViewCellEditingStyleInsert;
	}		
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:@"ingredientsCell"];
	if (nil == cell) {
		cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:nil];
	}
	
	if (indexPath.row < self.ingredients.count) {
		cell.text = [self.ingredients objectAtIndex:indexPath.row];
	} else {
		cell.text = @"Add New Ingredient";
		cell.textColor = [UIColor lightGrayColor];
		cell.hidesAccessoryWhenEditing = NO;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void) viewDidLoad {
	self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)dealloc {
    [super dealloc];
}


@end
