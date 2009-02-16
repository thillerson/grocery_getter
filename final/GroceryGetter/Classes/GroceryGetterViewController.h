//
//  GroceryGetterViewController.h
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/14/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GroceryGetterAppDelegate;
@class AddRecipiesViewController;

@interface GroceryGetterViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	IBOutlet GroceryGetterAppDelegate *appDelegate;
	IBOutlet AddRecipiesViewController *addRecipesController;
	IBOutlet UITableView *tableView;
}

- (IBAction) edit:(id)sender;
- (void) addNewRecipeNamed:(NSString *)recipeName;
- (void) addIngredient:(NSString *)ingredientName forRecipe:(NSString *)recipeName;
- (void) removeIngredient:(NSString *)ingredientName forRecipe:(NSString *)recipeName;
- (void) displayAddNewIngredientsScreen:(NSString *)recipeName;

@end

