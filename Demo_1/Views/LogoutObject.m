//
//  LogoutObject.m
//  Demo_1
//
//  Created by mohammed aamer on 12/1/15.
//  Copyright © 2015 mohammed aamer. All rights reserved.
//

#import "LogoutObject.h"

@implementation LogoutObject



+ (void)addLogoutIconInViewController:(UIViewController *)viewController {
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"logout"] style:UIBarButtonItemStylePlain target:self action:@selector(logOut)];
    viewController.navigationItem.rightBarButtonItem = logoutButton;
}

+ (void)logOut {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"Options" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"Logout" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LoggedIn"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LogOut" object:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:logoutAction];
    [alertController addAction:cancelAction];
    
    alertController.preferredAction = logoutAction;
    [[[[[UIApplication sharedApplication] windows] firstObject] rootViewController] presentViewController:alertController animated:YES completion:nil];
    
    
}


@end
