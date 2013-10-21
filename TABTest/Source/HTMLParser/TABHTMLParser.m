//
//  TABHTMLParser.m
//  TABTest
//
//  Created by Wyszo on 10/14/13.
//  Copyright (c) 2013 Wyszo. All rights reserved.
//

#import "TABHTMLParser.h"
#import "TABHTMLParseOperation.h"
#import "NSError+CommonErrors.h"


@interface TABHTMLParser ()

@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) NSOperation *parseOperation;

@end


@implementation TABHTMLParser

- (void) parseXHTMLData:(NSData *)htmlData completion:(htmlParsingCompletionBlock)completionBlock {

    if (htmlData.length == 0) {
        
        DLog(@"invalid htmlData object, returning");
        
        NSError *error = [NSError errorWithDomain:kXMLParsingErrorDomain code:XMLParsingInvalidXMLErrorCode userInfo:nil];
        completionBlock(nil, error);
    }
    else {
        
        _parseOperation = [[TABHTMLParseOperation alloc] initWithXMLData:htmlData completion:completionBlock];
        [self.operationQueue addOperation:_parseOperation];
    }
}

- (NSOperationQueue *) operationQueue {

    if (_operationQueue == nil) {
        _operationQueue = [[NSOperationQueue alloc] init];
    }
    return _operationQueue;
}

@end
