//
//  AllergyInformation.h
//  Demo_1
//
//  Created by mohammed aamer on 12/2/15.
//  Copyright © 2015 mohammed aamer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllergyInformation : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *imageURL;
@property (copy, nonatomic) NSNumber *hasAllergy;
@property (copy, nonatomic) NSArray *triggers;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
