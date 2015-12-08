//
//  LogInViewController.m
//  Demo_1
//
//  Created by mohammed aamer on 9/11/15.
//  Copyright (c) 2015 mohammed aamer. All rights reserved.
//

#import "LogInViewController.h"

@implementation LogInViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([self isMovingFromParentViewController]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (IBAction)logoutTapped:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
@end
