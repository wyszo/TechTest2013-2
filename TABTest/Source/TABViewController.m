//
//  TABViewController.m
//  TABTest
//
//  Created by Wyszo on 10/19/13.
//  Copyright (c) 2013 Synappse. All rights reserved.
//

#import "TABViewController.h"
#import "TABHTMLParser.h"


static NSString *const kHTMLTestFileName = @"People";


@interface TABViewController ()

@end


@implementation TABViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self parseOfflineData]; // TODO: wire up network connection in here!
}

- (void) parseOfflineData {

    NSData *htmlData = [self htmlDataFromSampleFile];
    
    TABHTMLParser *parser = [[TABHTMLParser alloc] init];
    
    [parser parseData:htmlData completion:^(NSArray *items, NSError *error) {
        DLog(@"Number of items: %d", items.count);
    }];
}

- (NSData *) htmlDataFromSampleFile {

    NSString *filePath = [[NSBundle mainBundle] pathForResource:kHTMLTestFileName ofType:@"html"];
    NSData *htmlData = [NSData dataWithContentsOfFile:filePath];
    
    return htmlData;
}

@end
