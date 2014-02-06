//
//  CollectionViewDataSource.h
//  Expiry
//
//  Created by Nico Prananta on 7/30/13.
//  Copyright (c) 2013 Touches. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoBoxFetchedResultsController.h"

typedef void (^CollectionViewCellConfigureBlock)(id cell, id item);
typedef void (^CollectionViewHeaderCellConfigureBlock)(id cell, id item, NSIndexPath *indexPath);

@interface CollectionViewDataSource : NSObject <UICollectionViewDataSource, NSFetchedResultsControllerDelegate>

@property (nonatomic, copy) NSString *cellIdentifier;

@property (nonatomic, copy) CollectionViewCellConfigureBlock configureCellBlock;

@property (nonatomic, strong) NSString *sectionHeaderIdentifier;

@property (nonatomic, copy) CollectionViewHeaderCellConfigureBlock configureCellHeaderBlock;

@property (nonatomic, assign) BOOL paused;

//for debugging purposes
@property (nonatomic, strong) NSString *debugName;

@property (nonatomic, strong) PhotoBoxFetchedResultsController *fetchedResultsController;

@property (nonatomic, strong) NSIndexPath *loadingViewIndexPath;

@property (nonatomic, copy) NSMutableArray *objectChanges;
@property (nonatomic, copy) NSMutableArray *sectionChanges;
@property (nonatomic, strong, readonly) id collectionView;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

- (NSManagedObject *)managedObjectItemAtIndexPath:(NSIndexPath *)indexPath;

- (NSIndexPath *)indexPathOfItem:(id)item;

- (NSInteger)positionOfItem:(id)item;

- (NSInteger)numberOfItems;

- (id)initWithCollectionView:(id)collectionView;

@end
