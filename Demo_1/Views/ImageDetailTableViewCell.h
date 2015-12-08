//
//  ImageDetailTableViewCell.h
//  Demo_1
//
//  Created by mohammed aamer on 12/2/15.
//  Copyright © 2015 mohammed aamer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIImageView *selectionImageView;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
