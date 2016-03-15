//
//  Health-MonitorUITests.m
//  Health-MonitorUITests
//
//  Created by mohammed aamer on 9/20/15.
//  Copyright © 2015 mohammed aamer. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface Health_MonitorUITests : XCTestCase
@property (nonatomic, strong) XCUIApplication *app;
@end

@implementation Health_MonitorUITests
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

- (void)login {
    XCUIElement *usernameTextField = self.app.textFields[@"Type Username here..."];
    if (self.app.navigationBars[@"Dashboard"].exists) {
        [self.app.buttons[@"logout"] tap];
        [self.app.sheets.buttons[@"Logout"] tap];
        XCTAssertTrue(usernameTextField.exists, "Login page should be displayed");
    }
    [usernameTextField tap];
    [usernameTextField typeText:@"amr_d"];
    XCUIElement *passwordSecureTextField = self.app.secureTextFields[@"Type Password here..."];
    [passwordSecureTextField tap];
    [passwordSecureTextField typeText:@"abcd890"];
    [self.app.buttons[@"Ready to Login"] tap];
}

- (void)testValidLogin {
    [self login];
    XCTAssertTrue(self.app.navigationBars[@"Dashboard"].exists, @"Dashboard should be shown instead of %@",self.app.navigationBars.element.title);
}

- (void)testValidSignUp {
    XCUIElement *loginUsernameTextField = self.app.textFields[@"Type Username here..."];
    if (self.app.navigationBars[@"Dashboard"].exists) {
        [self.app.buttons[@"logout"] tap];
        [self.app.sheets.buttons[@"Logout"] tap];
        XCTAssertTrue(loginUsernameTextField.exists, "Login page should be displayed");
    }
    [self.app.buttons[@"Not Signed Up?"] tap];
    
    XCUIElement *firstNameTextField = self.app.textFields[@"First Name"];
    [firstNameTextField tap];
    [firstNameTextField typeText:@"amr_d"];
    
    
    XCUIElement *lastNameTextField = self.app.textFields[@"Last Name"];
    [lastNameTextField tap];
    [lastNameTextField typeText:@"abc"];
    [self.app.textFields[@"Date of Birth"] tap];
    [[self.app.pickerWheels elementBoundByIndex:2] adjustToPickerWheelValue:@"1990"];
    [[self.app.pickerWheels elementBoundByIndex:2] tap];
    [[self.app.pickerWheels elementBoundByIndex:0] adjustToPickerWheelValue:@"December"];
    [[self.app.pickerWheels elementBoundByIndex:0] tap];
    [[self.app.pickerWheels elementBoundByIndex:1] adjustToPickerWheelValue:@"19"];
    [[self.app.pickerWheels elementBoundByIndex:1] tap];

    XCTAssertTrue(self.app.textFields[@"12/19/90"].exists, "Selected date should be shown");
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
    
    [[self.app.pickers.pickerWheels elementBoundByIndex:0] adjustToPickerWheelValue:@"Male"];
    [[self.app.pickers.pickerWheels elementBoundByIndex:0] tap];
    
    XCUIElement *countryTextField = self.app.textFields[@"Country"];
    [countryTextField tap];
    [self.app.pickerWheels.element adjustToPickerWheelValue:@"India"];
    [self.app.pickerWheels.element tap];
    XCUIElement *createButton = self.app.navigationBars[@"New Account"].buttons[@"Create Account"];
    if (createButton.enabled) {
        [createButton tap];
        XCTAssertTrue(self.app.navigationBars[@"Dashboard"].exists, "Dashboard should be displayed");
    } else {
        XCTFail("Something is wrong!. Check the implementation again.");
    }
}

- (void)testAllergiesFlow {
    [self login];
    [[[[self.app.collectionViews elementBoundByIndex:0] cells] elementBoundByIndex:0] tap];
    XCTAssertTrue(self.app.navigationBars[@"Allergies"].exists, @"Allergies screen should be displayed");
    [self.app.navigationBars.buttons[@"Edit"] tap];
    XCUIElement *foodAllergyElement = [[[[self.app.tables elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeCell] containingType:XCUIElementTypeStaticText identifier:@"Food Allergy"] element];
    bool isCheckedOne = foodAllergyElement.images[@"checkmark.png"].exists;
    [foodAllergyElement tap];
    bool isCheckedTwo = foodAllergyElement.images[@"checkmark.png"].exists;
    XCTAssertTrue(isCheckedOne != isCheckedTwo, @"Selected element should change");
}

- (void)testWeightGraphFlow {
//    [self login];
    XCUIElement *weightGraphElement = [self.app.collectionViews elementBoundByIndex:0].cells.staticTexts[@"Weight Graph"];
    [weightGraphElement tap];
    XCTAssertTrue(self.app.navigationBars[@"Weight Graph"].exists, @"Weight Graph screen should be displayed");
    [self.app.buttons[@"Add"] tap];
    
    XCUIElementQuery *alertQuery = self.app.alerts[@"Add Weight"].collectionViews;
    XCUIElement *weightTextField = alertQuery.textFields[@"Type weight here"];
    [weightTextField tap];
    [weightTextField typeText:@"98"];
    
    XCUIElement *okButton = alertQuery.buttons[@"OK"];
    [okButton tap];
    
    [self.app.buttons[@"List"] tap];
    XCUIElement *weightElement98 = [[[[self.app.tables elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeCell] containingType:XCUIElementTypeStaticText identifier:@"98"] element];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd MMM, yy"];
    NSDate *date = [NSDate date];
    NSString *dateString = [dateFormatter stringFromDate:date];
    XCTAssert(weightElement98.staticTexts[dateString].exists, @"Inserted weight is displayed in the table");
}

- (void)testRecentHealthHistory {
    [self login];
    XCUIElement *weightGraphElement = [self.app.collectionViews elementBoundByIndex:0].cells.staticTexts[@"Recent Health History"];
    [weightGraphElement tap];
    XCTAssertTrue(self.app.navigationBars[@"Treatment History"].exists, @"Treatment History screen should be displayed");
    XCUIElement *hospital = [[[self.app.tables childrenMatchingType:XCUIElementTypeCell] containingType:XCUIElementTypeStaticText identifier:@"Good Samaritan Hospital"] elementBoundByIndex:0];
    XCTAssertTrue([hospital exists]);
    [hospital tap];
    [self addUIInterruptionMonitorWithDescription:@"Location Dialog" handler:^BOOL(XCUIElement * _Nonnull interruptingElement) {
        [interruptingElement.buttons[@"Allow"] tap];
        return true;
    }];
    [self.app tap];
    XCUIElement *mapElement = [self.app.otherElements containingType:XCUIElementTypeStaticText identifier:@"Good Samaritan Hospital"].element;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"exists == true"];
    [self expectationForPredicate:predicate evaluatedWithObject:mapElement handler:nil];
    [self waitForExpectationsWithTimeout:3 handler:^(NSError * _Nullable error) {
        if (error != nil) {
            XCTFail(@"Map should be displayed");
        } else {
            XCTAssertTrue(mapElement.exists, "Location exists");
        }
    }];
}
@end