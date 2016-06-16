//
//  User.m
//  WhatsOnTap
//
//  Created by DetroitLabs on 6/14/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "User.h"

@implementation User

+ (User *)getUser {
    static User *curentUser = nil;
    static dispatch_once_t onePredicate;
    
    dispatch_once(&onePredicate, ^ {
        curentUser = [[User alloc]init];
    });
    
    return curentUser;
}

- (void)setFBToken:(FBSDKLoginManagerLoginResult *)result{
    self.token = result.token;
}
@end
