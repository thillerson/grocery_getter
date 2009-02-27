//
//  QuickAddViewController.h
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GroceryGetterAppDelegate;

@interface QuickAddViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	IBOutlet UITableView *tableView;
	IBOutlet GroceryGetterAppDelegate *appDelegate;
}

@end
