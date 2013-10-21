//
//  TABEmployeeCell.h
//  TABTest
//
//  Created by Wyszo on 21/10/13.
//  Copyright (c) 2013 Synappse. All rights reserved.
//

#import "TABEmployee.h"


@interface TABEmployeeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UITextView *description;

- (void) configureWithEmployee:(TABEmployee *)employee;
- (void) didEndDisplaying;

@end
