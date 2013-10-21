//
// Created by Tomasz Wyszomirski on 21/10/13.
// Copyright (c) 2013 Synappse. All rights reserved.

#import "TABEmployeesDataSource.h"
#import "TABHTMLParser.h"
#import "NSString+XHTML.h"


static NSString *const kHTMLTestFileName = @"People";


@interface TABEmployeesDataSource ()

@property (nonatomic, strong) NSArray *employees;
@property (nonatomic, strong) TABHTMLParser *parser;

@end


@implementation TABEmployeesDataSource


- (void) asyncFetchEmployeesCompletion:(fetchEmployeesCompletionBlock)completionBlock {

    // TODO: wire up network connection in here!
    [self tempFillEmployeesWithSampleOfflineFileCompletion:completionBlock];
}


#pragma mark - Accessors

- (TABHTMLParser *) parser {
    if (_parser == nil) {
        _parser = [[TABHTMLParser alloc] init];
    }
    return _parser;
}


#pragma mark - Fetching data

- (void) tempFillEmployeesWithSampleOfflineFileCompletion:(fetchEmployeesCompletionBlock)completionBlock {

    NSData *htmlData = [self htmlDataFromSampleFile];

    NSString *htmlString = [[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding];
    htmlString = [self htmlEmployeeDescriptionsFromHtmlString:htmlString];

    NSData *xhtmlData = [htmlString xhtmlData];

    __weak TABEmployeesDataSource *weakSelf = self;

    [self.parser parseXHTMLData:xhtmlData completion:^(NSArray *employees, NSError *error) {

        [[NSOperationQueue mainQueue] addOperationWithBlock:^{

            DLog(@"Number of fetched employees: %d", employees.count);

            weakSelf.employees = employees;
            completionBlock(employees, error);
        }];
    }];
}

- (NSData *) htmlDataFromSampleFile {

    NSString *filePath = [[NSBundle mainBundle] pathForResource:kHTMLTestFileName ofType:@"html"];
    NSData *htmlData = [NSData dataWithContentsOfFile:filePath];

    return htmlData;
}


#pragma mark - Preparing html document for parsing

- (NSString *) htmlEmployeeDescriptionsFromHtmlString:(NSString *)htmlString
{
    NSString *firstImportantTag = @"<div class=\"row\">";
    NSString *resultString = @"";

    NSRange range = [htmlString rangeOfString:firstImportantTag];

    if (NSNotFound != range.location) {

        resultString = [htmlString substringFromIndex:range.location];
        resultString = [NSString stringWithFormat:@"<html>%@", resultString];
    }

    return resultString;
}


@end
