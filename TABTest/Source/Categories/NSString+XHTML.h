//
// Created by Tomasz Wyszomirski on 21/10/13.
// Copyright (c) 2013 Synappse. All rights reserved.

@interface NSString (XHTML)

- (NSData *) xhtmlData;

- (NSString *) stringByClosingHtmlBrTags;
- (NSString *) stringByClosingImgTags;

@end
