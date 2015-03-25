//
//  LAAnimatedGrid.m
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

#import "LAAnimatedGrid.h"
#import "LAAnimatedView.h"

#define MAX_RANDOM_SEC          5
#define MARGIN                  5
#define ANIMATION_DURATION      5.0f
#define GRID_ANIMATION_DELAY    10.0f

typedef enum
{
    LAAGAnimationMove1 = 1,
    LAAGAnimationMove2,
    LAAGAnimationMove3,
    LAAGAnimationMove4
}LAAGAnimation;

// ANIMATIONS (DEFAULT: LAAGAnimationMove1) || explained at bottom

#pragma mark -

@interface LAAnimatedGrid ()
{
    LAAnimatedView *view1;
    LAAnimatedView *view2;
    LAAnimatedView *view3;
    LAAnimatedView *view4;
    LAAnimatedView *view5;
    LAAnimatedView *view6;
    
    NSTimer *imageTimer;
    NSArray *arrViews;
    
    LAAGAnimation animation;
    NSTimer *gridTimer;
}

@end

#pragma mark -

@implementation LAAnimatedGrid

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _laagOrientation = LAAGOrientationHorizontal;
        _margin = MARGIN;
        animation = LAAGAnimationMove1;
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.laagBorderColor = [UIColor blackColor];
        self.laagBackGroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)dealloc
{
    if (imageTimer)
    {
        [imageTimer invalidate];
        imageTimer = nil;
    }
    if (gridTimer)
    {
        [gridTimer invalidate];
        gridTimer = nil;
    }
    
#if !__has_feature(objc_arc)
    [_arrImages release];
    [_placeholderImage release];
    [arrViews release];
    
    [super dealloc];
#endif
}


#pragma mark - Drawing

// Drawing code
- (void)drawRect:(CGRect)rect
{
    if (imageTimer)
    {
        [imageTimer invalidate];
        imageTimer = nil;
    }
    if (gridTimer)
    {
        [gridTimer invalidate];
        gridTimer = nil;
    }
    if (view1)
        [view1 removeFromSuperview];
    if (view2)
        [view2 removeFromSuperview];
    if (view3)
        [view3 removeFromSuperview];
    if (view4)
        [view4 removeFromSuperview];
    if (view5)
        [view5 removeFromSuperview];
    if (view6)
        [view6 removeFromSuperview];
    
    switch (_laagOrientation)
    {
        case LAAGOrientationHorizontal:
        {
            [self setupHorizontal];
        }
            break;
            
        case LAAGOrientationVertical:
        {
            [self setupVertical];
        }
            break;
            
        default:
        {
            [self setupHorizontal];
        }
            break;
    }
    
    // set the background color
    [view1 setScrollBackGroundColor:self.laagBackGroundColor];
    [view2 setScrollBackGroundColor:self.laagBackGroundColor];
    [view3 setScrollBackGroundColor:self.laagBackGroundColor];
    [view4 setScrollBackGroundColor:self.laagBackGroundColor];
    [view5 setScrollBackGroundColor:self.laagBackGroundColor];
    [view6 setScrollBackGroundColor:self.laagBackGroundColor];
    
    // add the views
    [self addSubview:view1];
    [self addSubview:view2];
    [self addSubview:view3];
    [self addSubview:view4];
    [self addSubview:view5];
    [self addSubview:view6];
    
#if !__has_feature(objc_arc)
    [view1 release];
    [view2 release];
    [view3 release];
    [view4 release];
    [view5 release];
    [view6 release];
#endif
    
    // set images in all the views and start timers
    [self setImages];
}

- (void)setLaagBorderColor:(UIColor *)laagBorderColor
{
    self.backgroundColor = laagBorderColor;
}

#pragma mark - Functions

//                   HORIZONTAL
//      -------------------------------------
//      |        |                |         |
//      |    1   |                |    3    |
//      |        |                |         |
//      |--------|       2        |---------|
//      |        |                |         |
//      |        |                |         |
//      |        |                |         |
//      |   4    |----------------|    6    |
//      |        |                |         |
//      |        |       5        |         |
//      |        |                |         |
//      -------------------------------------

- (void)setupHorizontal
{
    CGRect mainFrame = self.frame;
    mainFrame.size.width -= _margin;
    mainFrame.size.height -= _margin;
    
    // First Line
    view1 = [[LAAnimatedView alloc] initWithFrame:CGRectMake(_margin, _margin, (mainFrame.size.width/4)-_margin, (mainFrame.size.height/3)-_margin)];
    view2 = [[LAAnimatedView alloc] initWithFrame:CGRectMake((mainFrame.size.width/4)+_margin, _margin, (mainFrame.size.width/4)*2-_margin, (mainFrame.size.height/3)*2-_margin)];
    view3 = [[LAAnimatedView alloc] initWithFrame:CGRectMake((mainFrame.size.width/4)*3+_margin, _margin, mainFrame.size.width/4-_margin, mainFrame.size.height/3-_margin)];
    
    // Second Line
    view4 = [[LAAnimatedView alloc] initWithFrame:CGRectMake(_margin, (mainFrame.size.height/3)+_margin, mainFrame.size.width/4-_margin, (mainFrame.size.height/3)*2-_margin)];
    view5 = [[LAAnimatedView alloc] initWithFrame:CGRectMake(mainFrame.size.width/4+_margin, (mainFrame.size.height/3)*2+_margin, (mainFrame.size.width/4)*2-_margin, mainFrame.size.height/3-_margin)];
    view6 = [[LAAnimatedView alloc] initWithFrame:CGRectMake(mainFrame.size.width/4*3+_margin, mainFrame.size.height/3+_margin, mainFrame.size.width/4-_margin, (mainFrame.size.height/3)*2-_margin)];
}

//                VERTICAL
//      ---------------------------
//      |                 |       |
//      |        4        |   1   |
//      |                 |       |
//      |-------------------------|
//      |        |                |
//      |        |                |
//      |        |                |
//      |   5    |       2        |
//      |        |                |
//      |        |                |
//      |        |                |
//      |-------------------------|
//      |                 |       |
//      |        6        |   3   |
//      |                 |       |
//      ---------------------------

- (void)setupVertical
{
    CGRect mainFrame = self.frame;
    mainFrame.size.width -= _margin;
    mainFrame.size.height -= _margin;
    
    // First Line
    view4 = [[LAAnimatedView alloc] initWithFrame:CGRectMake(_margin, _margin, (mainFrame.size.width/3)*2-_margin, mainFrame.size.height/4-_margin)];
    view1 = [[LAAnimatedView alloc] initWithFrame:CGRectMake((mainFrame.size.width/3)*2+_margin, _margin, mainFrame.size.width/3-_margin, mainFrame.size.height/4-_margin)];
    
    // Second Line
    view5 = [[LAAnimatedView alloc] initWithFrame:CGRectMake(_margin, mainFrame.size.height/4+_margin, mainFrame.size.width/3-_margin, (mainFrame.size.height/4)*2-_margin)];
    view2 = [[LAAnimatedView alloc] initWithFrame:CGRectMake(mainFrame.size.width/3+_margin, mainFrame.size.height/4+_margin, (mainFrame.size.width/3)*2-_margin, (mainFrame.size.height/4)*2-_margin)];
    
    // Third Line
    view6 = [[LAAnimatedView alloc] initWithFrame:CGRectMake(_margin, (mainFrame.size.height/4)*3+_margin, (mainFrame.size.width/3)*2-_margin, mainFrame.size.height/4-_margin)];
    view3 = [[LAAnimatedView alloc] initWithFrame:CGRectMake((mainFrame.size.width/3)*2+_margin, (mainFrame.size.height/4)*3+_margin, mainFrame.size.width/3-_margin, mainFrame.size.height/4-_margin)];
}

- (void)setImages
{
    for (LAAnimatedView *laaView in [self subviews])
    {
        int randomNum   = [self giveRandomNumImage];
        id obj          = [_arrImages objectAtIndex:randomNum];
        if ([obj isKindOfClass:[UIImage class]])
        {
            [laaView setImage:obj];
        }
        else if ([obj isKindOfClass:[NSURL class]])
        {
            [laaView setImageURL:obj placeholderImage:_placeholderImage];
        }
        else
        {
            NSLog(@"LAAnimatedGrid only support UIImage and NSURL (error at index %d)", randomNum);
        }
    }
    
    imageTimer = [NSTimer scheduledTimerWithTimeInterval:[self giveRandomSeconds] target:self selector:@selector(randomizeImage) userInfo:nil repeats:NO];
    gridTimer  = [NSTimer scheduledTimerWithTimeInterval:GRID_ANIMATION_DELAY target:self selector:@selector(animateGrids) userInfo:nil repeats:YES];
}

- (void)randomizeImage
{
    LAAnimatedView *laaView = [[self subviews] objectAtIndex:[self giveRandomNumView]];
    
    // we can't change an image in a view whitch is animating
    while ([laaView isLocked])
    {
        laaView = [[self subviews] objectAtIndex:[self giveRandomNumView]];
    }
    int randomNum           = [self giveRandomNumImage];
    id obj                  = [_arrImages objectAtIndex:randomNum];
    if ([obj isKindOfClass:[UIImage class]])
    {
        [laaView setImage:obj];
    }
    else if ([obj isKindOfClass:[NSURL class]])
    {
        [laaView setImageURL:obj placeholderImage:_placeholderImage];
    }
    else
    {
        NSLog(@"LAAnimatedGrid only support UIImage and NSURL (error at index %d)", randomNum);
    }
    
    imageTimer = [NSTimer scheduledTimerWithTimeInterval:[self giveRandomSeconds] target:self selector:@selector(randomizeImage) userInfo:nil repeats:NO];
}

- (int)giveRandomNumImage
{
    return arc4random() % [_arrImages count];
}

- (int)giveRandomSeconds
{
    return arc4random() % MAX_RANDOM_SEC;
}

- (int)giveRandomNumView
{
    return arc4random() % [[self subviews] count];
}

#pragma mark - ANIMATIONS

- (void)animateGrids
{
    switch (animation)
    {
        case LAAGAnimationMove1:
        {
            [self move1Animation];
            animation = LAAGAnimationMove2;
        }
            break;
            
        case LAAGAnimationMove2:
        {
            [self move2Animation];
            animation = LAAGAnimationMove3;
        }
            break;
            
        case LAAGAnimationMove3:
        {
            [self move3Animation];
            animation = LAAGAnimationMove4;
        }
            break;
            
        case LAAGAnimationMove4:
        {
            [self move4Animation];
            animation = LAAGAnimationMove1;
        }
            break;
            
        default:
            break;
    }
    
    //gridTimer = [NSTimer scheduledTimerWithTimeInterval:GRID_ANIMATION_DELAY target:self selector:@selector(animateGrids) userInfo:nil repeats:NO];
}

//                VERTICAL
//      ---------------------------
//      |                 |       |
//      |        4        |   1   |
//      |                 |       |
//      |-------------------------|
//      |        |                |
//      |        |                |
//      |        |                |
//      |   5    |       2        |
//      |        |                |
//      |        |                |
//      |        |                |
//      |-------------------------|
//      |                 |       |
//      |        6        |   3   |
//      |                 |       |
//      ---------------------------

- (void)move1Animation
{
    CGRect firstFrame   = view2.frame;
    CGRect secondFrame  = view5.frame;
    if (_laagOrientation == LAAGOrientationVertical)
    {
        secondFrame.origin  = CGPointMake(view2.frame.size.width+_margin*2, view2.frame.origin.y);
        firstFrame.origin   = view5.frame.origin;
    }
    else
    {
        secondFrame.origin  = view2.frame.origin;
        firstFrame.origin   = CGPointMake(view5.frame.origin.x, view5.frame.size.height+_margin*2);
    }
    view2.locked = YES;
    view5.locked = YES;
    
    [UIView animateWithDuration:ANIMATION_DURATION animations:^ {
        view2.frame = secondFrame;
        view5.frame = firstFrame;
    } completion:^(BOOL finished) {
        view2.locked = NO;
        view5.locked = NO;
    }];
}

- (void)move2Animation
{
    CGRect firstFrame   = view5.frame;
    CGRect secondFrame  = view6.frame;
    if (_laagOrientation == LAAGOrientationVertical)
    {
        firstFrame.origin   = CGPointMake(view6.frame.origin.x, view5.frame.origin.y+view6.frame.size.height+_margin);
    }
    else
    {
        firstFrame.origin   = CGPointMake(view5.frame.origin.x+view6.frame.size.width+_margin, view6.frame.origin.y);
    }
    secondFrame.origin  = view5.frame.origin;
    
    view5.locked = YES;
    view6.locked = YES;
    
    [UIView animateWithDuration:ANIMATION_DURATION animations:^ {
        view5.frame = secondFrame;
        view6.frame = firstFrame;
    } completion:^(BOOL finished) {
        view5.locked = NO;
        view6.locked = NO;
    }];
}

- (void)move3Animation
{
    CGRect firstFrame   = view5.frame;
    CGRect secondFrame  = view6.frame;
    if (_laagOrientation == LAAGOrientationVertical)
    {
        firstFrame.origin   = CGPointMake(view6.frame.origin.x, view5.frame.origin.y+view6.frame.size.height+_margin);
    }
    else
    {
        firstFrame.origin   = CGPointMake(view5.frame.origin.x+view6.frame.size.width+_margin, view6.frame.origin.y);
    }
    secondFrame.origin  = view5.frame.origin;
    
    view5.locked = YES;
    view6.locked = YES;
    
    [UIView animateWithDuration:ANIMATION_DURATION animations:^ {
        view5.frame = secondFrame;
        view6.frame = firstFrame;
    } completion:^(BOOL finished) {
        view5.locked = NO;
        view6.locked = NO;
    }];
}

- (void)move4Animation
{
    CGRect firstFrame   = view2.frame;
    CGRect secondFrame  = view5.frame;
    if (_laagOrientation == LAAGOrientationVertical)
    {
        secondFrame.origin  = CGPointMake(view2.frame.size.width+_margin*2, view2.frame.origin.y);
        firstFrame.origin   = view5.frame.origin;
    }
    else
    {
        secondFrame.origin  = view2.frame.origin;
        firstFrame.origin   = CGPointMake(view5.frame.origin.x, view5.frame.size.height+_margin*2);
    }
    
    view2.locked = YES;
    view5.locked = YES;
    
    [UIView animateWithDuration:ANIMATION_DURATION animations:^ {
        view2.frame = secondFrame;
        view5.frame = firstFrame;
    } completion:^(BOOL finished) {
        view2.locked = NO;
        view5.locked = NO;
    }];
}

@end


//    ANIMATION EXPLANATION (SAME TO VERTICAL MODE)

//                    **MOVE1**
//                      FROM
//      -------------------------------------
//      |        |                |         |
//      |    1   |                |    3    |
//      |        |                |         |
//      |--------|       2        |---------|
//      |        |                |         |
//      |        |                |         |
//      |        |                |         |
//      |   4    |----------------|    6    |
//      |        |                |         |
//      |        |       5        |         |
//      |        |                |         |
//      -------------------------------------
//                      TO
//      -------------------------------------
//      |        |                |         |
//      |    1   |       2        |    3    |
//      |        |                |         |
//      |--------|----------------|---------|
//      |        |                |         |
//      |        |                |         |
//      |        |                |         |
//      |   4    |       5        |    6    |
//      |        |                |         |
//      |        |                |         |
//      |        |                |         |
//      -------------------------------------


//                    **MOVE2**
//                      FROM
//      -------------------------------------
//      |        |                |         |
//      |    1   |       2        |    3    |
//      |        |                |         |
//      |--------|----------------|---------|
//      |        |                |         |
//      |        |                |         |
//      |        |                |         |
//      |   4    |       5        |    6    |
//      |        |                |         |
//      |        |                |         |
//      |        |                |         |
//      -------------------------------------
//                      TO
//      -------------------------------------
//      |        |                |         |
//      |    1   |       2        |    3    |
//      |        |                |         |
//      |--------|--------------------------|
//      |        |        |                 |
//      |        |        |                 |
//      |        |        |                 |
//      |   4    |   5    |         6       |
//      |        |        |                 |
//      |        |        |                 |
//      |        |        |                 |
//      -------------------------------------


//                    **MOVE3**
//              Reverse the MOVE2


//                    **MOVE4**
//              Reverse the MOVE1

