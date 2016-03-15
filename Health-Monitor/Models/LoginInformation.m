//
//  LoginInformation.m
//  Health-Monitor
//
//  Created by mohammed aamer on 9/18/15.
//  Copyright (c) 2015 mohammed aamer. All rights reserved.
//

#import "LoginInformation.h"
#import "Helper.h"
#import "Constants.h"


@implementation LoginInformation

- (BOOL)isUsernameValid:(NSError **)error {
    
    BOOL result = NO;
    
    if (self.username.length < kUsernameMinLength) {
        
        [[Helper sharedInstance] setError:error inDomain:kLoginInformationDomain
                                  message:kUsernameMinCharMessage withCode:501];
    }
    else if (self.username.length > kUsernameMaxLength) {
        [[Helper sharedInstance] setError:error inDomain:kLoginInformationDomain
                                  message:kUsernameMaxCharMessage withCode:502];
    }
    else if (![[Helper sharedInstance] evaluateString:self.username withRegex:kUsernameRegex]) {
        [[Helper sharedInstance] setError:error inDomain:kLoginInformationDomain
                                  message:kUsernameValidCharMessage withCode:503];
    }
    else {
        result = YES;
    }
    
    return result;
}

- (BOOL)isPasswordValid:(NSError **)error {
    
    BOOL result = NO;
    
    if (self.password.length < kPasswordMinLength) {
        
        [[Helper sharedInstance] setError:error inDomain:kLoginInformationDomain
                                  message:kPasswordMinCharMessage withCode:601];
    }
    else if (self.password.length > kPasswordMaxLength) {
        [[Helper sharedInstance] setError:error inDomain:kLoginInformationDomain
                                  message:kPasswordMaxCharMessage withCode:602];
    }
    else if (![[Helper sharedInstance] evaluateString:self.password withRegex:kPasswordRegex]) {
        [[Helper sharedInstance] setError:error inDomain:kLoginInformationDomain
                                  message:kPasswordValidCharMessage withCode:603];
    }
    else {
        result = YES;
    }
    
    return result;
}

- (BOOL)isFormAcceptable:(NSError **)error {
    return [self isUsernameValid:error] && [self isPasswordValid:error];
}

@end
