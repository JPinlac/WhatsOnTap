//
//  AddBeerViewController.h
//  WhatsOnTap
//
//  Created by Sarmila on 6/22/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EstablishmentDetailViewController.h"
#import "Beer.h"

@interface AddBeerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *addBeerText;
@property (weak, nonatomic) IBOutlet UITextField *addBreweryText;

@property (nonatomic) Beer *beerToBeAdded;

@end
