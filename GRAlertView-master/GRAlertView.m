//
//  GRAlertView.m
//  GRAlertView
//
//  Created by Göncz Róbert on 12/13/12.
//  Copyright (c) 2012 Göncz Róbert. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "GRAlertView.h"
#import "QuartzCore/QuartzCore.h"

#define RGBA(r,g,b,a)       [UIColor colorWithRed:((r)/255.0) green:((g)/255.0) blue:((b)/255.0) alpha:(a)]
#define FONT                @"HelveticaNeue-Bold"

typedef enum {
    red,
    blue,
    green,
    alpha,
}colorComponent;

@interface GRAlertView () {
    int moveFactor;
    NSTimer *timer;
    CAShapeLayer *shapeLayer;
}

@property (strong) UIColor *bottomColor;
@property (strong) UIColor *middleColor;
@property (strong) UIColor *topColor;
@property (strong) UIColor *lineColor;

@property (assign) NSString *fontName;
@property (strong) UIColor *fontColor;
@property (strong) UIColor *fontShadowColor;

@property (assign) NSString *imageName;

@end

@implementation GRAlertView

- (void)layoutSubviews
{
    if (_style || _topColor || _fontName) {
    
        switch (_style) {
            case GRAlertStyleAlert:
                [self setTopColor:RGBA(224, 76, 76, 1) middleColor:RGBA(222, 67, 67, 1) bottomColor:RGBA(222, 67, 67, 1) lineColor:RGBA(224, 76, 76, 1)];
                break;
                
            case GRAlertStyleInfo:
                [self setTopColor:RGBA(86, 169, 207, 1) middleColor:RGBA(78, 165, 205, 1) bottomColor:RGBA(78, 165, 205, 1) lineColor:RGBA(86, 169, 207, 1)];
                break;
                
            case GRAlertStyleSuccess:
                [self setTopColor:RGBA(104, 187, 60, 1) middleColor:RGBA(97, 184, 50, 1) bottomColor:RGBA(97, 184, 50, 1) lineColor:RGBA(104, 187, 60, 1)];
                break;
                
            case GRAlertStyleWarning:
                [self setTopColor:RGBA(235, 179, 89, 1) middleColor:RGBA(234, 175, 81, 1) bottomColor:RGBA(234, 175, 81, 1) lineColor:RGBA(235, 179, 89, 1)];
                break;
                
            default:
                break;
        }
        
        for (UIView *subview in self.subviews){
            
            if ([subview isMemberOfClass:[UIImageView class]] && _topColor) {
                subview.hidden = YES;
            }
            
            if ([subview isMemberOfClass:[UILabel class]]) {
                UILabel *label = (UILabel*)subview;
                label.textColor = _fontColor?_fontColor:[UIColor whiteColor];
                label.shadowColor = _fontShadowColor?_fontShadowColor:[UIColor darkGrayColor];
                label.shadowOffset = CGSizeMake(0.0f, 1.0f);
                label.font = [UIFont fontWithName:_fontName?_fontName:FONT size:label.font.pointSize];
            }
            
            if ([subview isKindOfClass:[UIButton class]]) {
                UIButton *button = (UIButton *)subview;
                button.titleLabel.font = [UIFont fontWithName:_fontName?_fontName:FONT size:button.titleLabel.font.pointSize];
                button.titleLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
                [button setTitleShadowColor:_fontShadowColor?_fontShadowColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                [button setTitleColor:_fontColor?_fontColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
        }
        
        switch (_animation) {
            case GRAlertAnimationLines: {
                if (timer) {
                    [timer invalidate];
                    timer = nil;
                }
                timer = [NSTimer scheduledTimerWithTimeInterval:0.05
                                                         target:self
                                                       selector:@selector(setNeedsDisplay)
                                                       userInfo:nil
                                                        repeats:YES];
            }
                break;
                
            case GRAlertAnimationBorder: {
                if (shapeLayer) return;
                
                shapeLayer = [CAShapeLayer layer];
                [self.layer addSublayer:shapeLayer];
                
                CABasicAnimation *dashAnimation;
                dashAnimation = [CABasicAnimation animationWithKeyPath:@"lineDashPhase"];
                dashAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
                dashAnimation.toValue = [NSNumber numberWithFloat:-20.0f];
                dashAnimation.duration = 1.5f;
                dashAnimation.repeatCount = 10000;
                
                [shapeLayer addAnimation:dashAnimation forKey:@"linePhase"];
            }
                break;
                
            default:
                break;
        }
        
        if (_imageName) {
            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(-5, -25, 64, 64)];
            [self.layer addSublayer:iv.layer];
            iv.image = [UIImage imageNamed:_imageName];
        }
    }
}



- (void)drawRect:(CGRect)rect
{
    if (!_style && !_topColor) return;
    
	CGContextRef context = UIGraphicsGetCurrentContext();
    
	CGRect activeBounds = self.bounds;
	CGFloat cornerRadius = 10.0f;
	CGFloat inset = 5.5f;
	CGFloat originX = activeBounds.origin.x + inset;
	CGFloat originY = activeBounds.origin.y + inset;
	CGFloat width = activeBounds.size.width - inset * 2.0f;
	CGFloat height = activeBounds.size.height - (inset + 2.0) * 2.0f;
    
	CGRect bPathFrame = CGRectMake(originX, originY, width, height - (self.numberOfButtons?0:50));
    CGPathRef path = [UIBezierPath bezierPathWithRoundedRect:bPathFrame cornerRadius:cornerRadius].CGPath;
	
    CGContextSaveGState(context);
	CGContextAddPath(context, path);
	CGContextSetFillColorWithColor(context, [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0f].CGColor);
	CGContextSetShadowWithColor(context, CGSizeMake(0.0f, 1.0f), 6.0f, [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor);
    CGContextDrawPath(context, kCGPathFill);
    CGContextRestoreGState(context);
	
	CGContextSaveGState(context);
	CGContextAddPath(context, path);
	CGContextClip(context);
    
	// Gradient
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	size_t count = 3;
	CGFloat locations[3] = {0.0f, 0.57f, 1.0f};
	CGFloat components[12] =
	{	getColor(_topColor, red), getColor(_topColor, green), getColor(_topColor, blue), getColor(_topColor, alpha),
		getColor(_middleColor, red), getColor(_middleColor, green), getColor(_middleColor, blue), getColor(_middleColor, alpha),
        getColor(_bottomColor, red), getColor(_bottomColor, green), getColor(_bottomColor, blue), getColor(_bottomColor, alpha)};
	CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, count);
    
	CGPoint startPoint = CGPointMake(activeBounds.size.width * 0.5f, 0.0f);
	CGPoint endPoint = CGPointMake(activeBounds.size.width * 0.5f, activeBounds.size.height);
    
	CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
	CGColorSpaceRelease(colorSpace);
	CGGradientRelease(gradient);
    
    switch (_animation) {
        case GRAlertAnimationLines:

            moveFactor = moveFactor > 28.0f ? 0.0f : --moveFactor;
            
            CGContextSaveGState(context);
            CGRect hatchFrame = CGRectMake(0.0f, 0.0f, activeBounds.size.width, (activeBounds.size.height));
            CGContextClipToRect(context, hatchFrame);
            
            CGMutablePathRef hatchPath = CGPathCreateMutable();
            int lines = (hatchFrame.size.width/60.0f + hatchFrame.size.height);
            for(int i = -1; i < lines; i++) {
                CGPathMoveToPoint(hatchPath, NULL, 60.0f * i + moveFactor, 0.0f);
                CGPathAddLineToPoint(hatchPath, NULL, 1.0f, 60.0f * i + moveFactor);
            }
            CGContextAddPath(context, hatchPath);
            CGPathRelease(hatchPath);
            CGContextSetLineWidth(context, 20.0f);
            CGContextSetLineCap(context, kCGLineCapSquare);
            CGContextSetStrokeColorWithColor(context, _lineColor.CGColor);
            CGContextDrawPath(context, kCGPathStroke);
            CGContextRestoreGState(context);
            break;
            
        default:
            break;
    }
    
    // Clip the gloss clipping path to the rounded rectangle
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, CGRectGetMinX(activeBounds) + cornerRadius + 0.5, CGRectGetMinY(activeBounds) + 0.5);
    CGContextAddArc(context, CGRectGetMaxX(activeBounds) - cornerRadius + 0.5, CGRectGetMinY(activeBounds) + cornerRadius + 0.5, cornerRadius, 3 * M_PI / 2, 0, 0);
    CGContextAddArc(context, CGRectGetMaxX(activeBounds) - cornerRadius + 0.5, CGRectGetMaxY(activeBounds) - cornerRadius + 0.5, cornerRadius, 0, M_PI / 2, 0);
    CGContextAddArc(context, CGRectGetMinX(activeBounds) + cornerRadius + 0.5, CGRectGetMaxY(activeBounds) - cornerRadius + 0.5, cornerRadius, M_PI / 2, M_PI, 0);
    CGContextAddArc(context, CGRectGetMinX(activeBounds) + cornerRadius + 0.5, CGRectGetMinY(activeBounds) + cornerRadius + 0.5, cornerRadius, M_PI, 3 * M_PI / 2, 0);
    CGContextClosePath(context);
	CGContextClip(context);
	
	// Set up a clipping path for the gloss gradient
	CGFloat glossRadius = 1100.0f;
	CGPoint glossCenterPoint = CGPointMake(CGRectGetMidX(activeBounds), 35.0 - glossRadius);
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, glossCenterPoint.x, glossCenterPoint.y);
	CGContextAddArc(context, glossCenterPoint.x, glossCenterPoint.y, glossRadius, 0.0, M_PI, 0
					);
	CGContextClosePath(context);
	CGContextClip(context);
    
	// Draw the gloss gradient
    CGGradientRef glossGradient;
    CGFloat locations2[2] = { 0.0, 1.0 };
    CGFloat components2[8] = { 1.0, 1.0, 1.0, 0.65,
		1.0, 1.0, 1.0, 0.06 }; 
    glossGradient = CGGradientCreateWithColorComponents(CGColorSpaceCreateDeviceRGB(), components2, locations2, 2);
	CGPoint topCenter = CGPointMake(CGRectGetMidX(activeBounds), 0.0f);
    CGPoint midCenter = CGPointMake(CGRectGetMidX(activeBounds), 35.0f);
    CGContextDrawLinearGradient(context, glossGradient, topCenter, midCenter, 0);
    CGGradientRelease(glossGradient);
    
    CGContextRestoreGState(context);
	CGContextAddPath(context, path);
	CGContextSetLineWidth(context, _animation==GRAlertAnimationBorder?4.0f:2.0f);
    CGContextSetStrokeColorWithColor(context, _fontColor?_fontColor.CGColor:[UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0f].CGColor);

    if (_animation == GRAlertAnimationBorder) {
        CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
        
        shapeLayer.frame = CGRectMake(0, 0, CGRectGetWidth(activeBounds), CGRectGetHeight(activeBounds));
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.strokeColor = _lineColor.CGColor;
        shapeLayer.lineWidth = 4.0f;
        shapeLayer.lineJoin = kCALineJoinRound;
        shapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:10], [NSNumber numberWithInt:10], nil];
        shapeLayer.path = path;
    }
    CGContextDrawPath(context, kCGPathStroke);
}

- (void)setTopColor:(UIColor*)tc middleColor:(UIColor*)mc bottomColor:(UIColor*)bc lineColor:(UIColor*)lc {
    _topColor = tc;
    _middleColor = mc;
    _bottomColor = bc;
    _lineColor = lc;
}

- (void)setFontName:(NSString*)fn fontColor:(UIColor*)fc fontShadowColor:(UIColor*)fsc {
    _fontName = fn;
    _fontColor = fc;
    _fontShadowColor = fsc;
}

- (void)setImage:(NSString *)imageName {
    _imageName = imageName;
}

float getColor(UIColor *color, colorComponent comp) {
    CGFloat redColor = 0.0, greenColor = 0.0, blueColor = 0.0, alphaValue = 0.0;
    if ([color respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [color getRed:&redColor green:&greenColor blue:&blueColor alpha:&alphaValue];
        switch (comp) {
            case red:
                return redColor;
                break;
            case green:
                return greenColor;
                break;
            case blue:
                return blueColor;
                break;
            case alpha:
                return alphaValue;
                break;
        }
    }
    
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    return components[comp];
}

@end
