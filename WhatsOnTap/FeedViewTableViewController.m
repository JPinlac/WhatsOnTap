//
//  FeedViewTableViewController.m
//  WhatsOnTap
//
//  Created by Brandon Manson on 6/23/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "FeedViewTableViewController.h"
@import Firebase;
@import FirebaseDatabase;

@interface FeedViewTableViewController ()

@end

@implementation FeedViewTableViewController

- (void)viewDidLoad {
    
    self.navigationItem.title = @"Feed List";
    [self getUpdatesFromDatabase];
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)getUpdatesFromDatabase {
    if (_updates == nil) {
        _updates = [[NSMutableArray alloc] init];
    }
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    FIRDatabaseReference *updatesRef = [ref child:@"updates"];
    
    [updatesRef observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot *snapshot) {
        Update *update = [[Update alloc]init];
        for (FIRDataSnapshot *child in snapshot.children) {
            if ([child.key isEqualToString:@"beer"]) {
                update.beerName = child.value;
            }
            if ([child.key isEqualToString:@"establishment"]) {
                update.establishmentName = child.value;
            }
            if ([child.key isEqualToString:@"update_time"]) {
                NSDate *date;
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd' 'HH:mm:ss' 'ZZZZ"];
                date = [dateFormatter dateFromString:child.value];
                update.updateTime = date;
                NSLog(@"%@ date: %@", update.beerName, update.updateTime);
            }
        }
        [_updates addObject:update];
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_updates count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"updateCell" forIndexPath:indexPath];
    Update *updateInCell = [_updates objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ on tap at %@", updateInCell.beerName, updateInCell.establishmentName];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row%2 == 0) {
        UIColor *altCellColor = [UIColor colorWithRed:0.27 green:0.65 blue:0.95 alpha:1.0];         cell.backgroundColor = altCellColor;
    }
    else{
        
        cell.backgroundColor = [UIColor whiteColor];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//- (IBAction)refreshTableView:(UIRefreshControl *)sender {
//    
//    [_updates requestData:^{
//        [self.tableView reloadData];
//        
//        [sender endRefreshing];
//    }];
//}

@end
