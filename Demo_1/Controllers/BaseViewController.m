//
//  BaseViewController.m
//  Demo_1
//
//  Created by mohammed aamer on 11/20/15.
//  Copyright © 2015 mohammed aamer. All rights reserved.
//

#import "BaseViewController.h"
#import "ViewController.h"

@implementation BaseViewController
{
    UIViewController *activeController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logOutReceived) name:@"LogOut" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loggedIn) name:@"LoggedIn" object:nil];
    NSNumber *loggedIn = [[NSUserDefaults standardUserDefaults] objectForKey:@"LoggedIn"];
    self.view.translatesAutoresizingMaskIntoConstraints = FALSE;
    UIStoryboard *storyboard;
    UIViewController *viewController;
    if (loggedIn.integerValue == 0) {
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        viewController = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    } else {
        storyboard = [UIStoryboard storyboardWithName:@"Root" bundle:nil];
        viewController = [storyboard instantiateInitialViewController];
    }
    
    [self addChildViewController:viewController];
    viewController.view.translatesAutoresizingMaskIntoConstraints = FALSE;
    [self.view addSubview:viewController.view];
    NSDictionary *dictionary = @{@"A":self.view, @"B":viewController.view};
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[B]-0-|" options:0 metrics:nil views:dictionary];
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[B]-0-|" options:0 metrics:nil views:dictionary];
    viewController.view.frame = self.view.bounds;
    [self.view addConstraints:horizontalConstraints];
    [self.view addConstraints:verticalConstraints];
    [viewController didMoveToParentViewController:self];
    activeController = viewController;
    
}

//- (BOOL)shouldAutorotate {
//    if ([activeController isKindOfClass:[ViewController class]] ||
//        [activeController.presentedViewController isKindOfClass:[ViewController class]]) {
//        return TRUE;
//    }
//    return FALSE;
//}

- (void)loggedIn {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Root" bundle:nil];
    UIViewController *viewController = [storyboard instantiateInitialViewController];
    viewController.view.frame = self.view.frame;
    [self.view insertSubview:viewController.view aboveSubview:activeController.view];
    [UIView animateWithDuration:0.33 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        activeController.view.layer.transform = CATransform3DMakeTranslation(0, activeController.view.frame.size.height, 0);
    } completion:^(BOOL finished) {
        if (finished) {
            [self addChildViewController:viewController];
            [viewController didMoveToParentViewController:self];
            [activeController willMoveToParentViewController:self];
            [activeController.view removeFromSuperview];
            [activeController removeFromParentViewController];
        }
    }];
}


- (void)logOutReceived {
    UIStoryboard *storyboard;
    UIViewController *viewController;
    storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    viewController = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    viewController.view.frame = self.view.frame;
    viewController.view.layer.transform = CATransform3DMakeTranslation(0, viewController.view.frame.size.height, 0);
    [self.view addSubview:viewController.view];
    
    [UIView animateWithDuration:0.66 delay:0 usingSpringWithDamping:0.85 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        viewController.view.layer.transform = CATransform3DIdentity;
    } completion:^(BOOL finished) {
        [self addChildViewController:viewController];
        [viewController didMoveToParentViewController:self];
        [activeController willMoveToParentViewController:self];
        [activeController.view removeFromSuperview];
        [activeController removeFromParentViewController];
        activeController = viewController;
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
