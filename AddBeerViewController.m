//
//  AddBeerViewController.m
//  WhatsOnTap
//
//  Created by Sarmila on 6/22/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "AddBeerViewController.h"

@interface AddBeerViewController ()

@end

@implementation AddBeerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addBeerButtonPressed:(id)sender {
    _beerToBeAdded = [[Beer alloc] init];
    _beerToBeAdded.beerName = _addBeerText.text;
    //firebase logic
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
