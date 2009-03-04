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
	[self createTable:@"quick_list" withColumns:[NSArray arrayWithObjects:
		[FmdbMigrationColumn columnWithColumnName:@"id" columnType:@"INTEGER PRIMARY KEY AUTOINCREMENT"],
		[FmdbMigrationColumn columnWithColumnName:@"title" columnType:@"text"],
		[FmdbMigrationColumn columnWithColumnName:@"position" columnType:@"integer"],
		nil]];
	[[QuickListItem alloc] initWithTitle:@"Milk" withDatabase:self.db];
	[[QuickListItem alloc] initWithTitle:@"Bread" withDatabase:self.db];
	[[QuickListItem alloc] initWithTitle:@"Cereal" withDatabase:self.db];
	[[QuickListItem alloc] initWithTitle:@"Fruit" withDatabase:self.db];
	[[QuickListItem alloc] initWithTitle:@"Bottled Water" withDatabase:self.db];
}

- (void) down {
	// unsupported
}

@end
