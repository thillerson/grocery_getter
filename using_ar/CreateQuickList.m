//
//  CreateQuickList.m
//  GroceryGetter
//
//  Created by Tony Hillerson on 3/2/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "CreateQuickList.h"
#import "FmdbMigrationColumn.h"
#import "QuickListItem.h"

@implementation CreateQuickList
- (void) up {
	[self createTable:@"quick_list_items" withColumns:[NSArray arrayWithObjects:
		[FmdbMigrationColumn columnWithColumnName:@"title" columnType:@"text"],
		[FmdbMigrationColumn columnWithColumnName:@"position" columnType:@"integer"],
		nil]];
	[QuickListItem createWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:@"Milk", @"title",
										 @"0", @"position", nil]];
	[QuickListItem createWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:@"Bread", @"title",
										 @"1", @"position", nil]];
	[QuickListItem createWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:@"Cereal", @"title",
										 @"2", @"position", nil]];
	[QuickListItem createWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:@"Fruit", @"title",
										 @"3", @"position", nil]];
	[QuickListItem createWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:@"Bottled Water", @"title",
										 @"4", @"position", nil]];
}

- (void) down {
	// unsupported
}

@end
