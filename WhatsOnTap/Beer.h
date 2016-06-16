//
//  Beer.h
//  WhatsOnTap
//
//  Created by DetroitLabs on 6/16/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Beer : NSObject
@property (strong, nonatomic) NSString *uid;
@property(strong, nonatomic) NSString *beerName;
@property(strong, nonatomic) NSString *brewery;
@property(strong, nonatomic) NSMutableArray *establishments;
@end
