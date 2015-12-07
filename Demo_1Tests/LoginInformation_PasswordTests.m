//
//  LoginInformation_PasswordTests.m
//  Demo_1
//
//  Created by mohammed aamer on 9/20/15.
//  Copyright (c) 2015 mohammed aamer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "LoginInformation.h"

@interface LoginInformation_PasswordTests : XCTestCase

@property (nonatomic, strong) LoginInformation *loginInformation;

@end

@implementation LoginInformation_PasswordTests

- (void)setUp {
    [super setUp];
    self.loginInformation = [[LoginInformation alloc] init];
}

- (void)tearDown {
    self.loginInformation = nil;
    [super tearDown];
}

//Test password
- (void)testInvalidPassword_EmptyString {
    self.loginInformation.password = @"";
    NSError *error;
    BOOL result = [self.loginInformation isPasswordValid:&error];
    XCTAssertFalse(result,@"Invalid password. Only alphabets and numbers are allowed.");
}

- (void)testInvalidPassword_MinLength {
    self.loginInformation.password = @"aabc0";
    NSError *error;
    BOOL result = [self.loginInformation isPasswordValid:&error];
    XCTAssertFalse(result,@"Invalid password. Minimum length allowed is 6.");
}

- (NSString *)genRandStringLength:(int)len {
    static NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((unsigned int)[letters length])]];
    }
    return randomString;
}


- (void)testInvalidPassword_MaxLength {
    self.loginInformation.password = [self genRandStringLength:17];
    NSError *error;
    BOOL result = [self.loginInformation isPasswordValid:&error];
    XCTAssertFalse(result,@"Invalid password. Maximum length allowed is 16.");
}

- (void)testInvalidPassword_NumericStart {
    self.loginInformation.password = @"0abc_-";
    NSError *error;
    BOOL result = [self.loginInformation isPasswordValid:&error];
    XCTAssertFalse(result,@"Invalid password. Invalid first character.");
}

- (void)testInvalidPassword_InvalidCharacters {
    self.loginInformation.password = @"abcd '0";
    NSError *error;
    BOOL result = [self.loginInformation isPasswordValid:&error];
    XCTAssertFalse(result,@"Invalid password, invalid characters.");
}

- (void)testValidPassword_validCharacters_MinLength {
    self.loginInformation.password = @"abAB90";
    NSError *error;
    BOOL result = [self.loginInformation isPasswordValid:&error];
    XCTAssertTrue(result,@"Valid password.Min length is 6.");
}

- (void)testValidPassword_validCharacters {
    self.loginInformation.password = @"abcd9BADFadf";
    NSError *error;
    BOOL result = [self.loginInformation isPasswordValid:&error];
    XCTAssertTrue(result,@"Valid password.");
}

- (void)testValidPassword_validCharacters_MaxLength {
    self.loginInformation.password = @"vbADBC1M22aAZOAD";
    NSError *error;
    BOOL result = [self.loginInformation isPasswordValid:&error];
    XCTAssertTrue(result,@"Valid password.Max length is 16.");
}
@end
