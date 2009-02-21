//
//  MainViewController.h
//  GroceryGetter
//
//  Created by Tony Hillerson on 2/16/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GroceryListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    IBOutlet UITableView *tableView;
}

@end
