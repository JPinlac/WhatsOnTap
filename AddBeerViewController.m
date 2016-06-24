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
    [self displayAlert:@"Congrats!" alertMessage:[NSString stringWithFormat:@"You successfully added beer - %@", newBeer.beerName]];
}


- (IBAction)addBeerAndBrewery:(UIButton *)sender {
    if (_addBeerText.text.length == 0 || _addBreweryText.text.length == 0) {
        [self displayAlert:@"Incomplete" alertMessage:[NSString stringWithFormat:@"Please add both beer and brewery to proceed"]];

    } else {
        [self addBeerToDatabase];
    }
}



-(void)displayAlert:(NSString *)alertTitle alertMessage:(NSString *)alertMessage {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alertTitle message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alertController animated:TRUE completion:nil];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:TRUE completion:nil];
    }];
    
    [alertController addAction:action];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    BeerDetailTableViewController *vc = [segue destinationViewController];
    vc.linkedEstablishment = _addEstablishment;
 //   vc.beerListArray = _beersArray;
}


@end
