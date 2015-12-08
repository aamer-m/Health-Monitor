//
//  LoginInformation.h
//  Demo_1
//
//  Created by mohammed aamer on 9/18/15.
//  Copyright (c) 2015 mohammed aamer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginInformation : NSObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;

- (BOOL)isUsernameValid:(NSError **)error;
- (BOOL)isPasswordValid:(NSError **)error;
- (BOOL)isFormAcceptable:(NSError **)error;
@end
