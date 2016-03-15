//
//  AllergyInformation.m
//  Health-Monitor
//
//  Created by mohammed aamer on 12/2/15.
//  Copyright © 2015 mohammed aamer. All rights reserved.
//

#import "AllergyInformation.h"

@implementation AllergyInformation

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"\nname:%@\nimageURL:%@\nhasAllergy:%@\nTriggers:%@\n",_name,_imageURL,_hasAllergy,_triggers];
}

@end
