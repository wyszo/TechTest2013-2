//
// Created by Tomasz Wyszomirski on 21/10/13.
// Copyright (c) 2013 Synappse. All rights reserved.

typedef void (^fetchHtmlPageCompletionBlock)(NSData *htmlPage, NSError *error);


@interface TABNetworkManager : NSObject

- (void) asyncFetchHTMLPageWithURLString:(NSString *)urlString completion:(fetchHtmlPageCompletionBlock)completionBlock;

@end
