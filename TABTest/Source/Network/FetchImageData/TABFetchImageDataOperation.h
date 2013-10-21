//
// Created by Tomasz Wyszomirski on 21/10/13.
// Copyright (c) 2013 Synappse. All rights reserved.


@protocol TABFetchImageDataOperationDelegate
@required
- (void) fetchOperationDidFinishWithImage:(UIImage *)image;

@end

@interface TABFetchImageDataOperation : NSOperation

@property (nonatomic, weak) id<TABFetchImageDataOperationDelegate> delegate;

- (id) initWithImageUrlString:(NSString *)urlString;

@end
