//
// Created by Tomasz Wyszomirski on 21/10/13.
// Copyright (c) 2013 Synappse. All rights reserved.

#import "TABEmployee.h"

typedef void (^fetchEmployeesCompletionBlock)(NSArray *employees, NSError *error);


@protocol TABEmployeesDataSource <NSObject>

@property (nonatomic, strong, readonly) NSArray *employees;

- (void) asyncFetchEmployeesCompletion:(fetchEmployeesCompletionBlock)completionBlock;

@end
