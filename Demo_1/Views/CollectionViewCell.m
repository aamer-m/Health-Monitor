//
//  CollectionViewCell.m
//  Demo_1
//
//  Created by mohammed aamer on 11/30/15.
//  Copyright © 2015 mohammed aamer. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    return self;
}

- (void)layoutSubviews {
    self.layer.cornerRadius = 5.0;
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
}

@end
