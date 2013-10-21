//
// Created by Tomasz Wyszomirski on 21/10/13.
// Copyright (c) 2013 Synappse. All rights reserved.

#import "TABEmployeesDataSource.h"


@interface TABEmployeesNetworkDataSource : NSObject <TABEmployeesDataSource>

@property (nonatomic, strong, readonly) NSArray *employees;

- (void) asyncFetchEmployeesCompletion:(fetchEmployeesCompletionBlock)completionBlock;

@end
