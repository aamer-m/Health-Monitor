//
//  Demo_Tests.m
//  Demo_1
//
//  Created by mohammed aamer on 9/20/15.
//  Copyright © 2015 mohammed aamer. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface Demo_Tests : XCTestCase

@property (nonatomic, strong) XCUIApplication *app;

@end

@implementation Demo_Tests

- (void)setUp {
    [super setUp];

    self.continueAfterFailure = NO;
    
    self.app = [[XCUIApplication alloc] init];
 
    [self.app launch];
}

- (void)tearDown {
    self.app = nil;
    [super tearDown];
}

- (void)testValidLogin {
    
    XCUIElement *usernameTextField = self.app.textFields[@"Username"];
    [usernameTextField tap];
    [usernameTextField typeText:@"amr_d"];
    XCUIElement *passwordSecureTextField = self.app.secureTextFields[@"Password"];
    [passwordSecureTextField tap];
    [passwordSecureTextField typeText:@"abcd890"];
    [self.app.buttons[@"Login"] tap];
}

- (void)testValidSignUp {

    [self.app.buttons[@"Not Signed Up?"] tap];
    
    XCUIElement *firstNameTextField = self.app.textFields[@"First Name"];
    [firstNameTextField tap];
    [firstNameTextField typeText:@"amr_d"];

    
    XCUIElement *lastNameTextField = self.app.textFields[@"Last Name"];
    [lastNameTextField tap];
    [lastNameTextField typeText:@"abc"];
    [self.app.textFields[@"Date of Birth"] tap];
    [self.app.datePickers.pickerWheels[@"2015"] swipeDown];
    [self.app.datePickers.pickerWheels[@"1994"] swipeDown];
    [self.app.datePickers.pickerWheels[@"1973"] tap];
    
    XCUIElement *usernameTextField = self.app.textFields[@"Username"];
    [usernameTextField tap];
    [usernameTextField typeText:@"amr_d"];
    
    XCUIElement *passwordSecureTextField = self.app.secureTextFields[@"Password"];
    [passwordSecureTextField tap];
    [passwordSecureTextField typeText:@"abcd890"];
    
    XCUIElement *phoneNumberTextField = self.app.textFields[@"Phone number"];
    [phoneNumberTextField tap];
    [phoneNumberTextField typeText:@"898989898989"];
    
    XCUIElement *genderTextField = self.app.textFields[@"Gender"];
    [genderTextField tap];
    
    XCUIElement *createButton = self.app.navigationBars[@"SigningUpView"].buttons[@"Create"];
    [createButton tap];
    
}


//    [self.app.alerts[@"Select a country"].collectionViews.buttons[@"Ok"] tap];
//    [genderTextField tap];
//    [[self.app.pickers childrenMatchingType:XCUIElementTypePickerWheel].element tap];
//    [self.app.textFields[@"Country"] tap];
//    [self.app.pickerWheels[@"Akrotiri"] swipeUp];
//    [self.app.pickerWheels[@"The Bahamas"] tap];
//    [createButton tap];
//    [[[[self.app.navigationBars[@"LogInView"] childrenMatchingType:XCUIElementTypeButton] matchingIdentifier:@"Back"] elementBoundByIndex:0] tap];
//    [[self.app.navigationBars[@"View"].buttons containingType:XCUIElementTypeStaticText identifier:@"Back"].element tap];

@end
