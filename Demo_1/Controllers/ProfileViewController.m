//
//  ProfileViewController.m
//  Demo_1
//
//  Created by mohammed aamer on 11/20/15.
//  Copyright © 2015 mohammed aamer. All rights reserved.
//

#import "ProfileViewController.h"
#import "LogoutObject.h"

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [LogoutObject addLogoutIconInViewController:self];
    NSMutableArray *rightBarButtonItems = [self.navigationItem.rightBarButtonItems mutableCopy];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:nil];
    [rightBarButtonItems addObject:barButtonItem];
    self.navigationItem.rightBarButtonItems = rightBarButtonItems;
}

@end
