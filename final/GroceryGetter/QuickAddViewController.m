//
//  QuickAddViewController.m
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "QuickAddViewController.h"
#import "GroceryGetterAppDelegate.h"

@implementation QuickAddViewController

- (void) doneChoosingItems {
	[appDelegate doneEditingItem];
}

#pragma mark Table Data Source Methods

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
	return [appDelegate.currentGroceryList count];
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"quickAddItem"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"quickAddItem"] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    cell.text = @"Foo";
    return cell;
}

#pragma mark Standard Methods

- (void) viewDidLoad {
	[super viewDidLoad];
	self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:appDelegate action:@selector(doneEditingItem)] autorelease];
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneChoosingItems)] autorelease];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}


@end
