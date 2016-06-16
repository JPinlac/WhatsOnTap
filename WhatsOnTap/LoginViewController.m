//
//  LoginViewController.m
//  WhatsOnTap
//
//  Created by DetroitLabs on 6/14/16.
//  Copyright © 2016 Detroit Labs. All rights reserved.
//

#import "LoginViewController.h"
#import "User.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKAccessToken.h>
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
//    _loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    loginButton.center = self.view.center;
    loginButton.delegate = self;
    [self.view addSubview:loginButton];
     NSLog(@"%@", [FBSDKAccessToken currentAccessToken]);
    if([FBSDKAccessToken currentAccessToken] != NULL)
    {
        NSLog(@"DISMISSING SHIT");
//        [self dismissShit];
//        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)dismissShit{
//    sleep(10);
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error{
//    [FBSDKAccessToken ]
    [[User getUser]setFBToken:result];
    NSLog(@"%@", [[User getUser] token]);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    NSLog(@"bye");
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
