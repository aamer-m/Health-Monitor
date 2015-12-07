//
//  AccountInformation_PhoneNumberTests.m
//  Demo_1
//
//  Created by mohammed aamer on 9/20/15.
//  Copyright © 2015 mohammed aamer. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AccountInformation.h"

@interface AccountInformation_PhoneNumberTests : XCTestCase

@property (nonatomic, strong) AccountInformation *accountInformation;

@end

@implementation AccountInformation_PhoneNumberTests

- (void)setUp {
    [super setUp];
    self.accountInformation = [[AccountInformation alloc] init];
}

- (void)tearDown {
    self.accountInformation = nil;
    [super tearDown];
}

- (void)testInvalidPhonenumber_Morelength {
    self.accountInformation.phoneNumber = @"123456789056";
    NSError *error;
    BOOL result = ([self.accountInformation isPhoneNumberValid:&error]);
    XCTAssertFalse(result, @"Phone number length should be equal to 0 or 10.");
}

- (void)testInvalidPhonenumber_LessLength {
    self.accountInformation.phoneNumber = @"1234";
    NSError *error;
    BOOL result = ([self.accountInformation isPhoneNumberValid:&error]);
    XCTAssertFalse(result, @"Invalid phone number length.");
}

- (void)testValidPhonenumber {
    self.accountInformation.phoneNumber = @"1234567890";
    NSError *error;
    BOOL result = ([self.accountInformation isPhoneNumberValid:&error]);
    XCTAssertTrue(result, @"Valid phone number.");
}


- (void)testValidPhonenumber_Zeroes {
    self.accountInformation.phoneNumber = @"";
    NSError *error;
    BOOL result = ([self.accountInformation isPhoneNumberValid:&error]);
    XCTAssertTrue(result, @"Valid Phone number. Phone number length can be zero.");
}


@end
