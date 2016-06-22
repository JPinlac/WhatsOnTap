//
//  EstablishmentDetailViewController.m
//  WhatsOnTap
//
//  Created by DetroitLabs on 6/21/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "EstablishmentDetailViewController.h"
@interface EstablishmentDetailViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapKit;


@end

@implementation EstablishmentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MKCoordinateRegion adjustedRegion;
    adjustedRegion.center.latitude = _currentEstablishment.location.latitude;
    adjustedRegion.center.longitude = _currentEstablishment.location.longitude;
    adjustedRegion.span.latitudeDelta = 0.005;
    adjustedRegion.span.longitudeDelta = -0.005;
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
    AddBeerViewController *uvc = [unwindSegue sourceViewController];
    [_currentEstablishment.beers addObject:uvc.addBeerText.text];
}



    
    

@end
