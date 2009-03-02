//
//  SettingsViewController.m
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/28/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import "GroceryGetterAppDelegate.h"

@implementation SettingsViewController

- (IBAction) done:(id)sender{
	[appDelegate settingsViewDone];
}

- (IBAction) sortCompletedSettingChanged:(id)sender {
	NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
	[settings setBool:sortCompletedSwitch.on forKey:@"shouldSortAfterComplete"];
	[NSUserDefaults resetStandardUserDefaults];
}

#pragma mark Table Data Source Methods

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingsItem"];
    if (cell == nil) {
        cell = tableViewCell;
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    return cell;
}


#pragma mark Standard Methods

- (void)viewWillAppear:(BOOL)animated {
	NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
	sortCompletedSwitch.on = [settings boolForKey:@"shouldSortAfterComplete"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}


@end
