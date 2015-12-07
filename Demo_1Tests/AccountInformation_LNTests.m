//
//  AccountInformation_LNTests.m
//  Demo_1
//
//  Created by mohammed aamer on 9/20/15.
//  Copyright (c) 2015 mohammed aamer. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AccountInformation.h"
#import "Helper.h"

@interface AccountInformation_LNTests : XCTestCase

@property (nonatomic, strong) AccountInformation *accountInformation;

@end

@implementation AccountInformation_LNTests

- (void)setUp {
    [super setUp];
    self.accountInformation = [[AccountInformation alloc] init];
}

- (void)tearDown {
    self.accountInformation = nil;
    [super tearDown];
}

//Test First Name

- (void)testInvalidLastName_EmptyString {
    self.accountInformation.lastName = @"";
    NSError *error;
    BOOL result = [self.accountInformation isLastNameValid:&error];
    XCTAssertFalse(result,@"Invalid last name. Only alphabets, hyphen and apostrophe are allowed.");
}

- (void)testInvalidLastName_NumberString {
    self.accountInformation.lastName = @"123";
    NSError *error;
    BOOL result = [self.accountInformation isLastNameValid:&error];
    XCTAssertFalse(result,@"Invalid last name. Only alphabets, hyphen and apostrophe are allowed.");
}

- (void)testInvalidLastName_MinLength {
    self.accountInformation.lastName = @"aa";
    NSError *error;
    BOOL result = [self.accountInformation isLastNameValid:&error];
    XCTAssertFalse(result,@"Invalid last name. Minimum length allowed is 3.");
}

- (void)testInvalidLastName_NumericStart {
    self.accountInformation.lastName = @"0abc";
    NSError *error;
    BOOL result = [self.accountInformation isLastNameValid:&error];
    XCTAssertFalse(result,@"Invalid last name. Invalid first character.");
}

- (void)testInvalidLastName_MaxLength {
    self.accountInformation.lastName = [[Helper sharedInstance] genRandStringLength:256];
    NSError *error;
    BOOL result = [self.accountInformation isLastNameValid:&error];
    XCTAssertFalse(result,@"Invalid last name. Minimum length allowed is 256.");
}

- (void)testInvalidLastName_InvalidCharacters {
    self.accountInformation.lastName = @"abcd '0";
    NSError *error;
    BOOL result = [self.accountInformation isLastNameValid:&error];
    XCTAssertFalse(result,@"Invalid last name, invalid characters");
}

- (void)testValidLastName_validCharacters_MinLength {
    self.accountInformation.lastName = @"abc";
    NSError *error;
    BOOL result = [self.accountInformation isLastNameValid:&error];
    XCTAssertTrue(result,@"Valid last Name.Min Length.");
}

- (void)testValidLastName_validCharacters {
    self.accountInformation.lastName = @"abcd d'";
    NSError *error;
    BOOL result = [self.accountInformation isLastNameValid:&error];
    XCTAssertTrue(result,@"Valid last Name.");
}

- (void)testValidLastName_validCharacters_MaxLength {
    self.accountInformation.lastName = @"a";
    self.accountInformation.lastName = [self.accountInformation.lastName stringByAppendingString:
                                        [[Helper sharedInstance] genRandStringLength:254]];
    NSError *error;
    BOOL result = [self.accountInformation isLastNameValid:&error];
    XCTAssertTrue(result,@"Valid last Name.Max Length.");
}



@end
