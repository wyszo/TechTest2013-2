//
// Created by Tomasz Wyszomirski on 21/10/13.
// Copyright (c) 2013 Synappse. All rights reserved.

#import "TABNetworkManager.h"
#import "NSError+CommonErrors.h"


@implementation TABNetworkManager

- (void) asyncFetchHTMLPageWithURLString:(NSString *)urlString completion:(fetchHtmlPageCompletionBlock)completionBlock {

    if (urlString.length == 0) {

        DLog(@"Empty HTML page URL requested!");

        NSError *error = [NSError errorWithDomain:kHTMLErrorDomain code:HTMLErrorCodeInvalidHTML userInfo:nil];
        completionBlock(nil, error);
    }
    else {

        DLog(@"Downloading HTML Page");

        NSURLRequest *request = [NSURLRequest urlRequestWithURLString:urlString];
        NSOperationQueue *queue = [NSOperationQueue mainQueue];

        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *retrievedData, NSError *error) {

            completionBlock(retrievedData, error);
        }];
    }
}

@end
