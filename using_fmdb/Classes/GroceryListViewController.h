//
//  GroceryGetterViewController.h
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/21/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GroceryGetterAppDelegate;

@interface GroceryListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	BOOL sortAfterComplete;
	IBOutlet GroceryGetterAppDelegate *appDelegate;
	IBOutlet UITableView *tableView;
}

@end

