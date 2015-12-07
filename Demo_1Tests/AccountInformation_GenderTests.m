//
//  AccountInformation_GenderTests.m
//  Demo_1
//
//  Created by mohammed aamer on 9/20/15.
//  Copyright © 2015 mohammed aamer. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AccountInformation.h"

@interface AccountInformation_GenderTests : XCTestCase

@property (nonatomic, strong) AccountInformation *accountInformation;

@end

@implementation AccountInformation_GenderTests

- (void)setUp {
    [super setUp];
    self.accountInformation = [[AccountInformation alloc] init];
}

- (void)tearDown {
    self.accountInformation = nil;
    [super tearDown];
}

- (void)testInvalidGender_NumericString {
    self.accountInformation.gender = @"123";
    NSError *error;
    BOOL result = ([self.accountInformation isGenderValid:&error]);
    XCTAssertFalse(result, @"Gender should be one of the given values.");
    
}

- (void)testInvalidGender_SpaceString {
    self.accountInformation.gender = @"      ";
    NSError *error;
    BOOL result = ([self.accountInformation isGenderValid:&error]);
    XCTAssertFalse(result, @"Gender should be one of the given values.");
}

- (void)testValidGender_ValidValue {
    self.accountInformation.gender = @"";
    NSError *error;
    BOOL result = ([self.accountInformation isGenderValid:&error]);
    XCTAssertTrue(result, @"Empty gender value.");
}

- (void)testValidGender_ValidValue_2 {
    self.accountInformation.gender = @"Prefer not to say";
    NSError *error;
    BOOL result = ([self.accountInformation isGenderValid:&error]);
    XCTAssertTrue(result, @"One of the gender value.");
}

@end
