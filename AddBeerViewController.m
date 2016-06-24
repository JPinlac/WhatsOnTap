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
    NSLog(@"%@", [NSDate date]);
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
    newBeer.uid = beerRef.key;
    [beerRef setValue:newBeerInfo];
    [self addUpdateToDatabaseForEstablishment:_establishmentName withBeer:newBeer.beerName andUpdateType:@"beer_added"];
    [self displayAlert:@"Congrats!" alertMessage:[NSString stringWithFormat:@"You successfully added beer - %@", newBeer.beerName]];
    
}

- (void)addUpdateToDatabaseForEstablishment:(NSString *)establishment withBeer:(NSString *)beer andUpdateType:(NSString *)updateType {
    NSDictionary *updateInfo = @{@"establishment": establishment, @"beer": beer, @"update_type": updateType, @"update_time": [NSString stringWithFormat:@"%@", [NSDate date]]};
    FIRDatabaseReference *ref = [[FIRDatabase database] reference];
    FIRDatabaseReference *updateRef = [ref child:@"updates"].childByAutoId;
    [updateRef setValue:updateInfo];
}

- (IBAction)addBeerAndBrewery:(UIButton *)sender {
    [self addBeerToDatabase];
}

-(void)displayAlert:(NSString *)alertTitle alertMessage:(NSString *)alertMessage {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alertTitle message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alertController animated:TRUE completion:nil];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self dismissViewControllerAnimated:TRUE completion:nil];
        
    }];
    
    [alertController addAction:action];
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
