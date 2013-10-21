//
// Created by Tomasz Wyszomirski on 21/10/13.
// Copyright (c) 2013 Synappse. All rights reserved.

#import "NSString+Common.h"


@implementation NSString (Common)

- (NSString *) stringByTrimmingWhitespaceAndNewline {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL) containsSubstring:(NSString *)substring {

    BOOL containsSubstring = ([self rangeOfString:substring].location != NSNotFound);
    return containsSubstring;
}

@end
