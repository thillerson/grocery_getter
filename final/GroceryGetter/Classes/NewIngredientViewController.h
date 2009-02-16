//
//  NewIngredientViewController.h
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GroceryGetterViewController;

@interface NewIngredientViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	NSString *recipeName;
	IBOutlet UITextField *textField;
	IBOutlet UITableViewCell *textFieldCell;
	IBOutlet GroceryGetterViewController *recipesController;
}

@property (nonatomic, retain) GroceryGetterViewController *recipesController;
@property (nonatomic, retain) NSString *recipeName;

@end
