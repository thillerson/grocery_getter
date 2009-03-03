//
//  QuickListItem.h
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/27/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuickListItem : ARBase {}

@property (readwrite, assign) NSString *title;
@property (readwrite, assign) NSNumber *position;

@end
