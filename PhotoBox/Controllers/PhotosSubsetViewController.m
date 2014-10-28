//
//  PhotosSubsetViewController.m
//  Delightful
//
//  Created by  on 10/22/14.
//  Copyright (c) 2014 Touches. All rights reserved.
//

#import "PhotosSubsetViewController.h"

#import "PhotosSubsetDataSource.h"

#import "SyncEngine.h"

#import "PhotosCollection.h"

#import "SortTableViewController.h"

@interface PhotosSubsetViewController ()

@property (nonatomic, assign) BOOL viewJustDidLoad;

@end

@implementation PhotosSubsetViewController

- (id)initWithFilterBlock:(BOOL (^)(NSString *, NSString *, id))filterBlock name:(NSString *)filterName{
    self = [super init];
    if (self) {
        self.filterName = filterName;
        self.filterBlock = filterBlock;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewJustDidLoad = YES;
    
    self.title = self.item.titleName;
}

- (void)viewDidAppear:(BOOL)animated {
    if (self.viewJustDidLoad) {
        self.viewJustDidLoad = NO;
        [((PhotosSubsetDataSource *)self.dataSource) setFilterBlock:self.filterBlock name:self.filterName];
        [[SyncEngine sharedEngine] startSyncingPhotosInCollection:self.item.itemId collectionType:self.item.class sort:dateUploadedDescSortKey];
    }
    [((YapDataSource *)self.dataSource) setPause:NO];
    [[SyncEngine sharedEngine] pauseSyncingPhotos:NO collection:self.item.itemId];
}

- (void)viewWillDisappear:(BOOL)animated {
    CLS_LOG(@"view will disappear");
    [((YapDataSource *)self.dataSource) setPause:YES];
    [[SyncEngine sharedEngine] pauseSyncingPhotos:YES collection:self.item.itemId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (Class)dataSourceClass {
    return [PhotosSubsetDataSource class];
}


- (void)willStartSyncingNotification:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    NSString *resource = userInfo[SyncEngineNotificationResourceKey];
    NSString *item = userInfo[SyncEngineNotificationIdentifierKey];
    if ([resource isEqualToString:NSStringFromClass([self resourceClass])] && [item isEqualToString:self.item.itemId]) {
        NSLog(@"will start syncing");
        [self setIsFetching:YES];
    }
}

- (void)didFinishSyncingNotification:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    NSString *resource = userInfo[SyncEngineNotificationResourceKey];
    NSString *item = userInfo[SyncEngineNotificationIdentifierKey];
    if ([resource isEqualToString:NSStringFromClass([self resourceClass])] && [item isEqualToString:self.item.itemId]) {
        NSLog(@"did finish syncing");
        NSNumber *count = userInfo[SyncEngineNotificationCountKey];
        if (count.intValue == 0) {
            [self setIsFetching:NO];
        }
    }
}

- (void)didFailSyncingNotification:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    NSString *resource = userInfo[SyncEngineNotificationResourceKey];
    NSString *item = userInfo[SyncEngineNotificationIdentifierKey];
    if ([resource isEqualToString:NSStringFromClass([self resourceClass])] && [item isEqualToString:self.item.itemId]) {
        [self setIsFetching:NO];
    }
}

@end