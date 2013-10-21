//
//  TABViewController.m
//  TABTest
//
//  Created by Wyszo on 10/19/13.
//  Copyright (c) 2013 Synappse. All rights reserved.
//

#import "TABViewController.h"
#import "TABEmployeesNetworkDataSource.h"
#import "NSError+CommonErrors.h"
#import "NSArray+EmployeesCollection.h"
#import "Configuration.h"
#import "TABEmployeeCell.h"


static NSString *kEmployeeCellId = @"EmployeeCell";
static NSString *kEmployeeCellNibName = @"TABEmployeeCell";
static NSUInteger kEmployeeCellHeight = 200;


@interface TABViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) id<TABEmployeesDataSource> employeesDataSource;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end


@implementation TABViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self registerCellsNib];
    self.employeesDataSource = [TABEmployeesNetworkDataSource new];
    [self fetchEmployees];
}

- (void) registerCellsNib {
    
    UINib *nib = [UINib nibWithNibName:kEmployeeCellNibName bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:kEmployeeCellId];
}

- (void) fetchEmployees {

    __weak TABViewController *weakSelf = self;

    [self.employeesDataSource asyncFetchEmployeesCompletion:^(NSArray *employees, NSError *error) {

        if (error == nil || employees.count > 0) {
            
            [weakSelf.tableView reloadData];
            [weakSelf checkIfEmployeesNonempty];
        }
        else {
            if ([error isNoInternetConnectionError]) {

                DLog(@"No internet connection, can't fetch employees!");
                // TODO: show a localized alert
            }
            else {
                DLog(@"Can't fetch employees!");
                // TODO: show generic error localized alert
            }
        }
    }];
}

- (void) checkIfEmployeesNonempty {

    if (_employeesDataSource.employees.count == 0) {

        DLog(@"Empty employees collection fetched!");
        // TODO: show localized alert view
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _employeesDataSource.employees.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TABEmployeeCell *cell = [tableView dequeueReusableCellWithIdentifier:kEmployeeCellId];
    cell.avatar.image = nil;
    
    TABEmployee *employee = [_employeesDataSource.employees employeeForIndex:indexPath.row];
    [cell configureWithEmployee:employee];

    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kEmployeeCellHeight;
}

- (void) tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    TABEmployeeCell *employeeCell = (TABEmployeeCell *)cell;
    [employeeCell didEndDisplaying];
}

@end
