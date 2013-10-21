//
// Created by Tomasz Wyszomirski on 21/10/13.
// Copyright (c) 2013 Synappse. All rights reserved.

#import "NSArray+EmployeesCollection.h"


@implementation NSArray (EmployeesCollection)

- (TABEmployee *) employeeForIndex:(NSUInteger)index {

    TABEmployee *employee = nil;

    if ([self count] > index) {

        id dataSourceObject = self[index];

        if ([dataSourceObject isKindOfClass:[TABEmployee class]] == NO) {
            DLog(@"Unexpected DataSource object found");
        }
        else {
            employee = (TABEmployee *)dataSourceObject;
        }
    }
    return employee;
}

@end
