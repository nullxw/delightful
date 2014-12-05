//
//  MainTabBarController.m
//  Delightful
//
//  Created by  on 10/14/14.
//  Copyright (c) 2014 Touches. All rights reserved.
//

#import "MainTabBarController.h"
#import "SyncEngine.h"
#import "PhotoBoxViewController.h"
#import "NPRImageDownloader.h"
#import "DLFImageUploader.h"
#import "UIWindow+Additionals.h"
#import "IntroViewController.h"
#import "ConnectionManager.h"

static void * imageDownloadContext = &imageDownloadContext;

@interface MainTabBarController ()

@property (nonatomic, assign) int numberOfDownloads;

@property (nonatomic, assign) int numberOfUploads;

@property (nonatomic, assign) BOOL isDownloadingPhotos;

@property (nonatomic, assign) BOOL isUploadingPhotos;

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NPRImageDownloader sharedDownloader] addObserver:self forKeyPath:NSStringFromSelector(@selector(numberOfDownloads)) options:0 context:imageDownloadContext];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadNumberChangeNotification:) name:DLFAssetUploadDidChangeNumberOfUploadsNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self showUpdateInfoViewIfNeeded];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showBadgeOnMoreBarItem {
    UIViewController *moreVC = [self.viewControllers lastObject];
    int totalOperation = self.numberOfDownloads + self.numberOfUploads;
    if (totalOperation > 0) {
        [moreVC.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d", totalOperation]];
    } else {
        [moreVC.tabBarItem setBadgeValue:nil];
        
        if (self.isDownloadingPhotos) {
            [[NPRNotificationManager sharedManager] postNotificationWithImage:nil position:NPRNotificationPositionBottom type:NPRNotificationTypeSuccess string:NSLocalizedString(@"Image(s) are saved to Photo gallery", nil) accessoryType:NPRNotificationAccessoryTypeNone accessoryView:nil duration:1 onTap:nil];
            self.isDownloadingPhotos = NO;
        } else if (self.isUploadingPhotos) {
            [[NPRNotificationManager sharedManager] postNotificationWithImage:nil position:NPRNotificationPositionBottom type:NPRNotificationTypeSuccess string:NSLocalizedString(@"Image(s) are uploaded", nil) accessoryType:NPRNotificationAccessoryTypeNone accessoryView:nil duration:1 onTap:nil];
            self.isUploadingPhotos = NO;
        }
    }
    
}

#pragma mark - Intro

- (BOOL)showUpdateInfoViewIfNeeded {
    if ([[ConnectionManager sharedManager] isUserLoggedIn]) {
        NSString *previousVersion = [[NSUserDefaults standardUserDefaults] objectForKey:APP_VERSION_KEY];
        NSString *currentVersion = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
        NSString *showIntroVersion = [[NSUserDefaults standardUserDefaults] objectForKey:PBX_SHOWN_INTRO_VIEW_USER_DEFAULT_KEY];
        if (previousVersion) {
            if (![currentVersion isEqualToString:showIntroVersion]) {
                if ([self versionInfOPlistExistsForVersion:currentVersion]) {
                    [self performSegueWithIdentifier:@"showIntro" sender:nil];
                    [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:PBX_SHOWN_INTRO_VIEW_USER_DEFAULT_KEY];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    return YES;
                }
            }
        }
    }
    return NO;
}

- (BOOL)versionInfOPlistExistsForVersion:(NSString *)version {
    NSString * filePath = [[NSBundle bundleForClass:[self class]] pathForResource:version ofType:@"plist"];
    return (filePath)?YES:NO;
}

#pragma mark - Orientation

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    NSLog(@"Tabbar view will transition to size %@", NSStringFromCGSize(size));
    
    for (UINavigationController *navCon in self.viewControllers) {
        for (UIViewController *controller in navCon.viewControllers) {
            if ([controller respondsToSelector:@selector(dlf_viewWillTransitionToSize:withTransitionCoordinator:)]) {
                [((id)controller) dlf_viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
            }
        }
    }
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

#pragma mark - Observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(numberOfDownloads))] && context == imageDownloadContext) {
        self.numberOfDownloads = (int)[[NPRImageDownloader sharedDownloader] numberOfDownloads];
        self.isDownloadingPhotos = YES;
        [self showBadgeOnMoreBarItem];
    }
}

#pragma mark - Notification

- (void)uploadNumberChangeNotification:(NSNotification *)notification {
    self.numberOfUploads = [notification.userInfo[kNumberOfUploadsKey] intValue];
    self.isUploadingPhotos = YES;
    [self showBadgeOnMoreBarItem];
}

@end
