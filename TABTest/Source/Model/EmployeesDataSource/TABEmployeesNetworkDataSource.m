//
// Created by Tomasz Wyszomirski on 21/10/13.
// Copyright (c) 2013 Synappse. All rights reserved.

#import "TABEmployeesNetworkDataSource.h"
#import "TABHTMLParser.h"
#import "TABNetworkManager.h"
#import "NSData+XHTMLEmployeeDescriptions.h"
#import "Configuration.h"


@interface TABEmployeesNetworkDataSource ()

@property (nonatomic, strong) NSArray *employees;
@property (nonatomic, strong) TABHTMLParser *parser;

@end


@implementation TABEmployeesNetworkDataSource

- (void) asyncFetchEmployeesCompletion:(fetchEmployeesCompletionBlock)completionBlock {

    [self fillEmployeesWithOnlineHtmlPageCompletion:completionBlock];
}


#pragma mark - Accessors

- (TABHTMLParser *) parser {
    if (_parser == nil) {
        _parser = [[TABHTMLParser alloc] init];
    }
    return _parser;
}


#pragma mark - HTML Fetching


- (void) fillEmployeesWithOnlineHtmlPageCompletion:(fetchEmployeesCompletionBlock)completionBlock {

    TABNetworkManager *networkManager = [[TABNetworkManager alloc] init];
    __weak TABEmployeesNetworkDataSource *weakSelf = self;
    
    [networkManager asyncFetchHTMLPageWithURLString:kTheAppBusinessPeoplePageURL completion:^(NSData *htmlPage, NSError *error) {
        
        BOOL success = (error != nil);
        DLog(@"Network HTML Page fetching success: %d", success);
        
        NSData *xhtmlData = [htmlPage xhtmlEmployeeDescriptions];
        
        [weakSelf.parser parseXHTMLData:xhtmlData completion:^(NSArray *employees, NSError *error) {
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                weakSelf.employees = employees;
                completionBlock(employees, error);
            }];
        }];
    }];
}

@end


