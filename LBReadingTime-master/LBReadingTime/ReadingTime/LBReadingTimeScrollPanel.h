//
//  LBScrollPanel.h
//  MinutesLeft
//
//  Created by Luca Bernardi on 11/03/13.
//  Copyright (c) 2013 Luca Bernardi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextView+ReadingTime.h"

@interface LBReadingTimeScrollPanel : UIView <UITextViewDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) UILabel *titleLabel;
@property (assign, nonatomic) CGFloat cornerRadius UI_APPEARANCE_SELECTOR;
@property (assign, nonatomic) CGFloat titleLabelPadding UI_APPEARANCE_SELECTOR;
@property (strong, nonatomic) UIColor *calloutBackgroundColor UI_APPEARANCE_SELECTOR;

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;

@end
