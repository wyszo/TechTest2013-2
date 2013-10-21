//
// Created by Tomasz Wyszomirski on 21/10/13.
// Copyright (c) 2013 Synappse. All rights reserved.


@interface TABEmployee : NSObject

@property (nonatomic, strong, readonly) NSString *imageURL;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSString *description;

- (id) initWithImageURL:(NSString *)imageURL name:(NSString *)name title:(NSString *)title description:(NSString *)description;

@end
