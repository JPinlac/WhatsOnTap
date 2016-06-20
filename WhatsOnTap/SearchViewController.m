//
//  SearchViewController.m
//  
//
//  Created by Sarmila on 6/14/16.
//
//

#import "SearchViewController.h"
#import "GooglePlacesClientViewController.h"
@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [self setcurrentlocationVC];
    [super viewDidLoad];
    NSLog(@"googlePlaceName: %@", _googlePlaceName);
    NSLog(@"googlePlaceLocation: %@", _googlePlaceLocation);
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setcurrentlocationVC{
    
    _googlePlacesNameLabel.text = _googlePlaceName;
    _googlePlacesLocationLabel.text =_googlePlaceLocation;
    _googlePlacesNearbyNameLabel.text = _googlePlaceNearbyName;
    _googlePlacesNearbyLocationLabel.text =_googlePlaceNearbyLocation;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
