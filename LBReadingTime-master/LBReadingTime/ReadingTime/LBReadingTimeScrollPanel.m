//
//  LBScrollPanel.m
//  MinutesLeft
//
//  Created by Luca Bernardi on 11/03/13.
//  Copyright (c) 2013 Luca Bernardi. All rights reserved.
//

#import "LBReadingTimeScrollPanel.h"
#import <QuartzCore/QuartzCore.h>

/*
 This code for the UIScrollView's panel 
 is widely based on Florian Mielke's code:
 https://gist.github.com/FlorianMielke/1437123
*/

CGFloat const kDefaultCornerRadius = 4.0;
CGFloat const kDefaultContentInset = 4.0;
CGFloat const kCalloutPinHeight    = 4.0;

@interface LBReadingTimeScrollPanel ()
@end


@implementation LBReadingTimeScrollPanel {
    CGFloat initialHeightOfScrollIndicator;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        self.opaque = NO;
        
        _cornerRadius           = kDefaultCornerRadius;
        _titleLabelPadding      = kDefaultContentInset;
        _calloutBackgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];

        self.titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.titleLabel.font            = [UIFont boldSystemFontOfSize:13.0];
        self.titleLabel.textColor       = [UIColor whiteColor];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.titleLabel];
    }
    return self;
}

#pragma mark - Setter

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:[UIColor clearColor]];
    self.calloutBackgroundColor = backgroundColor;
}

- (void)setDescriptionText:(NSString *)desciptionText
{
    self.titleLabel.text = desciptionText;
    [self sizeToFit];
    [self layoutIfNeeded];
}

#pragma mark - Layout and Drawing

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    
    [self.calloutBackgroundColor setFill];
    
    CGRect bezieRect = rect;
    bezieRect.size.width -= kCalloutPinHeight;
    
    UIBezierPath *bezier = [UIBezierPath bezierPathWithRoundedRect:bezieRect
                                                      cornerRadius:self.cornerRadius];
    
    [bezier moveToPoint:CGPointMake(bezieRect.size.width, (bezieRect.size.height / 2) - kCalloutPinHeight)];

    CGPoint firstLinePoint = CGPointMake(rect.size.width, (bezieRect.size.height / 2));
    [bezier addLineToPoint:firstLinePoint];
    
    CGPoint secondLinePoint = CGPointMake(bezieRect.size.width, (bezieRect.size.height / 2) + kCalloutPinHeight);
    [bezier addLineToPoint:secondLinePoint];
    
    [bezier fill];
    
}

- (CGSize)sizeThatFits:(CGSize)size
{
    [self.titleLabel sizeToFit];
    CGRect rectWithPadding = CGRectInset(self.titleLabel.frame, -self.titleLabelPadding , -self.titleLabelPadding);
    rectWithPadding.size.width += kCalloutPinHeight;
    return rectWithPadding.size;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect titleFrame = self.titleLabel.frame;
    titleFrame.origin.x = self.titleLabelPadding;
    titleFrame.origin.y = self.titleLabelPadding;
    self.titleLabel.frame = titleFrame;
    
    CGRect newRect = CGRectMake(-self.frame.size.width,
                                self.frame.origin.y,
                                self.frame.size.width,
                                self.frame.size.height);
    self.frame = newRect;
}


#pragma mark - UIScrollViewDelegate

- (UIView *)scrollIndicatorOfScrollView:(UIScrollView *)scrollView
{
    // This is a little bit hacking, better to be defensive
    id lastSubviews = [[scrollView subviews] lastObject];
    if ([lastSubviews isKindOfClass:[UIView class]]) {
        UIView *scrollIndicator = (UIView *)lastSubviews;
        return scrollIndicator;
    }
    return nil;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([self superview]) {
        return;
    }

    UIView *scrollIndicator = [self scrollIndicatorOfScrollView:scrollView];
    if (scrollIndicator) {
        
        [scrollIndicator addSubview:self];
        
        CGRect scrollIndicatorFrame = scrollIndicator.frame;
        CGRect panelFrame = self.frame;
        CGFloat panelFrameY = (scrollIndicatorFrame.size.height / 2) - (self.frame.size.height / 2);
        
        panelFrame.origin.y = panelFrameY;
    
        initialHeightOfScrollIndicator = scrollIndicatorFrame.size.height;
        self.frame = panelFrame;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIView *scrollIndicator = [self scrollIndicatorOfScrollView:scrollView];
    
    if (scrollIndicator == nil) {
        return;
    }
    
    CGRect indicatorFrame = [scrollIndicator frame];
	// We are somewhere at the edge (top or bottom)
	if (indicatorFrame.size.height < initialHeightOfScrollIndicator)
	{
		CGRect infoPanelFrame = [self frame];
        
		// The indicator starts shrinking, so we need to adjust our info panel's y-origin to stays centered
		if (indicatorFrame.size.height > infoPanelFrame.size.height + 2) {
			infoPanelFrame.origin.y = (indicatorFrame.size.height / 2) - (infoPanelFrame.size.height / 2);
		}
		// We are at the bottom of the screen and the indicator is now smaller than our info panel
		else if (indicatorFrame.origin.y > 0)
		{
			infoPanelFrame.origin.y = (infoPanelFrame.size.height - indicatorFrame.size.height) * -1;
		}
        
        self.frame = infoPanelFrame;
	}
    
    if ([scrollView isKindOfClass:[UITextView class]]) {
        NSUInteger remainingTime      = [(UITextView *)scrollView remainingReadingTime];
        NSString *remainingTimeString = [NSString stringWithFormat:NSLocalizedString(@"%d min left", nil), remainingTime];
        [self setDescriptionText:remainingTimeString];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self removeFromSuperview];
}

@end
