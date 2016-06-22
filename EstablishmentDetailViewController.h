//
//  EstablishmentDetailViewController.h
//  WhatsOnTap
//
//  Created by DetroitLabs on 6/21/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Establishment.h"
#import "AddBeerViewController.h"

@interface EstablishmentDetailViewController : UIViewController
@property (nonatomic) Establishment *currentEstablishment;
@end
