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
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *establishmentsArray;
@property (strong, nonatomic) NSMutableArray *searchEstablishmentsArray;
@property (weak, nonatomic) IBOutlet UITextField *searchEstablishmentTextField;
@end

@implementation BarsNearbyTableViewController{
    GMSPlacesClient *_placesClient;
    GMSPlacePicker *_placePicker;
}

- (void)viewDidLoad {
    self.navigationItem.title = @"Establishment List";
    [self getEstblishmentsFromDatabase];
    NSLog(@"%@",_establishmentsArray.description);
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
    if ([_searchEstablishmentsArray count] == 0) {
        return [_establishmentsArray count];
    } else {
        return [_searchEstablishmentsArray count];
    }
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"establishmentCell" forIndexPath:indexPath];
 
     
     UIImage *image1 = [UIImage imageNamed:@"beer-icon"];
     cell.imageView.image = image1;
     
     if ([_searchEstablishmentsArray count] == 0) {
         Establishment *establishmentInCell = [_establishmentsArray objectAtIndex:indexPath.row];
        cell.textLabel.text = establishmentInCell.establishmentName;
     } else {
         Establishment *establishmentInCell = [_searchEstablishmentsArray objectAtIndex:indexPath.row];
         cell.textLabel.text = establishmentInCell.establishmentName;
     }
 
 return cell;
 }

- (void)getEstblishmentsFromDatabase {
    _establishmentsArray = [[NSMutableArray alloc] init];
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    FIRDatabaseReference *establishmentsRef = [ref child:@"establishments"];
    
    [establishmentsRef observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot *snapshot) {
        Establishment *newEstablishment = [[Establishment alloc] init];
        for (FIRDataSnapshot *child in snapshot.children) {

            newEstablishment.uid = snapshot.key;
            
            if ([child.key isEqualToString:@"establishment_name"]) {
                newEstablishment.establishmentName = child.value;
            }
            if ([child.key isEqualToString:@"location"]){
                NSArray *items = [child.value componentsSeparatedByString:@","];
                float latitude =[[items objectAtIndex:0] floatValue];
                float longitude =[[items objectAtIndex:1] floatValue];
                newEstablishment.location = CLLocationCoordinate2DMake(latitude, longitude);
            } 
            NSLog(@"%@", newEstablishment.establishmentName);
            NSLog(@"%f   %f", newEstablishment.location.latitude, newEstablishment.location.latitude);
            
        }
        [_establishmentsArray addObject:newEstablishment];
        [self.tableView reloadData];
    }];
    
}

- (IBAction)searchEstablishmentButton:(UIButton *)sender {
    [self searchEstablishments];
    NSLog(@"Search results: %@", _searchEstablishmentsArray.description);
    [self.tableView reloadData];
}

- (NSString*) sanitizeString:(NSString *)output {
    // Create set of accepted characters
    NSMutableCharacterSet *acceptedCharacters = [[NSMutableCharacterSet alloc] init];
    [acceptedCharacters formUnionWithCharacterSet:[NSCharacterSet letterCharacterSet]];
    [acceptedCharacters formUnionWithCharacterSet:[NSCharacterSet decimalDigitCharacterSet]];
    [acceptedCharacters addCharactersInString:@" _-.!"];
    
    // Remove characters not in the set
    output = [[output componentsSeparatedByCharactersInSet:[acceptedCharacters invertedSet]] componentsJoinedByString:@""];
    output = [output lowercaseString];
    return output;
}

- (void)searchEstablishments {
    NSString *searchEstablishmentText;
    _searchEstablishmentsArray = [[NSMutableArray alloc]init];
    searchEstablishmentText = [_searchEstablishmentTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    searchEstablishmentText = [self sanitizeString:searchEstablishmentText];
   
    for (Establishment *establishment in _establishmentsArray) {
        if ([[[self sanitizeString:establishment.establishmentName] stringByReplacingOccurrencesOfString:@" " withString:@""] containsString:searchEstablishmentText]) {
            [_searchEstablishmentsArray addObject:establishment];
            NSLog(@"%@",_searchEstablishmentsArray);
        }
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
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row%2 == 0) {
        UIColor *altCellColor = [UIColor colorWithWhite:0.9 alpha:1];
        cell.backgroundColor = altCellColor;
    }
    else{
        cell.backgroundColor = [UIColor whiteColor];
    }
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    EstablishmentDetailViewController *vc = [segue destinationViewController];
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    if ([_searchEstablishmentsArray count] == 0) {
        vc.currentEstablishment = [_establishmentsArray objectAtIndex:selectedIndexPath.row];
    } else {
        vc.currentEstablishment = [_searchEstablishmentsArray objectAtIndex:selectedIndexPath.row];
    }
}


@end
