//
//  SearchViewController.h
//  
//
//  Created by Sarmila on 6/14/16.
//
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController

@property (strong, nonatomic) NSString *googlePlaceName;
@property (strong, nonatomic) NSString *googlePlaceLocation;

@property (weak, nonatomic) IBOutlet UILabel *googlePlacesNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *googlePlacesLocationLabel;



@property (strong, nonatomic) NSString *googlePlaceNearbyName;
@property (strong, nonatomic) NSString *googlePlaceNearbyLocation;


@property (weak, nonatomic) IBOutlet UILabel *googlePlacesNearbyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *googlePlacesNearbyLocationLabel;

@end
