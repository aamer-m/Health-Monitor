//
//  BarCodeViewController.m
//  Demo_1
//
//  Created by mohammed aamer on 12/4/15.
//  Copyright © 2015 mohammed aamer. All rights reserved.
//

#import "BarCodeViewController.h"
#include <MTBBarcodeScanner/MTBBarcodeScanner.h>
#include "AllergyInformation.h"
#include "LogoutObject.h"

static NSString * const DIGIT_EYES_API_KEY = @"//dHGyM0sqz+";
static NSString * const DIGIT_EYES_AUTH_KEY = @"Zp15E5t9x8Bs2Uj7";
static NSString * const DIGIT_EYES_SIGNATURE =  @"UeF1NSeHtFm19s+Juv1YwqldzfI=";
static NSString * const DIGIT_EYES_UPC_SEARCH_URL =  @"https://www.digit-eyes.com/gtin/v2_0/?upcCode=%@&field_names=description,ingredients&language=en&app_key=%@&signature=%@";


@interface BarCodeViewController ()
@property (weak, nonatomic) IBOutlet UIView *scannerView;

@property (strong, nonatomic) MTBBarcodeScanner *scanner;

@end

@implementation BarCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [LogoutObject addLogoutIconInViewController:self];
    // Do any additional setup after loading the view.
    self.title = @"Bar Code Scanner";
    self.scanner = [[MTBBarcodeScanner alloc] initWithPreviewView:self.scannerView];
    self.scannerView.backgroundColor = [UIColor lightGrayColor];
    self.scannerView.hidden = TRUE;
}

- (IBAction)buttonTapped:(id)sender {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.scannerView.hidden = FALSE;
    });

    
    [MTBBarcodeScanner requestCameraPermissionWithSuccess:^(BOOL success) {

        if (success) {
            
            [self.scanner startScanningWithResultBlock:^(NSArray *codes) {
                AVMetadataMachineReadableCodeObject *code = [codes firstObject];
                NSLog(@"Found code: %@", code.stringValue);
                [self handleBarcodeValue:code.stringValue];
                [self.scanner stopScanning];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.scannerView.hidden = TRUE;
                });

            }];
            
        } else {
            NSLog(@"User access to camera is denied.");
            NSString *codestringValue = @"0034000040339";
            [self handleBarcodeValue:codestringValue];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.scannerView.hidden = TRUE;
            });

        }
    }];
}

- (void)handleBarcodeValue:(NSString *)stringValue {
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self fetchIngredientsForBarcode:stringValue];
    });
}


- (void)fetchIngredientsForBarcode:(NSString *)barcodeString {
    
    NSString *urlString1 = [NSString stringWithFormat:DIGIT_EYES_UPC_SEARCH_URL,
                            barcodeString,
                            DIGIT_EYES_API_KEY,
                            DIGIT_EYES_SIGNATURE];
    
    NSURL *url = [NSURL URLWithString:urlString1];
    
    
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
        if (httpResp.statusCode == 200) {
            
            NSError *jsonError;

            NSDictionary *jsonDictionary =
            [NSJSONSerialization JSONObjectWithData:data
                                            options:NSJSONReadingAllowFragments
                                              error:&jsonError];
            NSString *ingredients = jsonDictionary[@"ingredients"];
            NSString *title = jsonDictionary[@"description"];
            NSLog(@"%@", jsonDictionary);
            
            if (jsonError) {
                NSLog(@"Something is wrong while decoding the barcode data.!!!");
            } else {
                NSArray *triggers = [self triggersForAllergies];
                NSMutableArray *allergicItems = [NSMutableArray array];
                for (NSString *string in triggers) {
                    if ([ingredients containsString:string]){
                        [allergicItems addObject:string];
                    }
                }
                NSString *stringMessage = @"";
                if (allergicItems.count > 0) {
                    NSString *itemsString = [allergicItems componentsJoinedByString:@", "];
                    stringMessage = [NSString stringWithFormat:@"This product has ingredient which may be allergic to you\n%@.",itemsString];
                } else {
                    stringMessage = @"This product doesn't seem to contain any ingredients which may cause you allergy.";
                }
                [self showAlertWithMessage:stringMessage title:title];
            }
        } else {
            NSError *jsonError;
            
            NSDictionary *jsonDictionary =
            [NSJSONSerialization JSONObjectWithData:data
                                            options:NSJSONReadingAllowFragments
                                              error:&jsonError];
            [self showAlertWithMessage:jsonDictionary.description title:@"Error"];
        }
        
        
        
    }] resume];
}

- (NSArray *)triggersForAllergies {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"allergies" ofType:@"json"];
    NSError *error = nil;
    
    NSData *JSONData = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&error];
    
    NSMutableDictionary *fetchedDictionary = [NSJSONSerialization
                                              JSONObjectWithData:JSONData
                                              options:NSJSONReadingAllowFragments
                                              error:&error];
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSDictionary *dictionary in fetchedDictionary[@"allergies"]) {
        AllergyInformation *allergy = [[AllergyInformation alloc] initWithDictionary:dictionary];
        [array addObject:allergy];
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"hasAllergy==1 AND triggers.@count != 0"];
    [array filterUsingPredicate:predicate];
    NSMutableArray *triggers = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(AllergyInformation *obj, NSUInteger idx, BOOL * _Nonnull stop) {

        [triggers addObjectsFromArray:obj.triggers];
    }];
    NSLog(@"%@",triggers);
    return triggers;
}

- (void)showAlertWithMessage:(NSString *)message title:(NSString *)title{
    dispatch_async(dispatch_get_main_queue(), ^{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    
    alertController.preferredAction = okAction;
    [self presentViewController:alertController animated:YES completion:nil];
    });
}

@end
