//
//  GroceryListItem.m
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/23/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GroceryListItem.h"

@implementation GroceryListItem

@dynamic title, position, complete;

- (void) toggleComplete {
	if ([self.complete isEqualToNumber:[NSNumber numberWithInt:0]]) {
		self.complete = [NSNumber numberWithInt:1];
	} else {
		self.complete = [NSNumber numberWithInt:0];
	}
}

@end

