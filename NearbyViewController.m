//
//  NearbyViewController.m
//  WhatsOnTap
//
//  Created by Sarmila on 6/20/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "NearbyViewController.h"
#import "GooglePlacesClientViewController.h"

@interface NearbyViewController ()

@end

@implementation NearbyViewController

- (void)viewDidLoad {
    [self setnearbyLocationVC];
    [super viewDidLoad];
  //  NSLog(@"NearbyName: %@", _googlePlaceNearbyName);
  //  NSLog(@"NearbyLocation: %@", _googlePlaceNearbyLocation);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setnearbyLocationVC{
    
    _nearbyNameLabel.text = _googlePlaceNearbyName;
    _nearbyLocationLabel.text =_googlePlaceNearbyLocation;
    
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
