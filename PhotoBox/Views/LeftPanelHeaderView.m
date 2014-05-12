//
//  LeftPanelHeaderView.m
//  Delightful
//
//  Created by Nico Prananta on 5/11/14.
//  Copyright (c) 2014 Touches. All rights reserved.
//

#import "LeftPanelHeaderView.h"

#import <UIView+Autolayout.h>

@interface LeftPanelHeaderView ()

@property (nonatomic, strong) CAShapeLayer *separatorLine;

@end

@implementation LeftPanelHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [self setup];
}

- (void)setup {
    [self setBackgroundColor:[UIColor tabBarTintColor]];
    
    [self.galleryArrow setImage:[[UIImage imageNamed:@"right.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    [self.downloadedArrow setImage:[[UIImage imageNamed:@"right.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(UIViewNoIntrinsicMetric, CGRectGetMaxY(self.downloadedButton.frame) + 10);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!self.separatorLine) {
        self.separatorLine = [CAShapeLayer layer];
        [self.separatorLine setLineWidth:0.5];
        [self.separatorLine setStrokeColor:[UIColor albumsBackgroundColor].CGColor];
        
        [self.layer addSublayer:self.separatorLine];
    }
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat yPoint = CGRectGetMaxY(self.galleryButton.frame) + 5;
    [path moveToPoint:CGPointMake(CGRectGetMinX(self.galleryButton.frame), yPoint)];
    [path addLineToPoint:CGPointMake(CGRectGetMaxX(self.galleryButton.frame), yPoint)];
    [self.separatorLine setPath:path.CGPath];
}

@end