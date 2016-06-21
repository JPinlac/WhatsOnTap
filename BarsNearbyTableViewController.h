//
//  BarsNearbyTableViewController.h
//  WhatsOnTap
//
//  Created by Sarmila on 6/21/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Establishment.h"
@import Firebase;

@interface BarsNearbyTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) CLLocationCoordinate2D currentLocation;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSMutableArray *establishmentArray;
@end
