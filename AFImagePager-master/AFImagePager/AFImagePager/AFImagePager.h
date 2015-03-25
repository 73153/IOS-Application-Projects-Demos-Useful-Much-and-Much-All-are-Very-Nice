//
//  AFImagePager.h
//  AFImagePager
//
//  Created by Marcus Kida on 07.04.13. Supoprt for AFNetworking added by Gaurav Verma
//  Copyright (c) 2013 Marcus Kida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "UIImageView+AFNetworking.h"

@class AFImagePager;

@protocol AFImagePagerDataSource<NSObject>

@required
- (NSArray *) arrayWithImageUrlStrings;
- (UIViewContentMode) contentModeForImage:(NSUInteger)image;

@optional
- (UIImage *) placeHolderImageForImagePager;

@end

@protocol AFImagePagerDelegate<NSObject>

@optional
- (void) imagePager:(AFImagePager *)imagePager didScrollToIndex:(NSUInteger)index;
- (void) imagePager:(AFImagePager *)imagePager didSelectImageAtIndex:(NSUInteger)index;

@end

@interface AFImagePager : UIView

@property (weak) IBOutlet id <AFImagePagerDataSource> dataSource;
@property (weak) IBOutlet id <AFImagePagerDelegate> delegate;

@property UIViewContentMode contentMode;
@property (nonatomic, retain) UIPageControl *pageControl;
@property (nonatomic) BOOL indicatorDisabled;

- (void) reloadData;

@end

