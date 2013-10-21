//
// Created by Tomasz Wyszomirski on 21/10/13.
// Copyright (c) 2013 Synappse. All rights reserved.

#import "TABEmployeesOfflineDataSource.h"
#import "TABHTMLParser.h"
#import "NSData+XHTMLEmployeeDescriptions.h"


static NSString *const kHTMLTestFileName = @"People";


@interface TABEmployeesOfflineDataSource ()

@property (nonatomic, strong) NSArray *employees;
@property (nonatomic, strong) TABHTMLParser *parser;

@end


@implementation TABEmployeesOfflineDataSource

- (void) asyncFetchEmployeesCompletion:(fetchEmployeesCompletionBlock)completionBlock {

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
    NSData *xhtmlData = [htmlData xhtmlEmployeeDescriptions];

    __weak TABEmployeesOfflineDataSource *weakSelf = self;

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

@end
