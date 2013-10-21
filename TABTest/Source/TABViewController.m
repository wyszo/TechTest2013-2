//
//  TABViewController.m
//  TABTest
//
//  Created by Wyszo on 10/19/13.
//  Copyright (c) 2013 Synappse. All rights reserved.
//

#import "TABViewController.h"
#import "TABEmployeesDataSource.h"
#import "NSError+CommonErrors.h"


@interface TABViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) TABEmployeesDataSource *employeesDataSource;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end


@implementation TABViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.employeesDataSource = [TABEmployeesDataSource new];
    [self fetchEmployees];
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

    
    static NSString *cellIdentifier = @"EmployeeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}

#pragma mark - TableViewCell Customization

- (void) configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    
    TABEmployee *employee = _employeesDataSource.employees[indexPath.row]; // TODO: unsafe!
    
    if (employee) {
        cell.textLabel.text = employee.name;
        cell.detailTextLabel.text = employee.title;
    }
    
//    cell.imageView.image = [UIImage imageNamed:];
}

@end
