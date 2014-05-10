//
//  CollectionViewDataSource.h
//  Expiry
//
//  Created by Nico Prananta on 7/30/13.
//  Copyright (c) 2013 Touches. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CollectionViewCellConfigureBlock)(id cell, id item);
typedef void (^CollectionViewHeaderCellConfigureBlock)(id cell, id item, NSIndexPath *indexPath);

@interface CollectionViewDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic, copy) NSString *cellIdentifier;

@property (nonatomic, copy) CollectionViewCellConfigureBlock configureCellBlock;

@property (nonatomic, strong) NSString *sectionHeaderIdentifier;

@property (nonatomic, copy) CollectionViewHeaderCellConfigureBlock configureCellHeaderBlock;

//for debugging purposes
@property (nonatomic, strong) NSString *debugName;

@property (nonatomic, strong) NSIndexPath *loadingViewIndexPath;

@property (nonatomic, strong, readonly) id collectionView;

@property (nonatomic, strong) NSPredicate *predicate;

@property (nonatomic, strong) NSString *groupKey;

@property (nonatomic, strong) NSArray *sortDescriptors;

- (NSArray *)items;

- (void)removeAllItems;

- (void)addItems:(NSArray *)items;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

- (NSIndexPath *)indexPathOfItem:(id)item;

- (NSInteger)positionOfItem:(id)item;

- (NSInteger)numberOfItems;

- (id)initWithCollectionView:(id)collectionView;

@end
