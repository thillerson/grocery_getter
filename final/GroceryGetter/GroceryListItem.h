//
//  GroceryListItem.h
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/23/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GroceryListItem : NSObject {
	NSInteger listItemId;
	NSString *title;
	BOOL complete;
}

@property (assign, nonatomic, readonly) NSInteger listItemId;
@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) BOOL complete;

- (GroceryListItem *) initWithTitle:(NSString *)t;
- (void) toggleComplete;


@end
