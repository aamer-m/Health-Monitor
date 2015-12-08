//
//  AppDelegate.m
//  Demo_1
//
//  Created by mohammed aamer on 9/9/15.
//  Copyright (c) 2015 mohammed aamer. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation UIViewController (test)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma clang diagnostic pop

@end


@implementation UINavigationController (test)

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"logout"] style:UIBarButtonItemStylePlain target:self action:@selector(logOut)];
//    for (UIViewController *viewController in self.viewControllers) {
//        viewController.navigationItem.rightBarButtonItem = logoutButton;
//    }
//}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)logOut {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"Options" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"Logout" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LoggedIn"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LogOut" object:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:logoutAction];
    [alertController addAction:cancelAction];

    alertController.preferredAction = logoutAction;
    [self presentViewController:alertController animated:YES completion:nil];
    

}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIColor *lightGreenColor = [UIColor colorWithRed:(55.0/255) green:(194.0/255) blue:(117.0/255) alpha:1.0];
    [[UINavigationBar appearance] setBarTintColor:lightGreenColor];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];
    [[UITabBar appearance] setBarTintColor:lightGreenColor];
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }
                                             forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] }
                                             forState:UIControlStateNormal];
    return YES;
}

@end
