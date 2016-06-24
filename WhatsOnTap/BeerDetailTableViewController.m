//
//  BeerDetailTableViewController.m
//  WhatsOnTap
//
//  Created by Srinivas Bodhanampati on 6/24/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "BeerDetailTableViewController.h"
#import "Beer.h"
@import Firebase;
@import FirebaseDatabase;

@interface BeerDetailTableViewController ()
@property (strong, nonatomic) NSMutableArray *beerArray;
@end

@implementation BeerDetailTableViewController

- (void)viewDidLoad {
    self.navigationItem.title = @"Beer List";
    [self getBeersFromDatabase];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_beerArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"beerCell" forIndexPath:indexPath];
    
    // Configure the cell...
    Beer *beerInCell = [_beerArray objectAtIndex:indexPath.row];
    cell.textLabel.text = beerInCell.beerName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Beer *beerInSelectedRow = [_beerArray objectAtIndex:indexPath.row];
    [self addBeerToEstablishmentDatabase:beerInSelectedRow.uid];
    [self addUpdateToDatabaseWithBeerName:beerInSelectedRow.beerName andEstablishmentName:_linkedEstablishment.establishmentName andUpdateType:@"beer_added"];

}

- (void)getBeersFromDatabase {
    _beerArray = [[NSMutableArray alloc] init];
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    FIRDatabaseReference *beersRef = [ref child:@"beers"];
    
    [beersRef observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot *snapshot) {
        Beer *newBeer = [[Beer alloc] init];
        for (FIRDataSnapshot *child in snapshot.children) {
            
            newBeer.uid = snapshot.key;
            
            if ([child.key isEqualToString:@"beer_name"]) {
                newBeer.beerName = child.value;
            }
        }
        [_beerArray addObject:newBeer];
        [self.tableView reloadData];
    }];
}

- (void)addBeerToEstablishmentDatabase:(NSString *)beerID {
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    FIRDatabaseReference *establishmentRef = [ref child:[NSString stringWithFormat:@"establishments/%@", _linkedEstablishment.uid]];
    FIRDatabaseReference *beersRef = [establishmentRef child:@"beers"];
    [beersRef updateChildValues:@{[NSString stringWithFormat:@"%@", beerID]: @"true"}];
}

- (void)addUpdateToDatabaseWithBeerName:(NSString *)beerName andEstablishmentName:(NSString *)establishmentName andUpdateType:(NSString *)updateType {
    NSDictionary *updateInfo = @{@"establishment": establishmentName, @"beer": beerName, @"update_type": updateType, @"updateTime": [NSString stringWithFormat:@"%@", [NSDate date]]};
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    FIRDatabaseReference *updateRef = [ref child:@"updates"].childByAutoId;
    [updateRef setValue:updateInfo];
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

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row%2 == 0) {
        UIColor *altCellColor = [UIColor colorWithRed:0.27 green:0.65 blue:0.95 alpha:1.0];         cell.backgroundColor = altCellColor;
    }
    else{
        
        cell.backgroundColor = [UIColor whiteColor];
    }
}
@end
