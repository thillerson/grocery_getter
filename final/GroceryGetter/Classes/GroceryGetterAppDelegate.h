//
//  GroceryGetterAppDelegate.h
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/21/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GroceryListViewController;
@class AddGroceryListItemViewController;
@class GroceryListItem;

@interface GroceryGetterAppDelegate : NSObject <UIApplicationDelegate> {
	NSMutableArray *currentGroceryList;
    UIWindow *window;
	UINavigationController *navigationController;
	IBOutlet UIToolbar *toolbar;
    GroceryListViewController *groceryListController;
	AddGroceryListItemViewController *addListItemController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet GroceryListViewController *groceryListController;
@property (nonatomic, retain) IBOutlet AddGroceryListItemViewController *addListItemController;
@property (nonatomic, retain) NSMutableArray *currentGroceryList;

- (void) addItemToList:(GroceryListItem *)newItem;
- (void) updateItem:(GroceryListItem *)item atIndex:(NSInteger)index;
- (void) deleteItemAtIndex:(NSInteger)index;

- (IBAction) doneEditingItem;
- (void) showAddItemView;
- (IBAction) showQuickAddList;
- (IBAction) showSettingsView;

@end

