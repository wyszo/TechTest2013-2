//
// Created by Tomasz Wyszomirski on 21/10/13.
// Copyright (c) 2013 Synappse. All rights reserved.

#import "TABFetchImageDataOperation.h"

@interface TABFetchImageDataOperation ()

@property (nonatomic, copy) NSString *imageUrlString;

@end


@implementation TABFetchImageDataOperation

- (id) initWithImageUrlString:(NSString *)urlString {

    self = [super init];
    if (self) {
        _imageUrlString = urlString;
    }
    return self;
}

- (void) main {

    if (_imageUrlString.length == 0) {
        return;
    }

    NSURL *imageURL = [NSURL URLWithString:_imageUrlString];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];

    if (self.isCancelled == NO && imageData) {

        __weak TABFetchImageDataOperation *weakSelf = self;

        dispatch_async(dispatch_get_main_queue(), ^{

            UIImage *image = [UIImage imageWithData:imageData];

            if (weakSelf.isCancelled == NO) {
                [_delegate fetchOperationDidFinishWithImage:image];
            }
        });
    }
}

@end
