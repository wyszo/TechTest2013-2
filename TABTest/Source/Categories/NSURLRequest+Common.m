//
// Created by Tomasz Wyszomirski on 21/10/13.
// Copyright (c) 2013 Synappse. All rights reserved.

#import "NSURLRequest+Common.h"


@implementation NSURLRequest (Common)

+ (NSURLRequest *) urlRequestWithURLString:(NSString *)urlString {

    NSURLRequest *request = nil;

    if (urlString.length > 0) {

        NSURL *url = [NSURL URLWithString:urlString];
        request = [[NSURLRequest alloc] initWithURL:url];
    }
    return request;
}

@end
