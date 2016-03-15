//
//  Constants.m
//  Health-Monitor
//
//  Created by mohammed aamer on 9/20/15.
//  Copyright (c) 2015 mohammed aamer. All rights reserved.
//

#import "Constants.h"
#import <UIKit/UIKit.h>

NSString * kUsernameMinCharMessage = @"Username should have minimum of 4 characters";
NSString * kUsernameMaxCharMessage = @"Username should have maximum of 8 characters";
NSString * kPasswordMinCharMessage = @"Password should have minimum of 6 characters";
NSString * kPasswordMaxCharMessage = @"Password should have maximum of 6 characters";
NSString * kUsernameRegex = @"^[A-Za-z][-_0-9A-Za-z]*$";
NSString * kLoginInformationDomain = @"Login Information";
NSString * kPasswordRegex = @"^[a-zA-Z0-9]*$";
NSString * kUsernameValidCharMessage = @"Only alphabets, underscore, hyphen, apostrophe are allowed. Should start with an alphabet";
NSString * kPasswordValidCharMessage = @"Only alphabets and numbers are allowed";
NSString * kEmptyString = @"";
NSString * kNameRegex = @"^[A-Za-z][A-za-z-' ]*[A-Za-z]*$";
NSString * kAccountInformationDomain = @"Account Information";
NSString *kFirst = @"First";
NSString *kLast = @"Last";
NSString *kNameMinCharMessage = @"Minimum length of %@ name is 3";
NSString *kNameMaxCharMessage = @"Maximum length of %@ name is 255";
NSString *kNameValidCharMessage = @"% Name - Only alphabets, space, hyphen, apostrophe are allowed. Should start and end with alphabet";
NSString *kSelectGenderMessage = @"Select a gender";
NSString *kPhoneNumberMessage = @"Phone number should be of length 10";
NSString *kSelectCountryMessage = @"Select a country";

NSInteger kNameMinCharLength = 3;
NSInteger kNameMaxCharLength = 255;
NSInteger kPhoneNumberLength = 10;

NSInteger kUsernameMinLength = 4;
NSInteger kUsernameMaxLength = 8;
NSInteger kPasswordMinLength = 6;
NSInteger kPasswordMaxLength = 16;