//
//  AlbumPickerTableViewCell.h
//  Delightful
//
//  Created by  on 7/23/14.
//  Copyright (c) 2014 Touches. All rights reserved.
//

#import "TagsAlbumPermissionPickerTableViewCell.h"

@interface AlbumPickerTableViewCell : TagsAlbumPermissionPickerTableViewCell

@property (nonatomic, strong, readonly) UILabel *albumLabel;

@property (nonatomic, strong, readonly) UILabel *selectedAlbumLabel;

@end
