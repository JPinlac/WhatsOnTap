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
@import Firebase;
@import FirebaseDatabase;

@interface BarsNearbyTableViewController ()
@property(nonatomic, strong) IBOutlet UITableView *tableView;
@property(strong, nonatomic) NSMutableArray *establishmentsArray;
@end

@implementation BarsNearbyTableViewController{
    GMSPlacesClient *_placesClient;
    GMSPlacePicker *_placePicker;
}

- (void)viewDidLoad {
    [self getEstblishmentsFromDatabase];
     NSLog(@"Check: %@", _establishmentsArray.description);
    [super viewDidLoad];
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

#pragma mark - Add Establishment picker

- (IBAction)pickPlace:(id)sender {
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(_locationManager.location.coordinate.latitude, _locationManager.location.coordinate.longitude);
    CLLocationCoordinate2D northEast = CLLocationCoordinate2DMake(center.latitude + 0.001,
                                                                  center.longitude + 0.001);
    CLLocationCoordinate2D southWest = CLLocationCoordinate2DMake(center.latitude - 0.001,
                                                                  center.longitude - 0.001);
    GMSCoordinateBounds *viewport = [[GMSCoordinateBounds alloc] initWithCoordinate:northEast
                                                                         coordinate:southWest];
    GMSPlacePickerConfig *config = [[GMSPlacePickerConfig alloc] initWithViewport:viewport];
    _placePicker = [[GMSPlacePicker alloc] initWithConfig:config];
    
    [_placePicker pickPlaceWithCallback:^(GMSPlace *place, NSError *error) {
        if (error != nil) {
            NSLog(@"Pick Place error %@", [error localizedDescription]);
            return;
        }
        
        if (place != nil) {
            Establishment *newEstablishment = [[Establishment alloc]init];
            newEstablishment.establishmentName = place.name;
            newEstablishment.location = place.coordinate;
            newEstablishment.streetAddress = [[place.formattedAddress componentsSeparatedByString:@", "] componentsJoinedByString:@"\n"];
            newEstablishment.beers = [[NSMutableArray alloc]init];
            
            NSLog(@"Name %@\n Lat %f\n Long %f\nAddress %@",newEstablishment.establishmentName, newEstablishment.location.latitude, newEstablishment.location.longitude, newEstablishment.streetAddress);
            NSString *locationStringToPass = [NSString stringWithFormat:@"%f,%f", newEstablishment.location.latitude, newEstablishment.location.longitude];
            NSDictionary *newEstablishmentInfo = @{@"establishment_name": newEstablishment.establishmentName, @"location": locationStringToPass};
            FIRDatabaseReference *ref = [[FIRDatabase database] reference];
            FIRDatabaseReference *establishmentRef = [ref child:@"establishments"].childByAutoId;
            [establishmentRef setValue:newEstablishmentInfo];
        }
    }];

}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_establishmentsArray count];
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"establishmentCell" forIndexPath:indexPath];
 
     
     UIImage *image1 = [UIImage imageNamed:@"beer-icon"];
     cell.imageView.image = image1;
     
     cell.textLabel.text = [_establishmentsArray objectAtIndex:indexPath.row];
 
 return cell;
 }

- (void)getEstblishmentsFromDatabase {
    _establishmentsArray = [[NSMutableArray alloc] init];
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    FIRDatabaseReference *establishmentsRef = [ref child:@"establishments"];
    
    [establishmentsRef observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot *snapshot) {
        for (FIRDataSnapshot *child in snapshot.children) {
            if ([child.key isEqualToString:@"establishment_name"]) {
                [_establishmentsArray addObject:child.value];
            }
        }
        [self.tableView reloadData];
    }];
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
   // NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    
    vc.currentEstablishment =[_establishmentsArray objectAtIndex:selectedIndexPath.row];
    
    
   
}


@end
