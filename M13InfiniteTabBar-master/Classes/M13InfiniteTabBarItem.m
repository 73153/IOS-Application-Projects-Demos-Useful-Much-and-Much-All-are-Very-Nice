//
//  M13InfiniteTabBarItem.m
//  M13InfiniteTabBar
/*
 Copyright (c) 2013 Brandon McQuilkin
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 One does not claim this software as ones own.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "M13InfiniteTabBarItem.h"
#import <QuartzCore/QuartzCore.h>

@implementation M13InfiniteTabBarItem
{
    UIImageView *_iconView;
    UIImage *_icon;
    UIImage *_selectedIcon;
    UIImage *_unselectedIcon;
    UIView *_containerView;
    UILabel *_titleLabel;
    BOOL _selected;
    BOOL _requiresAttention;
    UIImageView *_backgroundImageView;
}

- (id)initWithTitle:(NSString *)title selectedIconMask:(UIImage *)selectedIconMask unselectedIconMask:(UIImage *)unselectedIconMask
{
    CGRect frame = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) ? CGRectMake(0, 10, 64, 50) : CGRectMake(0, 10, 768.0/11.0, 50);
    self = [super initWithFrame:frame];
    if (self) {
        //Container view to handle rotations
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _containerView.backgroundColor = [UIColor clearColor];
        
        //Set default properties
        _selectedIcon = selectedIconMask;
        _unselectedIcon = unselectedIconMask;
        _icon = _unselectedIcon;
        self.backgroundColor = [UIColor clearColor];
        _unselectedTitleColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1];
        _selectedTitleColor = [UIColor colorWithRed:0.02 green:0.47 blue:1 alpha:1];
        _attentionTitleColor = [UIColor colorWithRed:0.98 green:0.24 blue:0.15 alpha:1];
        _unselectedIconTintColor = [UIColor colorWithRed:0.56 green:0.56 blue:0.56 alpha:1];
        _selectedIconTintColor = [UIColor colorWithRed:0.02 green:0.47 blue:1 alpha:1];
        _attentionIconTintColor = [UIColor colorWithRed:0.98 green:0.24 blue:0.15 alpha:1];
        
        //Create icon's view
        _iconView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 7, self.frame.size.width - 14, 29)];
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
        [self setSelected:NO];
        [_containerView addSubview:_iconView];
        
        //Create Text Label
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 37, self.frame.size.width - 4.0, 10)];
        _titleLabel.text = title;
        _titleLabel.textColor = _unselectedTitleColor;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleFont = [UIFont boldSystemFontOfSize:7.0];
        _titleLabel.font = _titleFont;
        [_containerView addSubview:_titleLabel];
        
        [self addSubview:_containerView];
        
    }
    return self;
}

- (void)rotateToAngle:(CGFloat)angle
{
    _containerView.transform = CGAffineTransformMakeRotation(angle);
}

- (id)copy
{
    M13InfiniteTabBarItem *item = [[M13InfiniteTabBarItem alloc] initWithTitle:_titleLabel.text selectedIconMask:_selectedIcon unselectedIconMask:_unselectedIcon];
    if (item) {
        [item setSelected:_selected];
        [item setRequiresUserAttention:_requiresAttention];
        UIView *itemContainerView = [item.subviews objectAtIndex:0];
        itemContainerView.transform = _containerView.transform;
    }
    return item;
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    
    [_iconView setImage:[self createColoredIconForCurrnetState]];
}

- (void)setRequiresUserAttention:(BOOL)requiresAttention
{
    _requiresAttention = requiresAttention;
    
    [_iconView setImage:[self createColoredIconForCurrnetState]];
}

- (UIImage *)createColoredIconForCurrnetState
{
    //Set colors
    if (_selected) {
        _titleLabel.textColor = _selectedTitleColor;
        _icon = _selectedIcon;
    } else {
        _titleLabel.textColor = _unselectedTitleColor;
        _icon = _unselectedIcon;
    }
    
    if (_requiresAttention) {
        _titleLabel.textColor = _attentionTitleColor;
    }

    //Generate image background that will be cropped
    UIGraphicsBeginImageContextWithOptions(_icon.size, NO, [[UIScreen mainScreen] scale]);
    if (_selected && !_requiresAttention) {
        if (_selectedIconOverlayImage) {
            //Draw the background image centered.
            [_selectedIconOverlayImage drawInRect:CGRectMake((_icon.size.width - CGImageGetWidth(_selectedIconOverlayImage.CGImage)) / 2, (_icon.size.height - CGImageGetHeight(_selectedIconOverlayImage.CGImage)) / 2, CGImageGetWidth(_selectedIconOverlayImage.CGImage), CGImageGetHeight(_selectedIconOverlayImage.CGImage))];
        } else {
            [_selectedIconTintColor set];
            UIRectFill(CGRectMake(0, 0, _icon.size.width, _icon.size.height));
        }
    } else if (!_selected && !_requiresAttention){
        if (_unselectedIconOverlayImage) {
            //Draw the background image centered.
            [_unselectedIconOverlayImage drawInRect:CGRectMake((_icon.size.width - CGImageGetWidth(_unselectedIconOverlayImage.CGImage)) / 2, (_icon.size.height - CGImageGetHeight(_unselectedIconOverlayImage.CGImage)) / 2, CGImageGetWidth(_unselectedIconOverlayImage.CGImage), CGImageGetHeight(_unselectedIconOverlayImage.CGImage))];
        } else {
            [_unselectedIconTintColor set];
            UIRectFill(CGRectMake(0, 0, _icon.size.width, _icon.size.height));
        }
    } else {
        if (_attentionIconOverlayImage) {
            //Draw the background image centered.
            [_attentionIconOverlayImage drawInRect:CGRectMake((_icon.size.width - CGImageGetWidth(_attentionIconOverlayImage.CGImage)) / 2, (_icon.size.height - CGImageGetHeight(_attentionIconOverlayImage.CGImage)) / 2, CGImageGetWidth(_attentionIconOverlayImage.CGImage), CGImageGetHeight(_attentionIconOverlayImage.CGImage))];
        } else {
            [_attentionIconTintColor set];
            UIRectFill(CGRectMake(0, 0, _icon.size.width, _icon.size.height));
        }
    }
    //Save image
    UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRef maskRef = _icon.CGImage;
    
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef), CGImageGetHeight(maskRef), CGImageGetBitsPerComponent(maskRef), CGImageGetBitsPerPixel(maskRef), CGImageGetBytesPerRow(maskRef), CGImageGetDataProvider(maskRef), NULL, FALSE);
    CGImageRef masked = CGImageCreateWithMask(backgroundImage.CGImage, mask);
    
    UIImage *image = [UIImage imageWithCGImage:masked];;
    CGImageRelease(mask);
    CGImageRelease(masked);
    //CGImageRelease(maskRef);
    
    return image;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    if (backgroundImage != nil) {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self insertSubview:_backgroundImageView belowSubview:_containerView];
        _backgroundImage = backgroundImage;
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_backgroundImageView setImage:_backgroundImage];
    } else {
        _backgroundImage = nil;
        [_backgroundImageView removeFromSuperview];
        _backgroundImageView = nil;
    }
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    _titleLabel.font = _titleFont;
}


@end
