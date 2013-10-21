//
// Created by Tomasz Wyszomirski on 21/10/13.
// Copyright (c) 2013 Synappse. All rights reserved.

#import "NSString+XHTML.h"


static NSString *const kUnclosedImgTagPattern = @"(<img[^>]+)(?<!/)>";
static NSString *const kUnclosedImgTagSubstitutionTemplate = @"$1></img>";


@implementation NSString (XHTML)

- (NSData *) xhtmlData {

    NSString *xhtmlString = [self stringByClosingImgTags];
    xhtmlString = [xhtmlString stringByClosingHtmlBrTags];

    NSData *xhtmlData = [xhtmlString dataUsingEncoding:NSUTF8StringEncoding];
    return xhtmlData;
}

- (NSString *) stringByClosingHtmlBrTags {

    NSString *resultString = [self stringByReplacingOccurrencesOfString:@"<br>" withString:@"<br />"];
    resultString = [resultString stringByReplacingOccurrencesOfString:@"<BR>" withString:@"<BR />"];
    
    return resultString;
}

- (NSString *) stringByClosingImgTags {

    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:kUnclosedImgTagPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *resultString = [regex stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, self.length) withTemplate:kUnclosedImgTagSubstitutionTemplate];

    return resultString;
}

@end
