//
//  SigningUpViewController.m
//  Health-Monitor
//
//  Created by mohammed aamer on 9/11/15.
//  Copyright (c) 2015 mohammed aamer. All rights reserved.
//

#import "SigningUpViewController.h"
#import "AccountInformation.h"
#import "LoginInformation.h"
#import "Constants.h"

@implementation UIScrollView(test)

- (id)findFirstResponder
{
    if (self.isFirstResponder) {
        return self;
    }
    for (UIView *subView in self.subviews) {
        if ([subView isFirstResponder]) return subView;
    }
    return nil;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    if (touch.tapCount == 2) {
        [self endEditing:YES];
    }
}

@end

@interface SigningUpViewController()<UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UIPickerViewAccessibilityDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *countryBottomConstraint;
@property (strong, nonatomic) AccountInformation *accountInformation;
@property (strong, nonatomic) UIPickerView *countryPicker;
@property (strong, nonatomic) UIDatePicker *datePicker;
@end

@implementation SigningUpViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (NSArray *)countryNames {
    return [NSArray arrayWithObjects:kEmptyString, @"Afghanistan", @"Akrotiri", @"Albania", @"Algeria", @"American Samoa", @"Andorra", @"Angola", @"Anguilla", @"Antarctica", @"Antigua and Barbuda", @"Argentina", @"Armenia", @"Aruba", @"Ashmore and Cartier Islands", @"Australia", @"Austria", @"Azerbaijan", @"The Bahamas", @"Bahrain", @"Bangladesh", @"Barbados", @"Bassas da India", @"Belarus", @"Belgium", @"Belize", @"Benin", @"Bermuda", @"Bhutan", @"Bolivia", @"Bosnia and Herzegovina", @"Botswana", @"Bouvet Island", @"Brazil", @"British Indian Ocean Territory", @"British Virgin Islands", @"Brunei", @"Bulgaria", @"Burkina Faso", @"Burma", @"Burundi", @"Cambodia", @"Cameroon", @"Canada", @"Cape Verde", @"Cayman Islands", @"Central African Republic", @"Chad", @"Chile", @"China", @"Christmas Island", @"Clipperton Island", @"Cocos (Keeling) Islands", @"Colombia", @"Comoros", @"Democratic Republic of the Congo", @"Republic of the Congo", @"Cook Islands", @"Coral Sea Islands", @"Costa Rica", @"Cote d'Ivoire", @"Croatia", @"Cuba", @"Cyprus", @"Czech Republic", @"Denmark", @"Dhekelia", @"Djibouti", @"Dominica", @"Dominican Republic", @"Ecuador", @"Egypt", @"El Salvador", @"Equatorial Guinea", @"Eritrea", @"Estonia", @"Ethiopia", @"Europa Island", @"Falkland Islands (Islas Malvinas)", @"Faroe Islands", @"Fiji", @"Finland", @"France", @"French Guiana", @"French Polynesia", @"French Southern and Antarctic Lands", @"Gabon", @"The Gambia", @"Gaza Strip", @"Georgia", @"Germany", @"Ghana", @"Gibraltar", @"Glorioso Islands", @"Greece", @"Greenland", @"Grenada", @"Guadeloupe", @"Guam", @"Guatemala", @"Guernsey", @"Guinea", @"Guinea-Bissau", @"Guyana", @"Haiti", @"Heard Island and McDonald Islands", @"Holy See (Vatican City)", @"Honduras", @"Hong Kong", @"Hungary", @"Iceland", @"India", @"Indonesia", @"Iran", @"Iraq", @"Ireland", @"Isle of Man", @"Israel", @"Italy", @"Jamaica", @"Jan Mayen", @"Japan", @"Jersey", @"Jordan", @"Juan de Nova Island", @"Kazakhstan", @"Kenya", @"Kiribati", @"North Korea", @"South Korea", @"Kuwait", @"Kyrgyzstan", @"Laos", @"Latvia", @"Lebanon", @"Lesotho", @"Liberia", @"Libya", @"Liechtenstein", @"Lithuania", @"Luxembourg", @"Macau", @"Macedonia", @"Madagascar", @"Malawi", @"Malaysia", @"Maldives", @"Mali", @"Malta", @"Marshall Islands", @"Martinique", @"Mauritania", @"Mauritius", @"Mayotte", @"Mexico", @"Federated States of Micronesia", @"Moldova", @"Monaco", @"Mongolia", @"Montserrat", @"Morocco", @"Mozambique", @"Namibia", @"Nauru", @"Navassa Island", @"Nepal", @"Netherlands", @"Netherlands Antilles", @"New Caledonia", @"New Zealand", @"Nicaragua", @"Niger", @"Nigeria", @"Niue", @"Norfolk Island", @"Northern Mariana Islands", @"Norway", @"Oman", @"Pakistan", @"Palau", @"Panama", @"Papua New Guinea", @"Paracel Islands", @"Paraguay", @"Peru", @"Philippines", @"Pitcairn Islands", @"Poland", @"Portugal", @"Puerto Rico", @"Qatar", @"Reunion", @"Romania", @"Russia", @"Rwanda", @"Saint Helena", @"Saint Kitts and Nevis", @"Saint Lucia", @"Saint Pierre and Miquelon", @"Saint Vincent and the Grenadines", @"Samoa", @"San Marino", @"Sao Tome and Principe", @"Saudi Arabia", @"Senegal", @"Serbia", @"Montenegro", @"Seychelles", @"Sierra Leone", @"Singapore", @"Slovakia", @"Slovenia", @"Solomon Islands", @"Somalia", @"South Africa", @"South Georgia and the South Sandwich Islands", @"Spain", @"Spratly Islands", @"Sri Lanka", @"Sudan", @"Suriname", @"Svalbard", @"Swaziland", @"Sweden", @"Switzerland", @"Syria", @"Taiwan", @"Tajikistan", @"Tanzania", @"Thailand", @"Tibet", @"Timor-Leste", @"Togo", @"Tokelau", @"Tonga", @"Trinidad and Tobago", @"Tromelin Island", @"Tunisia", @"Turkey", @"Turkmenistan", @"Turks and Caicos Islands", @"Tuvalu", @"Uganda", @"Ukraine", @"United Arab Emirates", @"United Kingdom", @"United States", @"Uruguay", @"Uzbekistan", @"Vanuatu", @"Venezuela", @"Vietnam", @"Virgin Islands", @"Wake Island", @"Wallis and Futuna", @"West Bank", @"Western Sahara", @"Yemen", @"Zambia", @"Zimbabwe", nil];
}

- (NSArray *)genderValues {
    return [NSArray arrayWithObjects:kEmptyString, @"Male", @"Female", @"Prefer not to say", nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.accountInformation = [[AccountInformation alloc] init];
    self.countryPicker = [[UIPickerView alloc] init];
    self.countryPicker.delegate = self;
    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker.maximumDate = self.datePicker.date;
    UITextField *dobField = (UITextField *)[self.scrollView viewWithTag:24];
    UITextField *countryField = (UITextField *)[self.scrollView viewWithTag:29];
    UITextField *genderField = (UITextField *)[self.scrollView viewWithTag:28];
    dobField.inputView = self.datePicker;
    genderField.inputView = self.countryPicker;
    countryField.inputView = self.countryPicker;
//    self.datePicker.
    [self.datePicker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (BOOL)shouldAutorotate {
    return FALSE;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self registerForKeyboardNotifications];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return ([self activeField].tag == 28) ? [self genderValues].count : [self countryNames].count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return ([self activeField].tag == 28) ? [self genderValues][row] : [self countryNames][row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if ([self activeField].tag == 28) {
        UITextField *genderField = (UITextField *)[self.scrollView viewWithTag:28];
        NSString *selectedGender = [self genderValues][row];
        genderField.text = selectedGender;
        self.accountInformation.gender = selectedGender;
    } else {
        UITextField *countryField = (UITextField *)[self.scrollView viewWithTag:29];
        NSString *selectedCountry = [self countryNames][row];
        countryField.text = selectedCountry;
        self.accountInformation.country = selectedCountry;
    }
}


- (void)dateChanged {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    NSString *dateString = [dateFormatter stringFromDate:self.datePicker.date];
    UITextField *dateField = (UITextField *)[self.scrollView viewWithTag:24];
    dateField.text = dateString;
    self.accountInformation.dateOfBirth = dateString;
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    NSInteger nextTag = textField.tag + 1;
    
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if ([nextResponder isKindOfClass:[UITextField class]]) {
        [nextResponder becomeFirstResponder];
    } else {
        
        [textField resignFirstResponder];
    }
    return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *finalString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    switch (textField.tag) {
        case 21:
            self.accountInformation.firstName = finalString;
            break;
        case 22:
            self.accountInformation.middleName = finalString;
            break;
        case 23:
            self.accountInformation.lastName = finalString;
            break;
        case 24:
            self.accountInformation.dateOfBirth = finalString;
            break;
        case 25:
            self.accountInformation.loginInformation.username = finalString;
            break;
        case 26:
            self.accountInformation.loginInformation.password = finalString;
            break;
        case 27:
            self.accountInformation.phoneNumber = finalString;
            if (finalString.length > 10)
                return NO;
            break;
        case 28:
            self.accountInformation.gender = finalString;
            break;
        case 29:
            self.accountInformation.country = finalString;
            break;
        default:
            break;
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self.countryPicker reloadAllComponents];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    switch (textField.tag) {
        case 21:
            self.accountInformation.firstName = kEmptyString;
            break;
        case 22:
            self.accountInformation.middleName = kEmptyString;
            break;
        case 23:
            self.accountInformation.lastName = kEmptyString;
            break;
        case 24:
            self.accountInformation.dateOfBirth = kEmptyString;
            break;
        case 25:
            self.accountInformation.loginInformation.username = kEmptyString;
            break;
        case 26:
            self.accountInformation.loginInformation.password = kEmptyString;
            break;
        case 27:
            self.accountInformation.phoneNumber = kEmptyString;
            break;
        case 28:
            self.accountInformation.gender = kEmptyString;
            break;
        case 29:
            self.accountInformation.country = kEmptyString;
            break;
        default:
            break;
    }
    
    return YES;
}

- (UITextField *)activeField{
    return [self.scrollView findFirstResponder];
}


- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    [self adjustHeight:YES forNotification:aNotification];

}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [self adjustHeight:NO forNotification:aNotification];
}



- (void)adjustHeight:(BOOL)show forNotification:(NSNotification *) aNotification {
    
    NSDictionary *info = [aNotification userInfo];
    CGRect keyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat height = keyboardRect.size.height;
    
    CGRect aRect = self.scrollView.frame;
    aRect.size.height -= (height + 100);
    if (!CGRectContainsPoint(aRect,
                             [self activeField].frame.origin)) {
        CGPoint scrollPoint = CGPointMake(0.0, [self activeField].frame.origin.y - height - 40);
        UIEdgeInsets contentInset = self.scrollView.contentInset;
        contentInset.bottom = scrollPoint.y;
        self.scrollView.contentInset = contentInset;
    }

}
- (IBAction)createAccountTapped:(id)sender {
    NSError *error;
    if ([self.accountInformation isFormAcceptable:&error]) {
        [self dismissViewControllerAnimated:NO completion:^{
            [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"LoggedIn"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LoggedIn" object:nil];
        }];
    }
    else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:error.domain preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        alertController.preferredAction = okAction;
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
- (IBAction)dismissTapped:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
