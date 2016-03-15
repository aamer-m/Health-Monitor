//
//  AccountInformation_FNTests.m
//  Health-Monitor
//
//  Created by mohammed aamer on 9/19/15.
//  Copyright (c) 2015 mohammed aamer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "AccountInformation.h"
#import "Helper.h"

@interface AccountInformation_FNTests : XCTestCase

@property (nonatomic, strong) AccountInformation *accountInformation;

@end

@implementation AccountInformation_FNTests

- (void)setUp {
    [super setUp];
    self.accountInformation = [[AccountInformation alloc] init];
}

- (void)tearDown {
    self.accountInformation = nil;
    [super tearDown];
}

//Test First Name

- (void)testInvalidFirstName_EmptyString {
    self.accountInformation.firstName = @"";
    NSError *error;
    BOOL result = [self.accountInformation isFirstNameValid:&error];
    XCTAssertFalse(result,@"Invalid first name. Only alphabets, hyphen and apostrophe are allowed.");
}

- (void)testInvalidFirstName_NumberString {
    self.accountInformation.firstName = @"123";
    NSError *error;
    BOOL result = [self.accountInformation isFirstNameValid:&error];
    XCTAssertFalse(result,@"Invalid first name. Only alphabets, hyphen and apostrophe are allowed.");
}

- (void)testInvalidFirstName_MinLength {
    self.accountInformation.firstName = @"aa";
    NSError *error;
    BOOL result = [self.accountInformation isFirstNameValid:&error];
    XCTAssertFalse(result,@"Invalid first name. Minimum length allowed is 3.");
}

- (void)testInvalidFirstName_MaxLength {
    self.accountInformation.firstName = [[Helper sharedInstance] genRandStringLength:256];
    NSError *error;
    BOOL result = [self.accountInformation isFirstNameValid:&error];
    XCTAssertFalse(result,@"Invalid first name. Minimum length allowed is 256.");
}

- (void)testInvalidFirstName_InvalidCharacters {
    self.accountInformation.firstName = @"abcd '0";
    NSError *error;
    BOOL result = [self.accountInformation isFirstNameValid:&error];
    XCTAssertFalse(result,@"Invalid first name, invalid characters");
}

- (void)testValidFirstName_validCharacters_1 {
    self.accountInformation.firstName = @"abcd";
    NSError *error;
    BOOL result = [self.accountInformation isFirstNameValid:&error];
    XCTAssertTrue(result,@"Valid first Name");
}

- (void)testValidFirstName_validCharacters_2 {
    self.accountInformation.firstName = @"abcd '";
    NSError *error;
    BOOL result = [self.accountInformation isFirstNameValid:&error];
    XCTAssertTrue(result,@"Valid first Name");
}


@end
