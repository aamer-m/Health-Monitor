//
//  ViewController.m
//  Demo_1
//
//  Created by mohammed aamer on 9/9/15.
//  Copyright (c) 2015 mohammed aamer. All rights reserved.
//

#import "ViewController.h"
#import "LoginInformation.h"
#import "Constants.h"

@interface ViewController ()<UITextFieldDelegate>

@property LoginInformation *loginInformation;

@end

@implementation ViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginInformation = [[LoginInformation alloc] init];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *finalString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    switch (textField.tag) {
        case 21:
            self.loginInformation.username = finalString;
            break;
        case 22:
            self.loginInformation.password = finalString;
            break;
        default:
            break;
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    switch (textField.tag) {
        case 21:
            self.loginInformation.username = kEmptyString;
            break;
        case 22:
            self.loginInformation.password = kEmptyString;
            break;
    }
    
    return YES;
}

- (BOOL)shouldAutorotate {
    return FALSE;
}

- (IBAction)signUpTapped:(id)sender {
    [self performSegueWithIdentifier:@"login2Create" sender:sender];
}

- (IBAction)loginTapped:(id)sender {
    NSError *error;
    if ([self.loginInformation isFormAcceptable:&error]) {
        [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"LoggedIn"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoggedIn" object:nil];
    } else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:error.domain preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        alertController.preferredAction = okAction;
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
@end
