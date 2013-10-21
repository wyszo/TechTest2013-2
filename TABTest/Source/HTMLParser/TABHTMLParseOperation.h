//
//  TABHTMLParseOperation.h
//  TABTest
//
//  Created by Wyszo on 10/15/13.
//  Copyright (c) 2013 Wyszo. All rights reserved.
//

typedef void (^htmlParsingCompletionBlock)(NSArray *employees, NSError *error);


@interface TABHTMLParseOperation : NSOperation

- (id) initWithXMLData:(NSData *)xmlData completion:(htmlParsingCompletionBlock)completion;

@end
