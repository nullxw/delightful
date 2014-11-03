//
//  PhotosViewController.h
//  PhotoBox
//
//  Created by Nico Prananta on 8/31/13.
//  Copyright (c) 2013 Touches. All rights reserved.
//

#import "PhotoBoxViewController.h"

#import "ShowFullScreenPhotosAnimatedTransitioning.h"

typedef NS_ENUM(NSInteger, PhotosViewControllerState) {
    PhotosViewControllerStateNormal,
    PhotosViewControllerStateUploading
};

@class PhotosCollection;

@interface PhotosViewController : PhotoBoxViewController <CustomAnimationTransitionFromViewControllerDelegate>

@property (nonatomic, assign) PhotosViewControllerState photosViewControllerState;

@property (nonatomic, strong) PhotosCollection *item;

- (void)setupRightBarButtonsWithSettings:(BOOL)showSetting;

@end
