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
	[self createTable:@"groceries" withColumns:[NSArray arrayWithObjects:
			[FmdbMigrationColumn columnWithColumnName:@"pk" columnType:@"integer"],
			[FmdbMigrationColumn columnWithColumnName:@"title" columnType:@"text"],
			[FmdbMigrationColumn columnWithColumnName:@"position" columnType:@"integer"],
			[FmdbMigrationColumn columnWithColumnName:@"complete" columnType:@"integer"],
			nil]];
}

- (void) down {
	// unsupported
}

@end
