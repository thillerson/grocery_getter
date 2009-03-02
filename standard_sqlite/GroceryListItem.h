//
//  GroceryListItem.h
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/23/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface GroceryListItem : NSObject {
    // The object keeps track of the database it came from.
    sqlite3 *database;
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

+ (void) deletePreparedStatements;
+ (NSArray *) findAllGroceryListItemsInOrderInDatabase:(sqlite3 *)db;
+ (NSArray *) findAllCompleteGroceryListItemsInOrderInDatabase:(sqlite3 *)db;
+ (NSArray *) findAllIncompleteGroceryListItemsInOrderInDatabase:(sqlite3 *)db;

- (id) initWithDatabase:(sqlite3 *)db;
- (id) createWithTitle:(NSString *)t withDatabase:(sqlite3 *)db;
- (void) create;
- (void) save;
- (void) destroy;
- (void) toggleComplete;

@end
