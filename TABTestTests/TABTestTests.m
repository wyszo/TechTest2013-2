//
//  TABTestTests.m
//  TABTestTests
//
//  Created by Wyszo on 10/19/13.
//  Copyright (c) 2013 Synappse. All rights reserved.
//

#import "TABTestTests.h"
#import "TABHTMLParser.h"
#import "TABEmployeesOfflineDataSource.h"

static const NSUInteger kExpectedNumberOfEmployees = 31;
static const NSUInteger kLastEmployeeIndex = kExpectedNumberOfEmployees - 1;


@interface TABTestTests ()

@property (nonatomic, strong) TABHTMLParser *parser;
@property (nonatomic, strong) NSArray *employees;

@end


@implementation TABTestTests

- (void)setUp
{
    [super setUp];
    
    /**
     * That's not really a unit test, just a quick dirty way to check that xHTML parser is not broken
     * Normally tests should operate on MUCH smaller chunks of data than sample html page loaded here
     *
     * Ideally TABHTMLParser should have proper unit tests instead of this
     */
    
    [self fillEmployeesWithSampleFileData];
}

- (void)fillEmployeesWithSampleFileData {
    
    id<TABEmployeesDataSource> employeesDataSource = [TABEmployeesOfflineDataSource new];
    __weak TABTestTests *weakSelf = self;
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [employeesDataSource asyncFetchEmployeesCompletion:^(NSArray *employees, NSError *error) {
        
        weakSelf.employees = employees;
        dispatch_semaphore_signal(semaphore);
    }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}

- (void)tearDown
{
    // Tear-down code here.
    [super tearDown];
}

- (void)testEmployeesNonempty {
    
    STAssertNotNil(self.employees, @"Parser failed, no results in employees array");
}

- (void)testNumberOfEmployees {
    
    STAssertEquals(kExpectedNumberOfEmployees, self.employees.count, @"Number of fetched employees is incorrect");
}

- (void) testLastEmployeeNameNonempty {
    
    TABEmployee *lastEmployee = self.employees[kLastEmployeeIndex];
    STAssertTrue(lastEmployee.name.length > 0, @"last employee name empty");
}

/**
 * Test suite far from complete; just a dirty check if parsing looks fine
 */

@end
