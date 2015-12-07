//
//  LoginInformation_UsernameTests.m
//  Demo_1
//
//  Created by mohammed aamer on 9/20/15.
//  Copyright (c) 2015 mohammed aamer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "LoginInformation.h"

@interface LoginInformation_UsernameTests : XCTestCase

@property (nonatomic, strong) LoginInformation *loginInformation;

@end

@implementation LoginInformation_UsernameTests

- (void)setUp {
    [super setUp];
    self.loginInformation = [[LoginInformation alloc] init];
}

- (void)tearDown {
    self.loginInformation = nil;
    [super tearDown];
}

//Test User Name
- (void)testInvalidUsername_EmptyString {
    self.loginInformation.username = @"";
    NSError *error;
    BOOL result = [self.loginInformation isUsernameValid:&error];
    XCTAssertFalse(result,@"Invalid user name. Only alphabets, hyphen, underscore and numbers are allowed.");
}

- (void)testInvalidUsername_NumberString {
    self.loginInformation.username = @"123";
    NSError *error;
    BOOL result = [self.loginInformation isUsernameValid:&error];
    XCTAssertFalse(result,@"Invalid user name. Only alphabets, hyphen, underscore and numbers are allowed.");
}

- (void)testInvalidUsername_MinLength {
    self.loginInformation.username = @"aab";
    NSError *error;
    BOOL result = [self.loginInformation isUsernameValid:&error];
    XCTAssertFalse(result,@"Invalid user name. Minimum length allowed is 4.");
}

- (NSString *)genRandStringLength:(int)len {
    static NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((unsigned int)[letters length])]];
    }
    return randomString;
}

- (void)testInvalidUsername_MaxLength {
    self.loginInformation.username = [self genRandStringLength:9];
    NSError *error;
    BOOL result = [self.loginInformation isUsernameValid:&error];
    XCTAssertFalse(result,@"Invalid user name. Minimum length allowed is 8.");
}

- (void)testInvalidUsername_NumericStart {
    self.loginInformation.username = @"0abc_-";
    NSError *error;
    BOOL result = [self.loginInformation isUsernameValid:&error];
    XCTAssertFalse(result,@"Invalid user name. Invalid first character.");
}

- (void)testInvalidUsername_InvalidCharacters {
    self.loginInformation.username = @"abcd '0";
    NSError *error;
    BOOL result = [self.loginInformation isUsernameValid:&error];
    XCTAssertFalse(result,@"Invalid user name, invalid characters.");
}

- (void)testValidUsername_validCharacters_MinLength {
    self.loginInformation.username = @"abcd";
    NSError *error;
    BOOL result = [self.loginInformation isUsernameValid:&error];
    XCTAssertTrue(result,@"Valid user name.Min length.");
}

- (void)testValidUsername_validCharacters {
    self.loginInformation.username = @"abcd9-_";
    NSError *error;
    BOOL result = [self.loginInformation isUsernameValid:&error];
    XCTAssertTrue(result,@"Valid user name.");
}

- (void)testValidUsername_validCharacters_MaxLength {
    self.loginInformation.username = @"cd9-_99a";
    NSError *error;
    BOOL result = [self.loginInformation isUsernameValid:&error];
    XCTAssertTrue(result,@"Valid user name.Max length.");
}
@end
