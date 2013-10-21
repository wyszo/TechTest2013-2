//
// Created by Tomasz Wyszomirski on 21/10/13.
// Copyright (c) 2013 Synappse. All rights reserved.

#import "NSData+XHTMLEmployeeDescriptions.h"
#import "NSString+XHTML.h"


@implementation NSData (XHTMLEmployeeDescriptions)

- (NSData *) xhtmlEmployeeDescriptions {

    NSString *htmlString = [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
    htmlString = [self htmlEmployeeDescriptionsFromHtmlString:htmlString];

    NSData *xhtmlData = [htmlString xhtmlData];
    return xhtmlData;
}

#pragma mark - Preparing TAB html document for parsing

- (NSString *) htmlEmployeeDescriptionsFromHtmlString:(NSString *)htmlString
{
    NSString *firstImportantTag = @"<div class=\"row\">";
    NSString *resultString = @"";

    NSRange range = [htmlString rangeOfString:firstImportantTag];

    if (NSNotFound != range.location) {

        resultString = [htmlString substringFromIndex:range.location];
        resultString = [NSString stringWithFormat:@"<html>%@", resultString];
    }

    return resultString;
}

@end
