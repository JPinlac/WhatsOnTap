//
//  NearbyViewController.h
//  WhatsOnTap
//
//  Created by Sarmila on 6/20/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NearbyViewController : UIViewController

@property (strong, nonatomic) NSString *googlePlaceNearbyName;
@property (strong, nonatomic) NSString *googlePlaceNearbyLocation;


@property (weak, nonatomic) IBOutlet UILabel *nearbyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nearbyLocationLabel;



@end
