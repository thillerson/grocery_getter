//
//  GroceryListItem.m
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/23/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GroceryListItem.h"

static sqlite3_stmt *find_all_statement = nil;
static sqlite3_stmt *insert_statement = nil;
static sqlite3_stmt *update_statement = nil;
static sqlite3_stmt *delete_statement = nil;

@implementation GroceryListItem

@synthesize pk, title, complete, position;

+ (void) deletePreparedStatements {
    if (find_all_statement) {
        sqlite3_finalize(find_all_statement);
        find_all_statement = nil;
    }
    if (insert_statement) {
        sqlite3_finalize(insert_statement);
        insert_statement = nil;
    }
    if (update_statement) {
        sqlite3_finalize(update_statement);
        update_statement = nil;
    }
    if (delete_statement) {
        sqlite3_finalize(delete_statement);
        delete_statement = nil;
    }
}

+ (NSArray *) findAllGroceryListItemsInOrderInDatabase:(sqlite3 *)db {
	const char *sql = "SELECT pk, title, complete, position FROM groceries ORDER BY complete, position";
	if (sqlite3_prepare_v2(db, sql, -1, &find_all_statement, NULL) != SQLITE_OK) {
		NSAssert1(0, @"Failed to prepare find all list select statement: '%s'.", sqlite3_errmsg(db));
	}
	NSMutableArray *list= [NSMutableArray array];
	while (sqlite3_step(find_all_statement) == SQLITE_ROW) {
		GroceryListItem *item = [[GroceryListItem alloc] initWithDatabase:db];
		item.pk = sqlite3_column_int(find_all_statement, 0);
		item.title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(find_all_statement, 1)];
		int complete = sqlite3_column_int(find_all_statement, 2);
		item.complete = [[NSNumber numberWithInt:complete] boolValue];
		item.position = sqlite3_column_int(find_all_statement, 3);
		[list addObject:item];
		[item release];
	}
	return list;
}

#pragma mark Instance Methods

- (id) initWithDatabase:(sqlite3 *)db {
    if (self = [super init]) {
        database = db;
    }
    return self;
}

- (void) create {
    if (insert_statement == nil) {
        static char *sql = "INSERT INTO groceries (title, complete, position) VALUES(?, ?, ?)";
        if (sqlite3_prepare_v2(database, sql, -1, &insert_statement, NULL) != SQLITE_OK) {
			NSAssert1(0, @"Failed to prepare list insert statement: '%s'.", sqlite3_errmsg(database));
        }
    }
    sqlite3_bind_text(insert_statement, 1, [title UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_int(insert_statement, 2, [[NSNumber numberWithBool:complete] intValue]);
	sqlite3_bind_int(insert_statement, 3, position);
    int success = sqlite3_step(insert_statement);
    sqlite3_reset(insert_statement);
    if (success == SQLITE_ERROR) {
		NSAssert1(0, @"Failed to execute list insert statement: '%s'.", sqlite3_errmsg(database));
    } else {
        pk = sqlite3_last_insert_rowid(database);
    }
	dirty = NO;
}

- (void) save {
	if (! dirty) {
		return;
	}
    if (update_statement == nil) {
        static char *sql = "UPDATE groceries SET title=?, complete=?, position=? WHERE pk=?";
        if (sqlite3_prepare_v2(database, sql, -1, &update_statement, NULL) != SQLITE_OK) {
			NSAssert1(0, @"Failed to prepare list update statement: '%s'.", sqlite3_errmsg(database));
        }
    }
    sqlite3_bind_text(update_statement, 1, [title UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_int(update_statement, 2, [[NSNumber numberWithBool:complete] intValue]);
	sqlite3_bind_int(update_statement, 3, position);
	sqlite3_bind_int(update_statement, 4, pk);
    int success = sqlite3_step(update_statement);
    sqlite3_reset(update_statement);
    if (success != SQLITE_DONE) {
		NSAssert1(0, @"Failed to execute list update statement: '%s'.", sqlite3_errmsg(database));
    }
	dirty = NO;
}

- (id) createWithTitle:(NSString *)t withDatabase:(sqlite3 *)db {
	if (self = [super init]) {
		title = [t copy];
	}
	return self;
}

- (void) destroy {
    if (delete_statement == nil) {
        const char *sql = "DELETE FROM groceries WHERE pk=?";
        if (sqlite3_prepare_v2(database, sql, -1, &delete_statement, NULL) != SQLITE_OK) {
			NSAssert1(0, @"Failed to prepare list delete statement: '%s'.", sqlite3_errmsg(database));
        }
    }
    sqlite3_bind_int(delete_statement, 1, pk);
    int success = sqlite3_step(delete_statement);
    sqlite3_reset(delete_statement);
    if (success != SQLITE_DONE) {
		NSAssert1(0, @"Failed to delete list item: '%s'.", sqlite3_errmsg(database));
    }
}

- (void) toggleComplete {
	complete = !complete;
	[self save];
}

- (void)dealloc {
    [title release];
    [super dealloc];
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


@end
