//
//  NSString+Concatenation.m
//  ShazamTestProj
//
//  Created by Wyszo on 10/14/13.
//  Copyright (c) 2013 Wyszo. All rights reserved.
//

#import "NSString+Concatenation.h"

@implementation NSString (Concatenation)

+ (NSString *) safeAppendString:(NSString *)stringToAppend toString:(NSString *)string {
    
    NSString *baseString = string;
    if (baseString == nil) {
        baseString = @"";
    }
    
    NSString *toAppend = stringToAppend;
    if (stringToAppend == nil) {
        toAppend = @"";
    }
    
    NSString *result = [NSString stringWithFormat:@"%@%@", baseString, toAppend];
    return result;
}

@end
