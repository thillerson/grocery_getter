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
@class FMDatabase;

@interface GroceryGetterAppDelegate : NSObject <UIApplicationDelegate> {
	FMDatabase *db;
	NSMutableArray *fullGroceryList;
	NSMutableArray *incompleteGroceryList;
	NSMutableArray *completeGroceryList;
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
@property (nonatomic, retain) NSMutableArray *fullGroceryList;
@property (nonatomic, retain) NSMutableArray *incompleteGroceryList;
@property (nonatomic, retain) NSMutableArray *completeGroceryList;
@property (nonatomic, retain) NSMutableArray *quickAddList;

- (void) addItemToList:(NSString *)title;
- (void) addItemsToList:(NSArray *)newItems;
- (void) deleteItemAtIndex:(NSInteger)index;
- (void) groceryListOrderDidChange;
- (void) reloadGroceryList;
- (void) deleteQuickListItemAtIndex:(NSInteger)index;
- (void) addItemToQuickList:(NSString *)title;
- (void) quickListOrderDidChange;

- (void) settingsViewDone;
- (void) showAddItemView;
- (void) showEditItemViewForItem:(GroceryListItem *)item;
- (IBAction) doneEditingItem;
- (IBAction) showSettingsView:(id)sender;
- (IBAction) showQuickAdd:(id)sender;


@end

