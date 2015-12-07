//
//  AccountInformation_MiddleNameTests.m
//  Demo_1
//
//  Created by mohammed aamer on 9/20/15.
//  Copyright © 2015 mohammed aamer. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AccountInformation.h"

@interface AccountInformation_MiddleNameTests : XCTestCase

@property (nonatomic, strong) AccountInformation *accountInformation;

@end

@implementation AccountInformation_MiddleNameTests

- (void)setUp {
    [super setUp];
    self.accountInformation = [[AccountInformation alloc] init];
}

- (void)tearDown {
    self.accountInformation = nil;
    [super tearDown];
}

- (void)testInvalidMiddleName_InvalidCharacters {
    self.accountInformation.middleName = @"*)(*adfa";
    NSError *error;
    BOOL result = [self.accountInformation isMiddleNameValid:&error];
    XCTAssertFalse(result, @"Middle name should have only alphabets, hyphen, apostrophe and spaces.");
}

- (void)testValidMiddleName_EmptyString {
    self.accountInformation.middleName = @"";
    NSError *error;
    BOOL result = [self.accountInformation isMiddleNameValid:&error];
    XCTAssertTrue(result, @"Valid Middle name");
}

- (void)testValidMiddleName{
    self.accountInformation.middleName = @"abcd-d a'";
    NSError *error;
    BOOL result = [self.accountInformation isMiddleNameValid:&error];
    XCTAssertTrue(result, @"Valid Middle name");
}
@end
