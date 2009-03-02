//
//  QuickListItem.h
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface QuickListItem : NSObject {
	NSInteger pk;
	NSString *title;
	NSInteger position;
    // The object keeps track of the database it came from.
    sqlite3 *database;
    BOOL dirty;
    NSData *data;
}

@property (assign, nonatomic) NSInteger pk;
@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) NSInteger position;

+ (void) deletePreparedStatements;
+ (NSArray *) findAllQuickListItemsInOrderInDatabase:(sqlite3 *)db;

- (id) initWithDatabase:(sqlite3 *)db;
- (id) createWithTitle:(NSString *)t withDatabase:(sqlite3 *)db;
- (void) create;
- (void) save;
- (void) destroy;

@end
