//
//  AppDelegate.m
//  WhatsOnTap
//
//  Created by DetroitLabs on 6/13/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "AppDelegate.h"
@import Firebase;
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKAccessToken.h>
#import "User.h"
#import "LoginViewController.h"
@import GoogleMaps;

@interface AppDelegate ()

@end

@implementation AppDelegate


//Facebook integration
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [FIRApp configure];
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];

    //shows login screen if facebook session isn't active
    if(![FBSDKAccessToken currentAccessToken]) {
        [self showLoginScreen:NO];
    }
    
    // Assign tab bar item with titles
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UITabBar *tabBar = tabBarController.tabBar;
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    
    
    [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"home.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"home.png"]];
   
    
    //change the tab bar background color
    UIImage* tabBarBackground = [UIImage imageNamed:@"tabbar.png"];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tabbar_selected.png"]];
    
    NSDictionary *dictionaryRoot = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"GMaps" ofType:@"plist"]];
    NSLog(@"%@", [dictionaryRoot objectForKey:@"GOOGLE_MAPS_API_KEY"]);
    [GMSServices provideAPIKey:[dictionaryRoot objectForKey:@"GOOGLE_MAPS_API_KEY"]];
 
    
    return YES;
}

-(void) showLoginScreen:(BOOL)animated
{
    
    // Get login screen from storyboard and present it
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *viewController = (LoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self.window makeKeyAndVisible];
    [self.window.rootViewController presentViewController:viewController
                                                 animated:animated
                                               completion:nil];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
