//
//  AddGroceryListItem.m
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/21/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GroceryGetterAppDelegate.h"
#import "AddGroceryListItemViewController.h"

@implementation AddGroceryListItemViewController

#pragma mark Table Data Source Methods

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
	return 1; // just the editing cell
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"editListItemCell"];
    if (cell == nil) {
        cell = tableViewCell;
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}


@end
