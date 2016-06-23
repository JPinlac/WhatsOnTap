//
//  EstablishmentDetailViewController.m
//  WhatsOnTap
//
//  Created by DetroitLabs on 6/21/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "EstablishmentDetailViewController.h"
#import <MapKit/MapKit.h>
@import MapKit;

@interface EstablishmentDetailViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapKit;


@end

@implementation EstablishmentDetailViewController

- (void)viewDidLoad {
    NSLog(@"%f   %f", _currentEstablishment.location.latitude, _currentEstablishment.location.latitude);
//    NSLog(@"%@", _currentEstablishment.establishmentName);
    [super viewDidLoad];
    self.title = _currentEstablishment.establishmentName;

    CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(_currentEstablishment.location.latitude, _currentEstablishment.location.latitude);
    MKCoordinateRegion adjustedRegion = [_mapKit regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 200, 200)];
    [self.mapKit setRegion:adjustedRegion animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
// number of section(s), now I assume there is only 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}

// number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"taplistCell" forIndexPath:indexPath];
    UIImage *image1 = [UIImage imageNamed:@"beer-icon"];
    cell.imageView.image = image1;
    return cell;
}

#pragma mark - UITableViewDelegate
// when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected %d row", indexPath.row);
}





#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)snder {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    AddBeerViewController *vc = [segue destinationViewController];

}



-(void)unwindForSegue:(UIStoryboardSegue *)unwindSegue towardsViewController:(UIViewController *)subsequentVC{
    AddBeerViewController *vc = [unwindSegue sourceViewController];

    [_currentEstablishment.beers addObject:vc.beerToBeAdded];
}






@end
