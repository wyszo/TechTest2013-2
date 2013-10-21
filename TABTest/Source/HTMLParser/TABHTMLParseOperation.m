//
//  TABHTMLParseOperation.m
//  TABTest
//
//  Created by Wyszo on 10/15/13.
//  Copyright (c) 2013 Wyszo. All rights reserved.
//

#import "TABHTMLParseOperation.h"
#import "TABMutableEmployee.h"
#import "NSString+Common.h"
#import "NSError+CommonErrors.h"
#import "TABEmployee.h"


static NSString *const kDivTagName = @"div";
static NSString *const kClassAttributeName = @"class";
static NSString *const kIdAttributeName = @"id";

static NSString *const kProfileClassAttributeType = @"profile";


@interface TABHTMLParseOperation () <NSXMLParserDelegate>

@property (nonatomic, strong) NSXMLParser *htmlParser;
@property (nonatomic, assign) BOOL insideEmployeeElement;
@property (nonatomic, strong) TABMutableEmployee *currentEmployee;

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

    DLog(@"html element found, adding new employee item: %@", elementName);

    _currentEmployee = [TABMutableEmployee new];
    
    if ([elementName isEqualToString:kDivTagName]) {

        if ([attributeDict[kClassAttributeName] containsSubstring:kProfileClassAttributeType] == YES) {

            _insideEmployeeElement = YES;

            NSString *employeeId = attributeDict[kIdAttributeName];
            DLog(@"Employee div found for %@", employeeId);
        }
    }
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {

    if ([elementName isEqualToString:kDivTagName] == YES) {

        DLog(@"%@ closing tag found, adding new Employee", elementName);
        _insideEmployeeElement = NO;

        if (_currentEmployee != nil) {

            TABEmployee *newEmployee = [[TABEmployee alloc] initWithImageURL:_currentEmployee.imageURL
                                                                        name:_currentEmployee.name
                                                                       title:_currentEmployee.title
                                                                 description:_currentEmployee.description]; // dropping mutability

            if (newEmployee) {
                [_employees addObject:newEmployee];
            }

            _currentEmployee = nil;
        }
    }
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {

}

- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
        
    NSArray *rssItems = [self immutableEmployees];
    NSError *error = [NSError errorWithDomain:kXMLParsingErrorDomain code:XMLParsingInvalidXMLErrorCode userInfo:nil];
    
    _customCompletionBlock(rssItems, error);
}

@end
