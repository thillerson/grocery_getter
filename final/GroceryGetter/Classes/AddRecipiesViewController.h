//
//  AddRecipiesViewController.h
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GroceryGetterViewController;

@interface AddRecipiesViewController : UIViewController <UITableViewDataSource> {
	IBOutlet UITextField *textField;
	IBOutlet UITableViewCell *textFieldCell;
	IBOutlet GroceryGetterViewController *recipesController;
}

- (IBAction) save:(id)sender;
- (IBAction) cancel:(id)sender;

@end
