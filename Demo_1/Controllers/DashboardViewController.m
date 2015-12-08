//
//  DashboardViewController.m
//  Demo_1
//
//  Created by mohammed aamer on 11/30/15.
//  Copyright © 2015 mohammed aamer. All rights reserved.
//

#import "DashboardViewController.h"
#import "CollectionViewCell.h"
#import "LogoutObject.h"

@implementation UIImage (color)

- (UIImage *)imageWithColor:(UIColor *)color1
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color1 setFill];
    CGContextFillRect(context, rect);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end

@interface DashboardViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *titles;
@end

@implementation DashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNeedsStatusBarAppearanceUpdate];
    
    [LogoutObject addLogoutIconInViewController:self];
    for (UITabBarItem *item in self.tabBarController.tabBar.items) {
        item.image = [[item.selectedImage imageWithColor:[UIColor blackColor]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    self.titles = @[@"Allergies", @"Weight Graph", @"Recent Health History", @"Scan barcode for Allergy"];
    self.automaticallyAdjustsScrollViewInsets = FALSE;
//    UIColor *lightGreenColor = [UIColor colorWithRed:(55.0/255) green:(194.0/255) blue:(117.0/255) alpha:1.0];
    
//    self.collectionView.layer.borderColor = lightGreenColor.CGColor;
//    self.collectionView.layer.cornerRadius = 3.0;
//    self.collectionView.layer.borderWidth = 4.0f;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate {
    return TRUE;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.nameLabel.text = self.titles[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self performSegueWithIdentifier:@"allergies" sender:indexPath];
            break;
        case 1:
            [self performSegueWithIdentifier:@"weightGraph" sender:indexPath];
            break;
        case 2:
            [self performSegueWithIdentifier:@"treatmentHistory" sender:indexPath];
            break;
        case 3:
            [self performSegueWithIdentifier:@"barCodeSegue" sender:indexPath];
            break;
        default:
            break;
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
