//
//  Helper.h
//  Demo_1
//
//  Created by mohammed aamer on 9/19/15.
//  Copyright (c) 2015 mohammed aamer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helper : NSObject

+ (instancetype)sharedInstance;

- (BOOL)evaluateString:(NSString *)string withRegex:(NSString *)regex;

- (void)setError:(NSError **)error inDomain:(NSString *)domain
         message:(NSString *)message withCode:(NSInteger)code;

- (NSString *)genRandStringLength:(int)length;

- (NSString *)getReadableDateWithDate:(NSDate *)date;

@end
