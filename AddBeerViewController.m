//
//  AddBeerViewController.m
//  WhatsOnTap
//
//  Created by Sarmila on 6/22/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "AddBeerViewController.h"
@import Firebase;
@import FirebaseDatabase;

@interface AddBeerViewController ()

@end

@implementation AddBeerViewController

- (void)viewDidLoad {
    self.navigationItem.title = @"Update Taplist";
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (IBAction)addBeerButtonPressed:(id)sender {
//    _beerToBeAdded = [[Beer alloc] init];
//    _beerToBeAdded.beerName = _addBeerText.text;
//    //firebase logic
//}

- (void)addBeerToDatabase {
    Beer *newBeer = [[Beer alloc]init];
    newBeer.beerName = _addBeerText.text;
    newBeer.brewery = _addBreweryText.text;
    newBeer.establishments = [[NSMutableArray alloc]init];
    
    NSDictionary *newBeerInfo = @{@"beer_name": newBeer.beerName, @"brewery": newBeer.brewery};
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    FIRDatabaseReference *beerRef = [ref child:@"beers"].childByAutoId;
    [beerRef setValue:newBeerInfo];
    
}
- (IBAction)addBeerAndBrewery:(UIButton *)sender {
    [self addBeerToDatabase];
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
