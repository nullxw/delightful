//
//  UploadAssetCell.m
//  Delightful
//
//  Created by Nico Prananta on 6/22/14.
//  Copyright (c) 2014 Touches. All rights reserved.
//

#import "UploadAssetCell.h"

#import <AssetsLibrary/AssetsLibrary.h>

#import <DAProgressOverlayView.h>

#import "DLFAsset.h"

@interface UploadAssetCell ()

@property (nonatomic, strong) DAProgressOverlayView *uploadingView;

@property (nonatomic, assign) float uploadProg;

@end

@implementation UploadAssetCell

@synthesize item = _item;

- (void)setup {
    [super setup];
    
    [self setUploadProgress:0];
}

- (void)setItem:(id)item {
    if (_item != item) {
        _item = item;
        
        DLFAsset *asset = (DLFAsset *)_item;
        //[self.cellImageView setImage:[UIImage imageWithCGImage:[asset.asset thumbnail]]];
        [self setUploadProgress:0];
    }
}

- (void)prepareForReuse {
    if (self.uploadProg == 1) {
        [self.uploadingView removeFromSuperview];
        self.uploadingView = nil;
    }
}


- (void)setUploadProgress:(float)progress {
    if (!self.uploadingView) {
        self.uploadingView = [[DAProgressOverlayView alloc] initWithFrame:self.contentView.bounds];
        [self.uploadingView setOverlayColor:[UIColor colorWithWhite:0.000 alpha:0.760]];
        [self.contentView addSubview:self.uploadingView];
    }
    
    [self.contentView bringSubviewToFront:self.uploadingView];
    
    _uploadProg = progress;
    
    [self.uploadingView setProgress:progress];
}

- (void)removeUploadProgress {
    [self.uploadingView removeFromSuperview];
    self.uploadingView = nil;
}

@end
