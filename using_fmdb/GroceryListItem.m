//
//  GroceryListItem.m
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/23/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GroceryListItem.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"

@implementation GroceryListItem

@synthesize pk, title, complete, position;

+ (NSArray *) findAllGroceryListItemsInOrderInDatabase:(FMDatabase *)db {
	FMResultSet *results = [db executeQuery:@"SELECT pk, title, complete, position FROM groceries ORDER BY complete, position"];
    if ([db hadError]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }
	NSMutableArray *list= [NSMutableArray array];
	while ([results next]) {
		GroceryListItem *item = [[GroceryListItem alloc] initWithDatabase:db];
		item.pk = [results intForColumn:@"pk"];
		item.title = [results stringForColumn:@"title"];
		item.complete = [results boolForColumn:@"complete"];
		item.position = [results intForColumn:@"position"];
		[list addObject:item];
		[item release];
	}
	[results close];
	
	// YE OLDE:
//	const char *sql = "SELECT pk, title, complete, position FROM groceries ORDER BY complete, position";
//	if (sqlite3_prepare_v2(db, sql, -1, &find_all_statement, NULL) != SQLITE_OK) {
//		NSAssert1(0, @"Failed to prepare find all list select statement: '%s'.", sqlite3_errmsg(db));
//	}
//	while (sqlite3_step(find_all_statement) == SQLITE_ROW) {
//		GroceryListItem *item = [[GroceryListItem alloc] initWithDatabase:db];
//		item.pk = sqlite3_column_int(find_all_statement, 0);
//		item.title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(find_all_statement, 1)];
//		int complete = sqlite3_column_int(find_all_statement, 2);
//		item.complete = [[NSNumber numberWithInt:complete] boolValue];
//		item.position = sqlite3_column_int(find_all_statement, 3);
//		[list addObject:item];
//		[item release];
//	}
	return list;
}

+ (NSArray *) findAllCompleteGroceryListItemsInOrderInDatabase:(FMDatabase *)db {
	FMResultSet *results = [db executeQuery:@"SELECT pk, title, complete, position FROM groceries WHERE complete=1 ORDER BY position"];
    if ([db hadError]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }
	NSMutableArray *list= [NSMutableArray array];
	while ([results next]) {
		GroceryListItem *item = [[GroceryListItem alloc] initWithDatabase:db];
		item.pk = [results intForColumn:@"pk"];
		item.title = [results stringForColumn:@"title"];
		item.complete = [results boolForColumn:@"complete"];
		item.position = [results intForColumn:@"position"];
		[list addObject:item];
		[item release];
	}
	[results close];
	return list;
}

+ (NSArray *) findAllIncompleteGroceryListItemsInOrderInDatabase:(FMDatabase *)db {
	FMResultSet *results = [db executeQuery:@"SELECT pk, title, complete, position FROM groceries WHERE complete=0 ORDER BY position"];
    if ([db hadError]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }
	NSMutableArray *list= [NSMutableArray array];
	while ([results next]) {
		GroceryListItem *item = [[GroceryListItem alloc] initWithDatabase:db];
		item.pk = [results intForColumn:@"pk"];
		item.title = [results stringForColumn:@"title"];
		item.complete = [results boolForColumn:@"complete"];
		item.position = [results intForColumn:@"position"];
		[list addObject:item];
		[item release];
	}
	[results close];
	return list;
}

#pragma mark -
#pragma mark Instance Methods

- (id) initWithDatabase:(FMDatabase *)db {
    if (self = [super init]) {
        database = [db retain];
    }
    return self;
}

- (void) create {
	[database beginTransaction];
	[database executeUpdate:@"INSERT INTO groceries (title, complete, position) VALUES(?, ?, ?)",
		title,
		[NSNumber numberWithBool:complete],
		[NSNumber numberWithInt:position]];
    [database commit];
    if ([database hadError]) {
        NSLog(@"Err %d: %@", [database lastErrorCode], [database lastErrorMessage]);
    }
	pk = [database lastInsertRowId];
	
	// OLD
//    if (insert_statement == nil) {
//        static char *sql = "INSERT INTO groceries (title, complete, position) VALUES(?, ?, ?)";
//        if (sqlite3_prepare_v2(database, sql, -1, &insert_statement, NULL) != SQLITE_OK) {
//			NSAssert1(0, @"Failed to prepare list insert statement: '%s'.", sqlite3_errmsg(database));
//        }
//    }
//    sqlite3_bind_text(insert_statement, 1, [title UTF8String], -1, SQLITE_TRANSIENT);
//	sqlite3_bind_int(insert_statement, 2, [[NSNumber numberWithBool:complete] intValue]);
//	sqlite3_bind_int(insert_statement, 3, position);
//    int success = sqlite3_step(insert_statement);
//    sqlite3_reset(insert_statement);
//    if (success == SQLITE_ERROR) {
//		NSAssert1(0, @"Failed to execute list insert statement: '%s'.", sqlite3_errmsg(database));
//    } else {
//        pk = sqlite3_last_insert_rowid(database);
//    }
	dirty = NO;
}

- (void) save {
	if (! dirty) {
		return;
	}
	
	[database beginTransaction];
	[database executeUpdate:@"UPDATE groceries SET title=?, complete=?, position=? WHERE pk=?",
		title,
		[NSNumber numberWithBool:complete],
		[NSNumber numberWithInt:position],
		[NSNumber numberWithInt:pk]];
    [database commit];
    if ([database hadError]) {
        NSLog(@"Err %d: %@", [database lastErrorCode], [database lastErrorMessage]);
    }
	//OLD
//    if (update_statement == nil) {
//        static char *sql = "UPDATE groceries SET title=?, complete=?, position=? WHERE pk=?";
//        if (sqlite3_prepare_v2(database, sql, -1, &update_statement, NULL) != SQLITE_OK) {
//			NSAssert1(0, @"Failed to prepare list update statement: '%s'.", sqlite3_errmsg(database));
//        }
//    }
//    sqlite3_bind_text(update_statement, 1, [title UTF8String], -1, SQLITE_TRANSIENT);
//	sqlite3_bind_int(update_statement, 2, [[NSNumber numberWithBool:complete] intValue]);
//	sqlite3_bind_int(update_statement, 3, position);
//	sqlite3_bind_int(update_statement, 4, pk);
//    int success = sqlite3_step(update_statement);
//    sqlite3_reset(update_statement);
//    if (success != SQLITE_DONE) {
//		NSAssert1(0, @"Failed to execute list update statement: '%s'.", sqlite3_errmsg(database));
//    }
	dirty = NO;
}

- (id) initWithTitle:(NSString *)t withDatabase:(FMDatabase *)db {
	if (self = [super init]) {
		title = [t copy];
		database = [db retain];
		[self create];
	}
	return self;
}

- (void) destroy {
	[database executeUpdate:@"DELETE FROM groceries WHERE pk=?",
		[NSNumber numberWithInt:pk]];
    if ([database hadError]) {
        NSLog(@"Err %d: %@", [database lastErrorCode], [database lastErrorMessage]);
    }
	//    if (delete_statement == nil) {
//        const char *sql = "DELETE FROM groceries WHERE pk=?";
//        if (sqlite3_prepare_v2(database, sql, -1, &delete_statement, NULL) != SQLITE_OK) {
//			NSAssert1(0, @"Failed to prepare list delete statement: '%s'.", sqlite3_errmsg(database));
//        }
//    }
//    sqlite3_bind_int(delete_statement, 1, pk);
//    int success = sqlite3_step(delete_statement);
//    sqlite3_reset(delete_statement);
//    if (success != SQLITE_DONE) {
//		NSAssert1(0, @"Failed to delete list item: '%s'.", sqlite3_errmsg(database));
//    }
}

- (void) toggleComplete {
	complete = !complete;
	[self save];
}

#pragma mark Properties

- (void)setTitle:(NSString *)aString {
    if ((!title && !aString) || (title && aString && [title isEqualToString:aString])) return;
    dirty = YES;
    [title release];
    title = [aString copy];
}

- (void)setPosition:(NSInteger)newPosition {
    if ((!position && !newPosition) || (position == newPosition)) return;
    dirty = YES;
	position = newPosition;
}

- (void)setComplete:(BOOL)isComplete {
    if ((complete == isComplete)) return;
    dirty = YES;
	complete = isComplete;
}


- (void)dealloc {
	[database release];
    [title release];
    [super dealloc];
}

@end

