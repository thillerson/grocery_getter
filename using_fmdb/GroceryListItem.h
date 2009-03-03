//
//  GroceryListItem.h
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/23/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@class FMDatabase;

@interface GroceryListItem : NSObject {
    // The object keeps track of the database it came from.
    FMDatabase *database;
	NSInteger pk;
	NSString *title;
	BOOL complete;
	NSInteger position;
	BOOL dirty;
}

@property (assign, nonatomic) NSInteger pk;
@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) NSInteger position;
@property (assign, nonatomic) BOOL complete;

+ (NSArray *) findAllGroceryListItemsInOrderInDatabase:(FMDatabase *)db;
+ (NSArray *) findAllCompleteGroceryListItemsInOrderInDatabase:(FMDatabase *)db;
+ (NSArray *) findAllIncompleteGroceryListItemsInOrderInDatabase:(FMDatabase *)db;

- (id) initWithDatabase:(FMDatabase *)db;
- (id) initWithTitle:(NSString *)t withDatabase:(FMDatabase *)db;
- (void) create;
- (void) save;
- (void) destroy;
- (void) toggleComplete;

@end
