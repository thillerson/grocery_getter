//
//  IngredientsViewController.h
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GroceryGetterAppDelegate;
@class GroceryGetterViewController;

@interface IngredientsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	NSArray *ingredients;
	IBOutlet UITableView *tableView;
	IBOutlet GroceryGetterAppDelegate *appDelegate;
	IBOutlet GroceryGetterViewController *recipesController;
}

@property (nonatomic, retain) NSArray *ingredients;

@end
