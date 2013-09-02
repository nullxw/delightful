//
//  PhotosHorizontalScrollingViewController.h
//  PhotoBox
//
//  Created by Nico Prananta on 9/1/13.
//  Copyright (c) 2013 Touches. All rights reserved.
//

#import "PhotosViewController.h"

@class Photo;
@class PhotosHorizontalScrollingViewController;

@protocol PhotosHorizontalScrollingViewControllerDelegate <NSObject>

- (void)photosHorizontalScrollingViewController:(PhotosHorizontalScrollingViewController *)viewController didChangePage:(NSInteger)page item:(Photo *)item;

@end

@interface PhotosHorizontalScrollingViewController : PhotoBoxViewController

@property (nonatomic, strong) Photo *firstShownPhoto;
@property (nonatomic, weak) id<PhotosHorizontalScrollingViewControllerDelegate>delegate;

@end
