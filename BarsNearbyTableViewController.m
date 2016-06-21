//
//  BarsNearbyTableViewController.m
//  WhatsOnTap
//
//  Created by Sarmila on 6/21/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "BarsNearbyTableViewController.h"
#import "GooglePlacesClientViewController.h"
@import GoogleMaps;
#import "EstablishmentDetailViewController.h"


@interface BarsNearbyTableViewController ()
@property(nonatomic, strong) IBOutlet UITableView *tableView;
@property(nonatomic) NSMutableArray *establishmentsArray;
@end

@implementation BarsNearbyTableViewController{
    GMSPlacesClient *_placesClient;
    GMSPlacePicker *_placePicker;
}

- (void)viewDidLoad {
    [self listEstablishments];
    [super viewDidLoad];
    NSLog(@"Establi: %@",_establishmentsArray);

    [self getCurrentInfo];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void) getCurrentInfo{
    _placesClient = [GMSPlacesClient sharedClient];
    [_placesClient currentPlaceWithCallback:^(GMSPlaceLikelihoodList *placeLikelihoodList, NSError *error){
        // NSLog(@"inside the currentPlaceWithCallback block");
        if (error != nil) {
            NSLog(@"Pick Place error %@", [error localizedDescription]);
            return;
        } else {
            NSLog(@"Error: %@", error.localizedDescription);
        }
        
        
        if (placeLikelihoodList != nil) {
            GMSPlace *place = [[[placeLikelihoodList likelihoods] firstObject] place];
            if (place != nil) {
                NSLog(@"Longitute %f\nLatitude %f", place.coordinate.longitude, place.coordinate.latitude);
                _currentLocation = place.coordinate;
                
            }
        }
    }];
}


- (IBAction)addEstablishmentBarButton:(UIBarButtonItem *)sender {
    [self Establishments];
}

-(void) Establishments {
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    FIRDatabaseReference *establishmentRef = [ref child:@"establishments"].childByAutoId;
 //   NSLog(@"%@",establishmentRef.key);
    
    NSDictionary *newEstablishmentInfo = [NSDictionary dictionaryWithObjectsAndKeys:@"HopCat", @"establishment_name", @"elocation", @"location", nil];
    [establishmentRef setValue:newEstablishmentInfo];
    
}


-(void)listEstablishments {
    _establishmentsArray = [[NSMutableArray alloc]init];
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    FIRDatabaseReference *establishmentRef = [ref child:@"establishments"];
    
    [establishmentRef observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot *snapshot) {
        for (FIRDataSnapshot *child in snapshot.children) {
            if ([child.key isEqualToString:@"establishment_name"]) {
                [_establishmentsArray addObject:child.value];
            }
        }
        NSLog(@"establishment: %@",_establishmentsArray.description);
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%lu", [_establishmentsArray count]);
    return [_establishmentArray count];
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"establishmentCell" forIndexPath:indexPath];
 
 // Configure the cell...
     UIImage *image1 = [UIImage imageNamed:@"beer-icon"];
     cell.imageView.image = image1;
     
     cell.textLabel.text = [_establishmentArray objectAtIndex:indexPath.row];
     
     return cell;
 
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



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    EstablishmentDetailViewController *vc = [segue destinationViewController];
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
//    vc.currentEstablishments =
    
}


@end
