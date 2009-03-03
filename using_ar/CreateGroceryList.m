//
//  CreateGroceryList.m
//  GroceryGetter
//
//  Created by Tony Hillerson on 3/2/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "CreateGroceryList.h"
#import "FmdbMigrationColumn.h"

@implementation CreateGroceryList

- (void) up {
	[self createTable:@"grocery_list_items" withColumns:[NSArray arrayWithObjects:
			[FmdbMigrationColumn columnWithColumnName:@"title" columnType:@"text"],
			[FmdbMigrationColumn columnWithColumnName:@"position" columnType:@"integer"],
			[FmdbMigrationColumn columnWithColumnName:@"complete" columnType:@"integer" defaultValue:[NSNumber numberWithInt:0]],
			nil]];
}

- (void) down {
	// unsupported
}

@end
