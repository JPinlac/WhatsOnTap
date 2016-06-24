//
//  BeerDetailTableViewController.h
//  WhatsOnTap
//
//  Created by Srinivas Bodhanampati on 6/24/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Establishment.h"

@interface BeerDetailTableViewController : UITableViewController

@property (nonatomic) Establishment *linkedEstablishment;

- (void)addBeerToEstablishmentDatabase:(NSString *)beerID;

@end
