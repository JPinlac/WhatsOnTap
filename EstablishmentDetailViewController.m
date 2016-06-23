//
//  EstablishmentDetailViewController.m
//  WhatsOnTap
//
//  Created by DetroitLabs on 6/21/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "EstablishmentDetailViewController.h"
#import <MapKit/MapKit.h>
@import MapKit;

@interface EstablishmentDetailViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapKit;


@end

@implementation EstablishmentDetailViewController

- (void)viewDidLoad {
    NSLog(@"%f   %f", _currentEstablishment.location.latitude, _currentEstablishment.location.latitude);
//    NSLog(@"%@", _currentEstablishment.establishmentName);
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = _currentEstablishment.establishmentName;
    MKCoordinateRegion adjustedRegion;
    adjustedRegion.center.latitude = _currentEstablishment.location.latitude;
    adjustedRegion.center.longitude = _currentEstablishment.location.longitude;
    adjustedRegion.span.latitudeDelta = 0.005;
    adjustedRegion.span.longitudeDelta = -0.005;
    [self.mapKit setRegion:adjustedRegion animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)snder {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    AddBeerViewController *vc = [segue destinationViewController];

}



-(void)unwindForSegue:(UIStoryboardSegue *)unwindSegue towardsViewController:(UIViewController *)subsequentVC{
    AddBeerViewController *vc = [unwindSegue sourceViewController];

    [_currentEstablishment.beers addObject:vc.beerToBeAdded];
}






@end
