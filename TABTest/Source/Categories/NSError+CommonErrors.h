//
//  NSError+CommonErrors.h
//  ShazamTestProj
//
//  Created by Wyszo on 10/15/13.
//  Copyright (c) 2013 Wyszo. All rights reserved.
//

extern NSString *const kHTMLErrorDomain;

typedef enum {
    HTMLErrorCodeInvalidHTML
} HTMLErrorCode;

extern NSString *const kXMLParsingErrorDomain;

typedef enum {
    XMLParsingInvalidXMLErrorCode
} XMLParsingErrorCode;


@interface NSError (CommonErrors)

- (BOOL) isNoInternetConnectionError;

@end
