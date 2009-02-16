//
//  GroceryGetterAppDelegate.m
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/14/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "GroceryGetterAppDelegate.h"
#import "GroceryGetterViewController.h"
#import "IngredientsViewController.h"
#import "NewIngredientViewController.h"

@implementation GroceryGetterAppDelegate

@synthesize window;
@synthesize recipesController;
@synthesize recipes;
@synthesize newIngredientController;

- (void) displayAddNewIngredientsScreen:(NSString *)recipeName {
	newIngredientController.recipeName = recipeName;
	[navController pushViewController:newIngredientController animated:YES];
}

- (void) addNewRecipeNamed:(NSString *)recipeName {
	[data setValue:[NSMutableArray array] forKey:recipeName];
}

- (void) addIngredient:(NSString *)ingredientName forRecipe:(NSString *)recipeName {
	[[data valueForKey:recipeName] addObject:ingredientName];
}

- (void) removeIngredient:(NSString *)ingredientName forRecipe:(NSString *)recipeName {
	[[data valueForKey:recipeName] removeObject:ingredientName];
}

- (NSArray *) recipes {
	return [data allKeys];
}

- (void) createDefaultData {
	data = [[NSMutableDictionary dictionary] retain];
	[data setValue:[NSMutableArray arrayWithObjects:@"Crust", @"Cherries", @"Sugar", nil] forKey:@"Cherry Pie"];
	[data setValue:[NSMutableArray arrayWithObjects:@"Cereal", @"Milk", nil] forKey:@"Cereal"];
	[data setValue:[NSMutableArray arrayWithObjects:@"Cereal", @"Milk", @"Maybe some fruit", nil] forKey:@"More Cereal"];
}

- (NSArray *)ingredientsForRecipe:(NSString *)recipeName {
	NSArray *ingredients = [data valueForKey:recipeName];
	return ingredients;
}

- (void) recipeClicked:(NSString *)recipeName {
	ingredientsController.ingredients = [self ingredientsForRecipe:recipeName];
	ingredientsController.title = recipeName;
	[navController pushViewController:ingredientsController	animated:YES];
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	navController.viewControllers = [NSArray arrayWithObject:recipesController];
    
    [window addSubview:navController.view];
    [window makeKeyAndVisible];
	[self createDefaultData];
}


- (void)dealloc {
    [recipesController release];
    [window release];
    [super dealloc];
}


@end
