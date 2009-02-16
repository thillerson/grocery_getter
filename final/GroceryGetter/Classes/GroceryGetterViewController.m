//
//  GroceryGetterViewController.m
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/14/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "GroceryGetterAppDelegate.h"
#import "GroceryGetterViewController.h"
#import "AddRecipiesViewController.h"

@implementation GroceryGetterViewController

- (void) displayAddNewIngredientsScreen:(NSString *)recipeName {
	[appDelegate displayAddNewIngredientsScreen:recipeName];
}

- (void) addNewRecipeNamed:(NSString *)recipeName {
	[appDelegate addNewRecipeNamed:recipeName];
	[tableView reloadData];
}

- (void) addIngredient:(NSString *)ingredientName forRecipe:(NSString *)recipeName {
	[appDelegate addIngredient:ingredientName forRecipe:recipeName];
}
- (void) removeIngredient:(NSString *)ingredientName forRecipe:(NSString *)recipeName {
	[appDelegate removeIngredient:ingredientName forRecipe:recipeName];
}

- (IBAction) edit:(id)sender {
	[self presentModalViewController:addRecipesController animated:YES];
}

- (void) tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[appDelegate recipeClicked:[[tv cellForRowAtIndexPath:indexPath] text]];
	[tv deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:@"recipeCell"];
	if (nil == cell) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"recipeCell"] autorelease];
	}
	cell.text = [appDelegate.recipes objectAtIndex:indexPath.row];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}

- (NSInteger) tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
	return [appDelegate.recipes count];
}

- (void) viewDidLoad {
	[super viewDidLoad];
	self.navigationItem.rightBarButtonItem = 
		[[[UIBarButtonItem alloc] 
		  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
		  target:self
		  action:@selector(edit:)]
		 autorelease];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}

@end
