//
//  QuickListItem.m
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "QuickListItem.h"


@implementation QuickListItem

@synthesize listItemId, title, position;

- (QuickListItem *) initWithTitle:(NSString *)t {
	if (self = [super init]) {
		title = [t copy];
	}
	return self;
}


@end
