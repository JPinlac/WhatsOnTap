//
//  GMSPlacesClientViewController.h
//  
//
//  Created by Sarmila on 6/16/16.
//
//

#import <UIKit/UIKit.h>

@interface GMSPlacesClientViewController : UIViewController
@property (strong, nonatomic)NSDictionary *establishmentDict;


- (void) autocompleteQuery:(NSString *)query bounds:(GMSCoordinateBounds *_Nullable)bounds filter:(GMSAutocompleteFilter *_Nullable)filter callback:(GMSAutocompletePredictionsCallback)callback;


@end
