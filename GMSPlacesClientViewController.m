//
//  GMSPlacesClientViewController.m
//  
//
//  Created by Sarmila on 6/16/16.
//
//

#import "GMSPlacesClientViewController.h"
@import GoogleMaps;


@interface GMSPlacesClientViewController ()
// Instantiate a pair of UILabels in Interface Builder
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@end

@implementation GMSPlacesClientViewController{
    GMSPlacesClient *_placesClient;
    GMSPlacePicker *_placePicker;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _placesClient = [[GMSPlacesClient alloc] init];
   
   establishmentDict = [[NSDictionary alloc]initWithObjectsAndKeys:@"Value1",@"Key1",@"Value2",@"Key2",nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


// Add a UIButton in Interface Builder to call this function
- (IBAction)getCurrentPlace:(UIButton *)sender {
    [_placesClient currentPlaceWithCallback:^(GMSPlaceLikelihoodList *placeLikelihoodList, NSError *error){
        if (error != nil) {
            NSLog(@"Pick Place error %@", [error localizedDescription]);
            return;
            
        }
        
        self.nameLabel.text = @"No current place";
        self.addressLabel.text = @"";
        
        if (placeLikelihoodList != nil) {
            GMSPlace *place = [[[placeLikelihoodList likelihoods] firstObject] place];
            if (place != nil) {
                self.nameLabel.text = place.name;
                self.addressLabel.text = [[place.formattedAddress componentsSeparatedByString:@", "]
                                          componentsJoinedByString:@"\n"];
            }
        }
       // NSLog(@"localized: %@", _placesClient.localizedDescription);
    }];
}

// Add a UIButton in Interface Builder to call this function
- (IBAction)pickPlace:(UIButton *)sender {
    
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(37.788204, -122.411937);
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
        } else {
            self.nameLabel.text = @"No place selected";
            self.addressLabel.text = @"";
        }
    }];
}

- (void) autocompleteQuery:(NSString *)query bounds:(GMSCoordinateBounds *_Nullable)bounds filter:(GMSAutocompleteFilter *_Nullable)filter callback:(GMSAutocompletePredictionsCallback)callback{
        query=query;
        bounds=bounds;
        filter=filter;
        callback=callback;
    
        
   
   
//    marker.position = CLLocationCoordinate2DMake(_mapView_.myLocation.coordinate.latitude, _mapView_.myLocation.coordinate.longitude);
//    marker.title = @"Parked";
//    marker.snippet = @"My Ford MKZ";
//    marker.map = _mapView_;

}


@end
