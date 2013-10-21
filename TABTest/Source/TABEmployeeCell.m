//
//  TABEmployeeCell.m
//  TABTest
//
//  Created by Wyszo on 21/10/13.
//  Copyright (c) 2013 Synappse. All rights reserved.
//

#import "TABEmployeeCell.h"
#import "Configuration.h"
#import "TABFetchImageDataOperation.h"


@interface TABEmployeeCell () <TABFetchImageDataOperationDelegate>

@property (nonatomic, assign) BOOL notDisplayingAnymore;
@property (nonatomic, strong) NSOperationQueue *operationQueue; // ideally we shouldn't create a separate queue for each cell to increase performance

@end


@implementation TABEmployeeCell

- (NSOperationQueue *) operationQueue {
    
    if (_operationQueue == nil) {
        _operationQueue = [[NSOperationQueue alloc] init];
    }
    return _operationQueue;
}

- (void) configureWithEmployee:(TABEmployee *)employee {

    [self.operationQueue cancelAllOperations];
    
    _notDisplayingAnymore = NO;
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

    TABFetchImageDataOperation *operation = [[TABFetchImageDataOperation alloc] initWithImageUrlString:imageURLString];
    operation.delegate = self;
    
    [self.operationQueue addOperation:operation];
}

- (void) didEndDisplaying {
    [self.operationQueue cancelAllOperations];
}

- (void) fetchOperationDidFinishWithImage:(UIImage *)image {
    
    self.avatar.image = image;
    [self setNeedsLayout];
}

@end
