//
//  QuickListItem.h
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@class FMDatabase;

@interface QuickListItem : NSObject {
    // The object keeps track of the database it came from.
    FMDatabase *database;
	NSInteger pk;
	NSString *title;
	NSInteger position;
    BOOL dirty;
    NSData *data;
}

@property (assign, nonatomic) NSInteger pk;
@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) NSInteger position;

+ (NSArray *) findAllQuickListItemsInOrderInDatabase:(FMDatabase *)db;

- (id) initWithDatabase:(FMDatabase *)db;
- (id) initWithTitle:(NSString *)t withDatabase:(FMDatabase *)db;
- (void) create;
- (void) save;
- (void) destroy;

@end
