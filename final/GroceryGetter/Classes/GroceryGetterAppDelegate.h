//
//  GroceryGetterAppDelegate.h
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/14/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GroceryGetterViewController;
@class IngredientsViewController;
@class NewIngredientViewController;

@interface GroceryGetterAppDelegate : NSObject <UIApplicationDelegate> {
	NSMutableDictionary *data;
    IBOutlet UIWindow *window;
    IBOutlet GroceryGetterViewController *recipesController;
	IBOutlet UINavigationController *navController;
	IBOutlet IngredientsViewController *ingredientsController;
	IBOutlet NewIngredientViewController *newIngredientController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) GroceryGetterViewController *recipesController;
@property (nonatomic, retain) NewIngredientViewController *newIngredientController;

@property (readonly) NSArray *recipes;

- (void) recipeClicked:(NSString *)recipeName;
- (void) addNewRecipeNamed:(NSString *)recipeName;
- (void) removeIngredient:(NSString *)ingredientName forRecipe:(NSString *)recipeName;
- (void) addIngredient:(NSString *)ingredientName forRecipe:(NSString *)recipeName;
- (void) displayAddNewIngredientsScreen:(NSString *)recipeName;

@end

