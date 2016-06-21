//
//  NearbyViewController.h
//  WhatsOnTap
//
//  Created by Sarmila on 6/20/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface NearbyViewController : UIViewController

@property (strong, nonatomic) NSString *googlePlaceNearbyName;
@property (nonatomic) CLLocationCoordinate2D googlePlaceNearbyLocation;

@property (weak, nonatomic) IBOutlet UILabel *nearbyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nearbyLocationLabel;



@end
