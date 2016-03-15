//
//  AllergiesViewController.m
//  Health-Monitor
//
//  Created by mohammed aamer on 11/30/15.
//  Copyright © 2015 mohammed aamer. All rights reserved.
//

#import "AllergiesViewController.h"
#import "LogoutObject.h"
#import "ImageDetailTableViewCell.h"
#import "AllergyInformation.h"

@interface AllergiesViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *allergies;

@end

@implementation AllergiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [LogoutObject addLogoutIconInViewController:self];
    NSMutableArray *rightBarButtonItems = [self.navigationItem.rightBarButtonItems mutableCopy];
    UIBarButtonItem *editBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editTapped:)];
    [rightBarButtonItems addObject:editBarButtonItem];
    self.navigationItem.rightBarButtonItems = rightBarButtonItems;
    
    self.tableView.allowsMultipleSelection = false;
    self.tableView.allowsSelection = false;
    
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
    self.allergies = [array copy];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ImageDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate {
    return TRUE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ImageDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    AllergyInformation *allergy = self.allergies[indexPath.row];
    cell.title.text = allergy.name;
    NSString *urlString = allergy.imageURL;
    cell.mainImageView.image = [UIImage imageNamed:@"placeholder"];
    if (allergy.hasAllergy.boolValue)
        cell.selectionImageView.image = [UIImage imageNamed:@"checkmark.png"];
    else
        cell.selectionImageView.image = nil;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.mainImageView.image = [UIImage imageWithData:data];
            [cell setNeedsLayout];
            [cell layoutIfNeeded];
        });
    });
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allergies.count;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AllergyInformation *allergy = self.allergies[indexPath.row];
    allergy.hasAllergy = @(!allergy.hasAllergy.boolValue);
    CGPoint offset = self.tableView.contentOffset;
    [self.tableView beginUpdates];
    [self.allergies[indexPath.row] setHasAllergy:allergy.hasAllergy];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
    [self.tableView.layer removeAllAnimations];
    self.tableView.contentOffset = offset;
}
- (IBAction)editTapped:(UIBarButtonItem *)sender {
    if (self.tableView.allowsSelection) {
        self.tableView.allowsSelection = false;
        self.tableView.allowsMultipleSelection = false;
        sender.title = @"Edit";
    } else {
        self.tableView.allowsSelection = true;
        self.tableView.allowsMultipleSelection = true;
        sender.title = @"Done";
    }

}

@end
