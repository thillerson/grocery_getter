//
//  AddGroceryListItem.h
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/21/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GroceryGetterAppDelegate;

@interface AddGroceryListItemViewController : UIViewController <UITableViewDataSource, UITextFieldDelegate> {
	IBOutlet GroceryGetterAppDelegate *appDelegate;
	IBOutlet UITableView *tableView;
	IBOutlet UITableViewCell *tableViewCell;
	IBOutlet UITextField *textField;
}

@end
