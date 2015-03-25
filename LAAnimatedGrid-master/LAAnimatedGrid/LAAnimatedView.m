//
//  LAAnimatedView.m
//  LAAnimatedGridExample
//
//  Created by Luis Ascorbe on 18/12/12.
//  Copyright (c) 2012 Luis Ascorbe. All rights reserved.
//
/*
 
 LAAnimatedGrid is available under the MIT license.
 
 Copyright © 2012 Luis Ascorbe.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 */
#import <QuartzCore/QuartzCore.h>

#import "LAAnimatedView.h"
#import "UIImageView+AFNetworking.h"


#define FADE_DURATION           0.4f
#define ANIMATION_DURATION      5.0f

typedef enum
{
    LAAVAnimationZoomIn = 1,
    LAAVAnimationZoomOut,
    LAAVAnimationMoveLeft,
    LAAVAnimationMoveRight,
    LAAVAnimationNone
}LAAVAnimation;

@interface LAAnimatedView () <UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIImageView *_imgView;
    UIImage *_image;
    
    NSArray *_animations;
    LAAVAnimation animation;
}

@property (nonatomic, retain) UIColor *laagBackGroundColor;

@end

@implementation LAAnimatedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
        _animations = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:LAAVAnimationZoomIn], [NSNumber numberWithInt:LAAVAnimationZoomOut], [NSNumber numberWithInt:LAAVAnimationMoveLeft], [NSNumber numberWithInt:LAAVAnimationMoveRight], [NSNumber numberWithInt:LAAVAnimationNone], nil];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andColor:(UIColor *)aColor
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
        _animations = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:LAAVAnimationZoomIn], [NSNumber numberWithInt:LAAVAnimationZoomOut], [NSNumber numberWithInt:LAAVAnimationMoveLeft], [NSNumber numberWithInt:LAAVAnimationMoveRight], [NSNumber numberWithInt:LAAVAnimationNone], nil];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andImage:(UIImage *)aImage
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
#if !__has_feature(objc_arc)
        _image = [aImage retain];
#else
        _image = aImage;
#endif
        
        _animations = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:LAAVAnimationZoomIn], [NSNumber numberWithInt:LAAVAnimationZoomOut], [NSNumber numberWithInt:LAAVAnimationMoveLeft], [NSNumber numberWithInt:LAAVAnimationMoveRight], [NSNumber numberWithInt:LAAVAnimationNone], nil];
    }
    return self;
}

#if !__has_feature(objc_arc)
- (void)dealloc
{
    [_scrollView release];
    [_imgView release];
    [_image release];
    [_animations release];
    [_laagBackGroundColor release];
    
    [super dealloc];
}
#endif

#pragma mark - Drawing

// Drawing code
- (void)drawRect:(CGRect)rect
{
    // UIImageView setup
    _imgView                        = [[UIImageView alloc] initWithImage:_image];
    _imgView.autoresizingMask       = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
    _imgView.frame                  = (CGRect){.origin=CGPointMake(0.0f, 0.0f), .size=_image.size};
    
    
    // UIScrollView setup
    CGRect frame                                    = CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height);
    _scrollView                                     = [[UIScrollView alloc] initWithFrame:frame];
    _scrollView.pagingEnabled                       = NO;
    _scrollView.showsHorizontalScrollIndicator      = NO;
    _scrollView.showsVerticalScrollIndicator        = NO;
    _scrollView.scrollsToTop                        = NO;
    _scrollView.clipsToBounds                       = YES;
    //_scrollView.delegate                            = self;
    _scrollView.userInteractionEnabled              = NO;
    _scrollView.autoresizingMask                    = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _scrollView.backgroundColor                     = self.laagBackGroundColor;
    _scrollView.contentSize                         = _image.size;
    
    // Adding subviews
    [_scrollView addSubview:_imgView];
    [self addSubview:_scrollView];
    [_scrollView sendSubviewToBack:_imgView];
    
    // adjust image
    //[self adjustImage];
}

- (void)setScrollBackGroundColor:(UIColor *)aColor
{
    self.laagBackGroundColor = aColor;
}

#pragma mark - Functions

- (void)setImage:(UIImage *)aImage
{
#if !__has_feature(objc_arc)
    [_image release];
    _image = [aImage retain];
#else
    _image = aImage;
#endif
    
    // adjust image when its assigned
    [self adjustImage];
}

- (void)setImageURL:(NSURL *)aURL placeholderImage:(UIImage *)aImage
{
    [_imgView setImageWithURL:aURL
             placeholderImage:aImage
                      success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
                      {
#if !__has_feature(objc_arc)
                          [_image release];
                          _image = [image retain];
#else
                          _image = image;
#endif
                          
                          // adjust image when its assigned
                          [self adjustImage];
                      }
                      failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error)
                      {
                          // now do nothing 
                      }
     ];
}

- (void) adjustImage
{
    if ([self superview])
    {
        // set the image in the UIImageView
        [self changeImage];
        _imgView.frame = (CGRect){.origin=CGPointMake(0.0f, 0.0f), .size=_image.size};
        
        
        // ContentSize and ZoomScale
        _scrollView.contentSize         = _image.size;
        CGRect scrollViewFrame          = _scrollView.frame;
        CGFloat scaleWidth              = scrollViewFrame.size.width / _scrollView.contentSize.width;
        CGFloat scaleHeight             = scrollViewFrame.size.height / _scrollView.contentSize.height;
        CGFloat minScale                = MIN(scaleWidth, scaleHeight);
        _scrollView.minimumZoomScale    = minScale;
        _scrollView.maximumZoomScale    = 1.0f;
        _scrollView.zoomScale           = minScale;
        
        
        // center the content
        [self centerScrollViewContents];
        
        // animate
        [self animate];
    }
}

- (void)centerScrollViewContents
{
    CGSize boundsSize       = _scrollView.bounds.size;
    CGRect contentsFrame    = _imgView.frame;
    
    contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    
    _imgView.frame = contentsFrame;
}

// set the image animated
- (void)changeImage
{
    _imgView.image = _image;
    
    CATransition *transition = [CATransition animation];
    transition.duration = FADE_DURATION;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    
    [_imgView.layer addAnimation:transition forKey:nil];
}

- (void)animate
{
    animation = [[_animations objectAtIndex:[self giveRandomNumAnimation]] intValue];
    
    switch (animation)
    {
        case LAAVAnimationZoomIn:
        {
            [self zoomInAnimation];
        }
            break;
            
        case LAAVAnimationZoomOut:
        {
            [self zoomOutAnimation];
        }
            break;
            
        case LAAVAnimationMoveLeft:
        {
            [self moveLeftAnimation];
        }
            break;
            
        case LAAVAnimationMoveRight:
        {
            [self moveRightAnimation];
        }
            break;
            
        default:
            break;
    }
}

- (void)zoomInAnimation
{
    CGRect contentsFrame        = _imgView.frame;
    contentsFrame.origin.x     -= (contentsFrame.size.width*0.2)/2;
    contentsFrame.origin.y     -= (contentsFrame.size.height*0.2)/2;
    contentsFrame.size.width   -= contentsFrame.size.width*0.2;
    contentsFrame.size.height  -= contentsFrame.size.height*0.2;
    
    [UIView animateWithDuration:ANIMATION_DURATION animations:^ {
        _imgView.frame = contentsFrame;
    }];
}

- (void)zoomOutAnimation
{
    CGRect contentsFrame        = _imgView.frame;
    contentsFrame.origin.x     += (contentsFrame.size.width*0.2)/2;
    contentsFrame.origin.y     += (contentsFrame.size.height*0.2)/2;
    contentsFrame.size.width   += contentsFrame.size.width*0.2;
    contentsFrame.size.height  += contentsFrame.size.height*0.2;
    
    [UIView animateWithDuration:ANIMATION_DURATION animations:^ {
        _imgView.frame = contentsFrame;
    }];
}

- (void)moveLeftAnimation
{
    CGRect contentsFrame    = _imgView.frame;
    
    [UIView animateWithDuration:ANIMATION_DURATION animations:^ {
        [_scrollView setContentOffset:CGPointMake(contentsFrame.origin.x, contentsFrame.origin.y) animated:NO];
    }];
}

- (void)moveRightAnimation
{
    CGSize scrollFrame      = _scrollView.frame.size;
    CGRect contentsFrame    = _imgView.frame;
    contentsFrame.origin.x  = contentsFrame.size.width-scrollFrame.width*2;
    contentsFrame.origin.y  = contentsFrame.size.height-scrollFrame.height*2;
    
    [UIView animateWithDuration:ANIMATION_DURATION animations:^ {
        [_scrollView setContentOffset:CGPointMake(contentsFrame.origin.x, contentsFrame.origin.y) animated:NO];
    }];
}

- (int)giveRandomNumAnimation
{
    return arc4random() % [_animations count];
}

@end
