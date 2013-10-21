//
//  TABEmployeeCell.m
//  TABTest
//
//  Created by Wyszo on 21/10/13.
//  Copyright (c) 2013 Synappse. All rights reserved.
//

#import "TABEmployeeCell.h"
#import "Configuration.h"

@implementation TABEmployeeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void) configureWithEmployee:(TABEmployee *)employee {
    
    self.imageView.image = nil;
    
    if (employee) {
        self.name.text = employee.name;
        self.title.text = employee.title;
        self.description.text = employee.description;
    }
    
    [self makeAvatarImageViewRound];
    [self setupImageWithURLString:employee.imageURL];
}

- (void) makeAvatarImageViewRound {
    
    self.avatar.layer.cornerRadius = self.avatar.frame.size.width / 2;
    self.avatar.layer.masksToBounds = YES;
}

- (void) setupImageWithURLString:(NSString *)urlString {
    
    NSString *imageURLString = [NSString stringWithFormat:@"%@/%@", kTheAppBusinessPeoplePageURL, urlString];
    NSURL *imageURL = [NSURL URLWithString:imageURLString];
    
    // ideally we should cancel request if cell stopped being visible and request didn't finish
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIImage *image = [UIImage imageWithData:imageData];
            self.avatar.image = image;
            [self setNeedsLayout];
        });
    });
}

@end
