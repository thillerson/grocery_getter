//
//  SettingsViewController.h
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/28/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GroceryGetterAppDelegate;

@interface SettingsViewController : UIViewController<UITableViewDataSource> {
	IBOutlet GroceryGetterAppDelegate *appDelegate;
	IBOutlet UITableView *tableView;
	IBOutlet UITableViewCell *tableViewCell;
	IBOutlet UISwitch *sortCompletedSwitch;
}

- (IBAction) done:(id)sender;
- (IBAction) sortCompletedSettingChanged:(id)sender;


@end
