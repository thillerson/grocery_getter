//
//  GroceryListItem.m
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/23/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GroceryListItem.h"


@implementation GroceryListItem

@synthesize listItemId;
@synthesize title;
@synthesize complete;

- (GroceryListItem *) initWithTitle:(NSString *)t {
	if (self = [super init]) {
		title = [t copy];
	}
	return self;
}

- (void) toggleComplete {
	complete = !complete;
}

@end
