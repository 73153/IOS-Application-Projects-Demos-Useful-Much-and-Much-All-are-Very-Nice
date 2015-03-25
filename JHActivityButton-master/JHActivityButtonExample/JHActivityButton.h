//
//  JHActivityButton.h
//  JHActivityButtonExample
//
//  Created by justin howlett on 2013-05-31.
//  Copyright (c) 2013 JustinHowlett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "easing.h"

@interface JHActivityButton : UIButton

typedef void(^JHAnimationCompletionBlock)(JHActivityButton* button);

typedef NS_ENUM(NSInteger, JHActivityButtonStyle) {
   
    JHActivityButtonStyleExpandLeft,
    JHActivityButtonStyleExpandRight,
    JHActivityButtonStyleExpandDownTop,
    JHActivityButtonStyleExpandDownBottom,
    JHActivityButtonStyleZoomIn,
    JHActivityButtonStyleZoomOut,
    JHActivityButtonStyleSlideLeft,
    JHActivityButtonStyleSlideRight,
    JHActivityButtonStyleSlideUp,
    JHActivityButtonStyleSlideDown,
    JHActivityButtonStyleContractCircle
};

@property(nonatomic,assign)             AHEasingFunction            easingFunction;
@property(nonatomic,assign)             CGFloat                     animationTime; UI_APPEARANCE_SELECTOR //default is 0.3
@property(nonatomic,assign,readonly)    BOOL                        isDisplayingActivityIndicator;
@property(nonatomic,assign)             NSInteger                   shouldSuppressStateChangeOnTap UI_APPEARANCE_SELECTOR;
@property(nonatomic,assign,readonly)    JHActivityButtonStyle       style; UI_APPEARANCE_SELECTOR
@property(nonatomic,assign)             CGFloat                     rectangleCornerRadius; UI_APPEARANCE_SELECTOR
@property(nonatomic,readonly)           UIActivityIndicatorView*    indicator;

-(instancetype)initFrame:(CGRect)frame style:(JHActivityButtonStyle)style;

-(void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state;

-(void)animateToActivityIndicatorState:(BOOL)shouldAnimateToActivityState;
-(void)animateToActivityIndicatorState:(BOOL)shouldAnimateToActivityState completion:(JHAnimationCompletionBlock)callback;

@end
