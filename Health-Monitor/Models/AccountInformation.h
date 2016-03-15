//
//  AccountInformation.h
//  Health-Monitor
//
//  Created by mohammed aamer on 9/18/15.
//  Copyright (c) 2015 mohammed aamer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginInformation.h"

@interface AccountInformation : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *middleName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *dateOfBirth;
@property (nonatomic, strong) LoginInformation *loginInformation;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *country;

- (BOOL)isFirstNameValid:(NSError **)error;
- (BOOL)isLastNameValid:(NSError **)error;
- (BOOL)isMiddleNameValid:(NSError **)error;
- (BOOL)isPhoneNumberValid:(NSError **)error;
- (BOOL)isGenderValid:(NSError **)error;
- (BOOL)isCountryValid:(NSError **)error;
- (BOOL)isFormAcceptable:(NSError **)error;

@end
