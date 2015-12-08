//
//  AccountInformation.m
//  Demo_1
//
//  Created by mohammed aamer on 9/18/15.
//  Copyright (c) 2015 mohammed aamer. All rights reserved.
//

#import "AccountInformation.h"
#import "Helper.h"
#import "Constants.h"

@implementation AccountInformation

- (id)init {
    if (self = [super init]) {
        self.loginInformation = [[LoginInformation alloc] init];
        self.loginInformation.username = kEmptyString;
        self.middleName = kEmptyString;
        self.phoneNumber = kEmptyString;
        self.dateOfBirth = kEmptyString;
        self.gender = kEmptyString;
        self.country = kEmptyString;
        
    }
    return self;
}

- (BOOL)isFirstNameValid:(NSError **)error {
    
    BOOL result = NO;
    
    if (self.firstName.length < kNameMinCharLength) {
        
        [[Helper sharedInstance] setError:error inDomain:kAccountInformationDomain
                                  message:[NSString stringWithFormat:kNameMinCharMessage, kFirst]
                                 withCode:101];
    }
    else if (self.firstName.length > kNameMaxCharLength) {
        [[Helper sharedInstance] setError:error inDomain:kAccountInformationDomain
                                  message:[NSString stringWithFormat:kNameMaxCharMessage, kFirst]
                                 withCode:102];
    }
    else if (![[Helper sharedInstance] evaluateString:self.firstName withRegex:kNameRegex]) {
        [[Helper sharedInstance] setError:error inDomain:kAccountInformationDomain
                                  message:[NSString stringWithFormat:kNameValidCharMessage, kFirst]
                                 withCode:103];
    }
    else {
        result = YES;
    }
    
    return result;
}

- (BOOL)isMiddleNameValid:(NSError **)error {
    BOOL result = NO;
    if ([self.middleName isEqualToString:kEmptyString] ||
        [[Helper sharedInstance] evaluateString:self.middleName withRegex:kNameRegex]) {
        
        result = YES;
    }
    else {
        [[Helper sharedInstance] setError:error inDomain:kAccountInformationDomain
                                  message:kSelectGenderMessage
                                 withCode:401];
    }
    
    return result;

}

- (BOOL)isLastNameValid:(NSError **)error {
    
    
    BOOL result = NO;
    
    if (self.lastName.length < kNameMinCharLength) {
        
        [[Helper sharedInstance] setError:error inDomain:kAccountInformationDomain
                                  message:[NSString stringWithFormat:kNameMinCharMessage, kLast]
                                 withCode:201];
    }
    else if (self.lastName.length > kNameMaxCharLength) {
        [[Helper sharedInstance] setError:error inDomain:kAccountInformationDomain
                                  message:[NSString stringWithFormat:kNameMaxCharMessage, kLast]
                                 withCode:202];
    }
    else if (![[Helper sharedInstance] evaluateString:self.lastName withRegex:kNameRegex]) {
        [[Helper sharedInstance] setError:error inDomain:kAccountInformationDomain
                                  message:[NSString stringWithFormat:kNameValidCharMessage, kLast]
                                 withCode:203];
    }
    else {
        result = YES;
    }
    
    return result;

}

- (BOOL)isPhoneNumberValid:(NSError **)error {
    
    BOOL result = NO;
    if (self.phoneNumber.length != 0 && self.phoneNumber.length != 10) {
        
        [[Helper sharedInstance] setError:error inDomain:kAccountInformationDomain message:kPhoneNumberMessage withCode:301];
    }
    else {
        result = YES;
    }
    
    return result;
}

- (BOOL)isGenderValid:(NSError **)error {
    
    BOOL result = NO;
    if ([self.gender isEqualToString:kEmptyString] ||
        [self.gender isEqualToString:@"Male"] ||
        [self.gender isEqualToString:@"Female"] ||
        [self.gender isEqualToString:@"Prefer not to say"]) {
        
        result = YES;
    }
    else {
        [[Helper sharedInstance] setError:error inDomain:kAccountInformationDomain
                                  message:kSelectGenderMessage withCode:401];
    }
    
    return result;
}

- (BOOL)isCountryValid:(NSError **)error {
    
    BOOL result = NO;
    if ([self.country isEqualToString:kEmptyString]) {
        
        result = YES;
    }
    else {
        [[Helper sharedInstance] setError:error inDomain:kAccountInformationDomain
                                  message:kSelectCountryMessage withCode:401];
    }
    
    return result;
}

- (BOOL)isFormAcceptable:(NSError **)error {
    return ([self isFirstNameValid:error]
            && [self isLastNameValid:error]
            && [self.loginInformation isFormAcceptable:error]
            && ([self isMiddleNameValid:error]
            || [self isPhoneNumberValid:error]
            || [self isGenderValid:error]
            || [self isCountryValid:error]));
}

@end
