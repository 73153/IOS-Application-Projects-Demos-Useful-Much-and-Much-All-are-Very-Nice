//
//  FTWButton.h
//  FTW
//
//  Created by Soroush Khanlou on 1/26/12.
//  Copyright (c) 2012 FTW. All rights reserved.
//

//todo

//override setframe

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum {
  FTWButtonIconAlignmentLeft,
  FTWButtonIconAlignmentRight
} FTWButtonIconAlignment;

typedef enum {
  FTWButtonIconPlacementEdge,
  FTWButtonIconPlacementTight
} FTWButtonIconPlacement;

@interface FTWButton : UIControl

@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, assign) FTWButtonIconAlignment iconAlignment;
@property (nonatomic, assign) FTWButtonIconPlacement iconPlacement;

//a few default styles
- (void) addDisabledStyleForState:(UIControlState)state;
- (void) addDeleteStyleForState:(UIControlState)state;
- (void) addGrayStyleForState:(UIControlState)state;
- (void) addLightBlueStyleForState:(UIControlState)state;
- (void) addBlueStyleForState:(UIControlState)state;
- (void) addYellowStyleForState:(UIControlState)state;
- (void) addBlackStyleForState:(UIControlState)state;

- (void) setFrame:(CGRect)frame forControlState:(UIControlState)controlState;
- (CGRect) frameForControlState:(UIControlState)controlState;

- (void) setSelected:(BOOL)newSelected animated:(BOOL)animated;
- (void) setHighlighted:(BOOL)highlighted animated:(BOOL)animated;

//backrounds
- (void) setBackgroundColor:(UIColor*)color forControlState:(UIControlState)controlState;

- (void) setColors:(NSArray*)colors forControlState:(UIControlState)controlState;
- (NSArray*) colorsForControlState:(UIControlState)controlState;

//borders
- (void) setBorderWidth:(CGFloat)borderWidth forControlState:(UIControlState)controlState;
- (CGFloat) borderWidthForControlState:(UIControlState)controlState;

- (void) setBorderColor:(UIColor*)borderColor forControlState:(UIControlState)controlState;

- (void) setBorderColors:(NSArray*)borderColor forControlState:(UIControlState)controlState;
- (NSArray*) borderColorsForControlState:(UIControlState)controlState;

- (void) setCornerRadius:(CGFloat)cornerRadius forControlState:(UIControlState)controlState;
- (CGFloat) cornerRadiusForControlState:(UIControlState)controlState;

- (void) setIcon:(UIImage*)icon forControlState:(UIControlState)controlState;
- (UIImage*) iconForControlState:(UIControlState)controlState;

//text
- (void) setText:(NSString*)text forControlState:(UIControlState)controlState;
- (NSString*) textForControlState:(UIControlState)controlState;

- (void) setTextColor:(UIColor*)textColor forControlState:(UIControlState)controlState;
- (UIColor*) textColorForControlState:(UIControlState)controlState;

- (void) setTextShadowColor:(UIColor*)textShadowColor forControlState:(UIControlState)controlState;
- (UIColor*) textShadowColorForControlState:(UIControlState)controlState;

- (void) setTextShadowOffset:(CGSize)textShadowOffset forControlState:(UIControlState)controlState;
- (CGSize) textShadowOffsetForControlState:(UIControlState)controlState;

- (void) setFont:(UIFont *)font;


//shadow
- (void) setShadowColor:(UIColor*)shadowColor forControlState:(UIControlState)controlState;
- (UIColor*) shadowColorForControlState:(UIControlState)controlState;

- (void) setShadowOffset:(CGSize)shadowOffset forControlState:(UIControlState)controlState;
- (CGSize) shadowOffsetForControlState:(UIControlState)controlState;

- (void) setShadowRadius:(CGFloat)shadowRadius forControlState:(UIControlState)controlState;
- (CGFloat) shadowRadiusForControlState:(UIControlState)controlState;

- (void) setShadowOpacity:(CGFloat)shadowOpacity forControlState:(UIControlState)controlState;
- (CGFloat) shadowOpacityForControlState:(UIControlState)controlState;


//inner shadow
- (void) setInnerShadowColor:(UIColor*)shadowColor forControlState:(UIControlState)controlState;
- (UIColor*) innerShadowColorForControlState:(UIControlState)controlState;

- (void) setInnerShadowOffset:(CGSize)shadowOffset forControlState:(UIControlState)controlState;
- (CGSize) innerShadowOffsetForControlState:(UIControlState)controlState;

- (void) setInnerShadowRadius:(CGFloat)shadowRadius forControlState:(UIControlState)controlState;
- (CGFloat) innerShadowRadiusForControlState:(UIControlState)controlState;


@end
