//
//  TABViewController.m
//  TABTest
//
//  Created by Wyszo on 10/19/13.
//  Copyright (c) 2013 Synappse. All rights reserved.
//

#import "TABViewController.h"
#import "TABHTMLParser.h"
#import "NSString+XHTML.h"


static NSString *const kHTMLTestFileName = @"People";


@interface TABViewController ()

@property (nonatomic, strong) TABHTMLParser *parser;

@end


@implementation TABViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self parseOfflineData]; // TODO: wire up network connection in here!
}

- (void) parseOfflineData {

    // TODO: encapsulate all this, move it out from here

    NSData *htmlData = [self htmlDataFromSampleFile];

    NSString *htmlString = [[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding];
    htmlString = [self htmlEmployeeDescriptionsFromHtmlString:htmlString];

    NSData *xhtmlData = [htmlString xhtmlData];

    _parser = [[TABHTMLParser alloc] init];

    [_parser parseXHTMLData:xhtmlData completion:^(NSArray *employees, NSError *error) {
        DLog(@"Number of employees: %d", employees.count);
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
