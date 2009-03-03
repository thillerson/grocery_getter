//
//  GroceryListItem.h
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/23/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroceryListItem : ARBase {}

@property (readwrite, assign) NSString *title;
@property (readwrite, assign) NSNumber *position;
@property (readwrite, assign) NSNumber *complete;

- (void) toggleComplete;

@end