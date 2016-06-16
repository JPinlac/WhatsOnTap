//
//  Update.h
//  WhatsOnTap
//
//  Created by DetroitLabs on 6/16/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Update : NSObject
@property (strong, nonatomic) NSString *updateType;
//possible types beerRemovedFromTaplist, beerAddedToTaplist, beerCreated. establishmentCreated, reviewPosted, ratingPosted
@property (strong, nonatomic) NSString *user;
@property (strong, nonatomic) NSDate *publishedAt;
@end