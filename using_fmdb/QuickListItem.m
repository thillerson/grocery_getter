//
//  QuickListItem.m
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "QuickListItem.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"

@implementation QuickListItem

@synthesize pk, title, position;

#pragma mark -
#pragma mark Class Methods

+ (NSArray *) findAllQuickListItemsInOrderInDatabase:(FMDatabase *)db {
	FMResultSet *results = [db executeQuery:@"SELECT pk, title, position FROM quick_list ORDER BY position"];
    if ([db hadError]) {
        NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
    }
	NSMutableArray *list= [NSMutableArray array];
	while ([results next]) {
		QuickListItem *item = [[QuickListItem alloc] initWithDatabase:db];
		item.pk = [results intForColumn:@"pk"];
		item.title = [results stringForColumn:@"title"];
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

- (id) initWithTitle:(NSString *)t withDatabase:(FMDatabase *)db {
	if (self = [super init]) {
		title = [t copy];
		position = 0;
		database = [db retain];
		[self create];
	}
	return self;
}

- (void) create {
	[database beginTransaction];
	[database executeUpdate:@"INSERT INTO quick_list (title, position) VALUES(?, ?)",
		title,
		[NSNumber numberWithInt:position]];
    [database commit];
    if ([database hadError]) {
        NSLog(@"Err %d: %@", [database lastErrorCode], [database lastErrorMessage]);
    }
	pk = [database lastInsertRowId];
	dirty = NO;
}

- (void) save {
	if (! dirty) {
		return;
	}
	[database beginTransaction];
	[database executeUpdate:@"UPDATE quick_list SET title=?, position=? WHERE pk=?",
	 title,
	 [NSNumber numberWithInt:position],
	[NSNumber numberWithInt:pk]];
    [database commit];
    if ([database hadError]) {
        NSLog(@"Err %d: %@", [database lastErrorCode], [database lastErrorMessage]);
    }
	dirty = NO;
}

- (void) destroy {
	[database beginTransaction];
	[database executeUpdate:@"DELETE FROM groceries WHERE pk=?",
	 [NSNumber numberWithInt:pk]];
    [database commit];
    if ([database hadError]) {
        NSLog(@"Err %d: %@", [database lastErrorCode], [database lastErrorMessage]);
    }
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

- (void)dealloc {
	[database release];
    [title release];
    [super dealloc];
}

@end
