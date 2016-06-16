//
//  Establishment.h
//  WhatsOnTap
//
//  Created by Sarmila on 6/14/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Establishment : NSObject
@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *establishmentName;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSMutableArray *beers;


@end
