//
//  FeedViewTableViewController.h
//  WhatsOnTap
//
//  Created by Brandon Manson on 6/23/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Update.h"

@interface FeedViewTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *updates;

- (void)getUpdatesFromDatabase;

@end
