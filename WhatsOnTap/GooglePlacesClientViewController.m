//
//  GooglePlacesClientViewController.m
//  WhatsOnTap
//
//  Created by Sarmila on 6/17/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "GooglePlacesClientViewController.h"
@import GoogleMaps;
#import "SearchViewController.h"
#import "NearbyViewController.h"
#import "Establishment.h"

@interface GooglePlacesClientViewController ()
// Instantiate a pair of UILabels in Interface Builder
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *getCurrentLocationButton;
@end

@implementation GooglePlacesClientViewController {
    GMSPlacesClient *_placesClient;
     GMSPlacePicker *_placePicker;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getCurrentInfo];
    
    
}

// Add a UIButton in Interface Builder to call this function
- (IBAction)currentPlaceButtonPressed {

}

-(void)getCurrentInfo{
         _placesClient = [GMSPlacesClient sharedClient];
         [_placesClient currentPlaceWithCallback:^(GMSPlaceLikelihoodList *placeLikelihoodList, NSError *error){
            // NSLog(@"inside the currentPlaceWithCallback block");
             if (error != nil) {
                 NSLog(@"Pick Place error %@", [error localizedDescription]);
                 return;
             } else {
                 NSLog(@"Error: %@", error.localizedDescription);
             }
             
             self.addressLabel.text = @"";
             
             if (placeLikelihoodList != nil) {
                 GMSPlace *place = [[[placeLikelihoodList likelihoods] firstObject] place];
                 if (place != nil) {
                     self.nameLabel.text = place.name;
                     self.addressLabel.text = [[place.formattedAddress componentsSeparatedByString:@", "]
                                               componentsJoinedByString:@"\n"];
                     _currentName = place.name;
                    _currentLocation =[[place.formattedAddress componentsSeparatedByString:@", "]
                                      componentsJoinedByString:@"\n"];
                    // _currentLocation = place.formattedAddress;
               
                 }
             }
         }];
     }

// Add a UIButton in Interface Builder to call this function
- (IBAction)pickPlace:(UIButton *)sender {
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
            self.nameLabel.text = place.name;
            self.addressLabel.text = [[place.formattedAddress
                                       componentsSeparatedByString:@", "] componentsJoinedByString:@"\n"];
         
            _nearbyName= place.name;
            _nearbyLocation = [[place.formattedAddress
                                componentsSeparatedByString:@", "] componentsJoinedByString:@"\n"];
           
            
          //  _nearbyLocation = place.formattedAddress;
            _nearbyTypes=place.types;
            
            
            Establishment *newEstablishment =[[Establishment alloc]init];
            newEstablishment.establishmentName = _nearbyName;
            newEstablishment.location = _nearbyLocation;
            NSLog(@"%@", newEstablishment.description);

        } else {
            self.nameLabel.text = @"No place selected";
            self.addressLabel.text = @"";
            NSLog(@"%@", self.addressLabel.text);
        }
    }];

}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"currentLocationSegue"]) {
        
        SearchViewController *vc =[segue destinationViewController];
        vc.googlePlaceName = _currentName;
        vc.googlePlaceLocation = _currentLocation;
            
    }
    else if ([[segue identifier] isEqualToString:@"nearbyLocationSegue"]) {
        
        NearbyViewController *vc =[segue destinationViewController];
        vc.googlePlaceNearbyName = _nearbyName;
        vc.googlePlaceNearbyLocation = _nearbyLocation;
        NSLog(@"%@", _nearbyName);
        NSLog(@"%@", _nearbyLocation);
    }
}


@end

