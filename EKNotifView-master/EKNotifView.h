//  EKNotifView.m
//
//  Created by Ethan Kramer on 1/3/13.
//  Copyright (c) 2013 Ethan Kramer. All rights reserved.

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

#define EKNotifViewAutoResizeNotification @"EKNotifViewAutoResizeNotification"

typedef NS_ENUM(NSInteger, EKNotifViewType){
    EKNotifViewTypeLoading,
    EKNotifViewTypeSuccess,
    EKNotifViewTypeFailure,
    EKNotifViewTypeInfo
};

typedef NS_ENUM(NSInteger, EKNotifViewPosition){
  EKNotifViewPositionTop,
  EKNotifViewPositionBottom
};

typedef NS_ENUM(NSInteger, EKNotifViewTextStyle){
    EKNotifViewTextStyleTitle,
    EKNotifViewTextStyleSubtitle
};

typedef NS_ENUM(NSInteger, EKNotifViewLabelType){
    EKNotifViewLabelTypeTitle,
    EKNotifViewLabelTypeSubtitle,
    EKNotifViewLabelTypeAll
};

@interface EKNotifView : NSObject

@property (nonatomic) BOOL isShown;
@property (nonatomic) BOOL isTransitioning;
@property (strong,nonatomic) UIColor *loadingBackgroundColor;
@property (strong,nonatomic) UIColor *failureBackgroundColor;
@property (strong,nonatomic) UIColor *successBackgroundColor;
@property (strong,nonatomic) UIColor *infoBackgroundColor;
@property (nonatomic) BOOL allowsTapToDismiss;
@property (nonatomic) EKNotifViewType viewType;
@property (nonatomic) EKNotifViewPosition viewPosition;
@property (nonatomic) EKNotifViewTextStyle textStyle;
@property (nonatomic) BOOL allowsAutomaticDismissal;
@property (strong,nonatomic) UIView *view;
@property (nonatomic) CGFloat secondsToDisplay;
@property (nonatomic) CGFloat animationDuration;
@property (nonatomic) CGFloat notifHeight;
@property (strong,nonatomic) UIView *parentView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *infoLabel;
@property (strong, nonatomic) UILabel *descLabel;
@property (strong, nonatomic) UILabel *infoTitleLabel;
@property (strong, nonatomic) UILabel *infoDescLabel;


-(id)initWithNotifViewType:(EKNotifViewType)notifViewType notifPosition:(EKNotifViewPosition)notifViewPosition notifTextStyle:(EKNotifViewTextStyle)notifTextStyle andParentView:(UIView *)containingView;
-(void)show;
-(void)hide;
-(void)setupView;
-(void)changeBackgroundColorToColor:(UIColor *)color forViewType:(EKNotifViewType)noteViewType;
-(void)changeTitleOfLabel:(EKNotifViewLabelType)notifLabelType to:(NSString *)noteTitle;
-(void)changeFontOfLabel:(EKNotifViewLabelType)notifLabelType to:(UIFont *)daFont;

@end
