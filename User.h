//
//  User.h
//  WhatsOnTap
//
//  Created by DetroitLabs on 6/14/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface User : NSObject

@property NSString *username;
@property FBSDKAccessToken *token;
@property UIImage *profilePicture;
@property NSMutableArray *starredBeers;

+ (instancetype)getUser;
- (void)setFBToken:(FBSDKLoginManagerLoginResult *)result;
@end
