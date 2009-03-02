//
//  GroceryGetterAppDelegate.h
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/21/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@class GroceryListViewController;
@class AddGroceryListItemViewController;
@class QuickAddViewController;
@class GroceryListItem;
@class QuickListItem;
@class SettingsViewController;

@interface GroceryGetterAppDelegate : NSObject <UIApplicationDelegate> {
	sqlite3 *db;
	NSMutableArray *currentGroceryList;
	NSMutableArray *quickAddList;
    UIWindow *window;
	UINavigationController *navigationController;
	IBOutlet UIToolbar *toolbar;
    GroceryListViewController *groceryListController;
	AddGroceryListItemViewController *addListItemController;
	IBOutlet SettingsViewController *settingsViewController;
	IBOutlet QuickAddViewController *quickAddViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet GroceryListViewController *groceryListController;
@property (nonatomic, retain) IBOutlet AddGroceryListItemViewController *addListItemController;
@property (nonatomic, retain) NSMutableArray *currentGroceryList;
@property (nonatomic, retain) NSMutableArray *quickAddList;

- (void) addItemToList:(GroceryListItem *)newItem;
- (void) addItemsToList:(NSArray *)newItems;
- (void) addItemToQuickList:(NSString *)title;
- (void) quickListOrderDidChange;
- (void) updateItem:(GroceryListItem *)item atIndex:(NSInteger)index;
- (void) deleteItemAtIndex:(NSInteger)index;
- (void) deleteQuickListItemAtIndex:(NSInteger)index;

- (void) settingsViewDone;
- (void) showAddItemView;
- (void) showEditItemViewForItem:(GroceryListItem *)item;
- (IBAction) doneEditingItem;
- (IBAction) showSettingsView:(id)sender;
- (IBAction) showQuickAdd:(id)sender;


@end

