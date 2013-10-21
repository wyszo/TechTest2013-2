//
// Created by Tomasz Wyszomirski on 21/10/13.
// Copyright (c) 2013 Synappse. All rights reserved.

#import "TABEmployee.h"


@interface TABEmployee ()

@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;

@end


@implementation TABEmployee

- (id) initWithImageURL:(NSString *)imageURL name:(NSString *)name title:(NSString *)title description:(NSString *)description {

    self = [super init];
    if (self) {
        _imageURL = imageURL;
        _name = name;
        _title = title;
        _description = description;
    }
    return self;
}

@end
