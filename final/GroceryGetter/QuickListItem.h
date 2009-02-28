//
//  QuickListItem.h
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface QuickListItem : NSObject {
	NSInteger listItemId;
	NSString *title;
	NSInteger position;
}

@property (assign, nonatomic, readonly) NSInteger listItemId;
@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) NSInteger position;

@end
