//
//  TABHTMLParseOperation.m
//  TABTest
//
//  Created by Wyszo on 10/15/13.
//  Copyright (c) 2013 Wyszo. All rights reserved.
//

#import "TABHTMLParseOperation.h"
#import "TABMutableEmployee.h"
#import "NSError+CommonErrors.h"


@interface TABHTMLParseOperation () <NSXMLParserDelegate>

@property (nonatomic, strong) NSXMLParser *htmlParser;
@property (nonatomic, copy) NSString *currentElement;
@property (nonatomic, assign) BOOL insideItemElement;
@property (nonatomic, strong) TABMutableEmployee *employee;

@property (nonatomic, strong) NSMutableArray *employees;
@property (nonatomic, copy) htmlParsingCompletionBlock customCompletionBlock;

@end


@implementation TABHTMLParseOperation

- (id) initWithXMLData:(NSData *)xmlData completion:(htmlParsingCompletionBlock)completion {

    self = [super init];
    if (self) {

        _employees = [NSMutableArray new];

        _htmlParser = [[NSXMLParser alloc] initWithData:xmlData];
        _htmlParser.delegate = self;
        
        _customCompletionBlock = completion;
    }

    return self;
}

- (void) main {

    DLog(@"Parsing html data..");
    BOOL success = [_htmlParser parse];

    if (success) {
        
        DLog(@"Parsing html data: success");
        
        NSArray *result = [self immutableEmployees];
        _customCompletionBlock(result, nil);
    }
}

- (NSArray *) immutableEmployees {
    
    NSArray *result = nil;
    
    if (_employees.count > 0) {
        result = [NSArray arrayWithArray:_employees];
    }
    
    return result;
}


#pragma mark - NSXMLParserDelegate

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {

}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {

}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {

}

- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
        
    NSArray *rssItems = [self immutableEmployees];
    NSError *error = [NSError errorWithDomain:kXMLParsingErrorDomain code:XMLParsingInvalidXMLErrorCode userInfo:nil];
    
    _customCompletionBlock(rssItems, error);
}

@end
