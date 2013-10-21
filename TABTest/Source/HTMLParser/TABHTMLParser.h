//
//  TABHTMLParser.h
//  TABTest
//
//  Created by Wyszo on 10/14/13.
//  Copyright (c) 2013 Wyszo. All rights reserved.
//

#import "TABHTMLParseOperation.h"


@interface TABHTMLParser : NSObject

- (void) parseXHTMLData:(NSData *)htmlData completion:(htmlParsingCompletionBlock)completionBlock;

@end
