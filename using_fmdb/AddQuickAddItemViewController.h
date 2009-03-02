//
//  AddQuickAddItemViewController.h
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/28/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GroceryGetterAppDelegate;
@class QuickListItem;

@interface AddQuickAddItemViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
	IBOutlet GroceryGetterAppDelegate *appDelegate;
	IBOutlet UITableView *tableView;
	IBOutlet UITableViewCell *tableCell;
	IBOutlet UITextField *textField;
	QuickListItem *itemToEdit;
}

@property (nonatomic, retain) QuickListItem *itemToEdit;

- (IBAction) cancel:(id)sender;
- (IBAction) save:(id)sender;

@end
