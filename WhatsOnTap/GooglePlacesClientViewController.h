//
//  GooglePlacesClientViewController.h
//  WhatsOnTap
//
//  Created by Sarmila on 6/17/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Establishment.h"
@interface GooglePlacesClientViewController : UIViewController
@property (strong, nonatomic) NSString *currentName;
@property (strong, nonatomic) NSString *currentLocation;
@property (strong, nonatomic) CLLocationManager *locationManager;


@property (strong, nonatomic) NSString *nearbyName;
@property (strong, nonatomic) NSString *nearbyLocation;
@property (strong, nonatomic) NSString *nearbyTypes;
@end
