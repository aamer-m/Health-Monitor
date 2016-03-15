//
//  Helper.m
//  Health-Monitor
//
//  Created by mohammed aamer on 9/19/15.
//  Copyright (c) 2015 mohammed aamer. All rights reserved.
//

#import "Helper.h"

@implementation Helper

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


- (BOOL)evaluateString:(NSString *)string withRegex:(NSString *)regex {
    NSPredicate *myTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [myTest evaluateWithObject:string];
}

- (void)setError:(NSError **)error inDomain:(NSString *)domain
         message:(NSString *)message withCode:(NSInteger)code {
    NSMutableDictionary *details = [NSMutableDictionary dictionary];
    [details setValue:message forKey:NSLocalizedDescriptionKey];
    *error = [NSError errorWithDomain:message code:code userInfo:details];
}

- (NSString *)genRandStringLength:(int)length {
    static NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    for (int i=0; i<length; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((unsigned int)[letters length])]];
    }
    return randomString;
}

- (NSString *)getReadableDateWithDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSInteger daysFrom = [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:date];
    if (daysFrom == 0) {
        return @"Today";
    } else if (daysFrom <= 7) {
        dateFormatter.dateFormat = @"EEEE";
        return [[dateFormatter stringFromDate:date] capitalizedString];
    } else {
        dateFormatter.dateStyle = NSDateFormatterShortStyle;
        return [dateFormatter stringFromDate:date];
    }
}

- (void)writeString:(NSString *)aString toFile:(NSString*)fileName {
    
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileAtPath]) {
        [[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:nil attributes:nil];
    }
    
    [[aString dataUsingEncoding:NSUTF8StringEncoding] writeToFile:fileAtPath atomically:NO];
}

- (NSString*)readStringFromFile:(NSString *)fileName {
    
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    return [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:fileAtPath] encoding:NSUTF8StringEncoding];
}

@end
