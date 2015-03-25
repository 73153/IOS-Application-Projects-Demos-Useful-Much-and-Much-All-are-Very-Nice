//
//  JHActivityButton.m
//  JHActivityButtonExample
//
//  Created by justin howlett on 2013-05-31.
//  Copyright (c) 2013 JustinHowlett. All rights reserved.
//

#import "JHActivityButton.h"
#import <QuartzCore/QuartzCore.h>
#import "CAKeyframeAnimation+AHEasing.h"

@interface JHActivityButton (){
   
    CAShapeLayer*   _buttonBackgroundShapeLayer;
    
    UIColor*        _backgroundNormalColor;
    UIColor*        _backgroundHighlightedColor;
    UIColor*        _backgroundDisabledColor;
    UIColor*        _backgroundSelectedColor;
    NSDictionary*   _animationMethodTable;
    UILabel*        _fauxLabel;
}

@property(nonatomic,assign) BOOL    isAnimating;

@end

static CGFloat          kExpandFromCenterFactor = 0.27;
static CGFloat          kIndicatorWidth         = 36.0f;
static NSUInteger       kDefaultFrameCount      = 240;
static CGFloat          kExpandWidePadding      = 10.0f;


@implementation JHActivityButton 


-(instancetype)initFrame:(CGRect)frame style:(JHActivityButtonStyle)style{
    
    if (self = [super initWithFrame:frame]){
        
        [self prepareAnimationDispatchTable];
        
        [self.titleLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
        [self.titleLabel addObserver:self forKeyPath:@"textColor" options:NSKeyValueObservingOptionNew context:nil];
        
        self.titleLabel.alpha = 0;
        
        /** Defaults */
        _rectangleCornerRadius  = 0.1;
        _easingFunction         = BackEaseOut;
        _animationTime          = 0.3;
        _backgroundNormalColor  = [UIColor blackColor];
        
        _style                  = style;
        _indicator              = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        [self addTarget:self action:@selector(handleButtonUp) forControlEvents:UIControlEventTouchUpInside];
       
        /* center indicator vertically */
        /** indicator position and animation is controlled all at the CALayer level */
        [_indicator.layer setPosition:CGPointMake(0, (frame.size.height/2) - (kIndicatorWidth/2))];
        _indicator.userInteractionEnabled = NO;
        
        [self drawBackgroundRectangle];
    }
    
    return self;
}


-(void)handleButtonUp{
    
    if (_shouldSuppressStateChangeOnTap)
        return;
    
    [self setSelected:!_isDisplayingActivityIndicator];
}

-(void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    
    [self backgroundColorStateDidChange];
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];

    [self backgroundColorStateDidChange];
    [self buttonStateChanged];
}

-(void)setRectangleCornerRadius:(CGFloat)rectangleCornerRadius{
    
    _rectangleCornerRadius = rectangleCornerRadius;
    
    /** force a minimum of 0.1 as less than that causes animation bugs */
    if (_rectangleCornerRadius < 0.1)
        _rectangleCornerRadius = 0.1;
    
    _buttonBackgroundShapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:_rectangleCornerRadius].CGPath;
    
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
 
    
    [self fauxTitleLabel];
    [self addSubview:_fauxLabel];
    
}

-(void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state{
    
    switch (state) {
        case UIControlStateNormal:
            _backgroundNormalColor      = color;
            break;
        case UIControlStateHighlighted:
            _backgroundHighlightedColor = color;
            break;
        case UIControlStateDisabled:
            _backgroundDisabledColor    = color;
            break;
        case UIControlStateSelected:
            _backgroundSelectedColor    = color;
            break;
        case UIControlStateApplication:
            //nothing yet
            break;
        case UIControlStateReserved:
            //nothing yet
            break;
    }
    
    if (state == self.state) _buttonBackgroundShapeLayer.fillColor   = color.CGColor;
}

-(void)animateToActivityIndicatorState:(BOOL)shouldAnimateToActivityState completion:(JHAnimationCompletionBlock)callback{
    
     if (_isAnimating) return;
    
    __block JHActivityButton* blockSelf = self;
    
    [self addSubview:_indicator];
    [_indicator startAnimating];
    
    _isAnimating = YES;
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:_animationTime];
    [CATransaction setCompletionBlock:^{
        _isDisplayingActivityIndicator = !_isDisplayingActivityIndicator;
        blockSelf.isAnimating = NO;
        if (callback){
            callback(blockSelf);
        }
    }];
    
    /** query method dispatch table for correct method for current style and state */
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:[self animationSelectorForCurrentStyle:YES]];
#pragma clang diagnostic pop
    
    [CATransaction commit];
}

-(void)animateToActivityIndicatorState:(BOOL)shouldAnimateToActivityState{
    
    [self animateToActivityIndicatorState:shouldAnimateToActivityState completion:NULL];
}

-(void)drawBackgroundRectangle{
    
    if (!_buttonBackgroundShapeLayer){
        _buttonBackgroundShapeLayer             = [CAShapeLayer layer];
        _buttonBackgroundShapeLayer.fillColor   = _backgroundNormalColor.CGColor;
        [self.layer addSublayer:_buttonBackgroundShapeLayer];
    }
    
    _buttonBackgroundShapeLayer.path        = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:_rectangleCornerRadius].CGPath;
    _buttonBackgroundShapeLayer.anchorPoint = CGPointMake(0.5f, 0.5f);
    

}

#pragma mark -
#pragma mark - UIButton State Change Handling

/** KVO on self.state not possible as it's "synthesized from other flags." using existing UIButton Methods instead */

-(void)buttonStateChanged{
    
    if (_shouldSuppressStateChangeOnTap)
        return;
    
    [self animateToActivityIndicatorState:!_isDisplayingActivityIndicator];
}

-(void)backgroundColorStateDidChange{
    
    if (_shouldSuppressStateChangeOnTap)
        return;
        
    UIColor* colorToAnimateTo = [UIColor colorWithCGColor:_buttonBackgroundShapeLayer.fillColor];
    
    if (self.state == UIControlStateDisabled){
                
        if(_backgroundDisabledColor)colorToAnimateTo =  _backgroundDisabledColor;
     
    }else if (self.state == UIControlStateNormal){
                
        colorToAnimateTo = _backgroundNormalColor;
        
    }else if (self.state == UIControlStateSelected){
        
        if(_backgroundSelectedColor)colorToAnimateTo       = _backgroundSelectedColor;

    }else if (self.state == UIControlStateHighlighted){
        
        if(_backgroundHighlightedColor) colorToAnimateTo    = _backgroundHighlightedColor;
        
    }else if (UIControlStateHighlighted | UIControlStateSelected){
            
        if(_backgroundHighlightedColor) colorToAnimateTo    = _backgroundHighlightedColor;
        
    }
    [self animateBackgroundFillToColor:colorToAnimateTo];
}


-(void)animateBackgroundFillToColor:(UIColor*)endColor{
    
    endColor = [self validateRGBProfileForColor:endColor];
    
    CAShapeLayer* presentationLayer = (CAShapeLayer*)_buttonBackgroundShapeLayer.presentationLayer;
        
    /** totally boss eased color transform */
    
	CGFloat t = 0.0;
	CGFloat dt = 1.0 / (kDefaultFrameCount - 1);
    
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:kDefaultFrameCount];
    
	for(size_t frame = 0; frame < kDefaultFrameCount; ++frame, t += dt)
	{
        CGColorRef currentFillColor = presentationLayer.fillColor;
        UIColor* currentColor = [UIColor colorWithCGColor:currentFillColor];
        currentColor = [self validateRGBProfileForColor:currentColor];
        
        CGFloat currentRed = 0.0, currentGreen = 0.0, currentBlue = 0.0, currentAlpha =0.0;
        [currentColor getRed:&currentRed green:&currentGreen blue:&currentBlue alpha:&currentAlpha];
        
        CGFloat endRed = 0.0, endGreen = 0.0, endBlue = 0.0, endAlpha = 0.0;
        [endColor getRed:&endRed green:&endGreen blue:&endBlue alpha:&endAlpha];
        
        CGFloat easedRed = currentRed + _easingFunction(t) * (endRed - currentRed);
        CGFloat easedGreen = currentGreen + _easingFunction(t) * (endGreen - currentGreen);
        CGFloat easedBlue = currentBlue + _easingFunction(t) * (endBlue - currentBlue);
        CGFloat easedAlpha = currentAlpha + _easingFunction(t) * (endAlpha - currentAlpha);
        
    
        UIColor* easedColor = [UIColor colorWithRed:easedRed green:easedGreen blue:easedBlue alpha:easedAlpha];
        	
		[values addObject:(__bridge id)easedColor.CGColor];
	}
	
	CAKeyframeAnimation *colorAnimation = [CAKeyframeAnimation animationWithKeyPath:@"fillColor"];
    colorAnimation.duration = _animationTime;
    colorAnimation.fillMode = kCAFillModeForwards;
    [colorAnimation setValues:values];
    colorAnimation.removedOnCompletion = NO;
	[_buttonBackgroundShapeLayer addAnimation:colorAnimation forKey:@"fillColor"];
}

#pragma mark -
#pragma mark - KVO on titleLabel.text

- (void) observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context {
   
    if ([keyPath isEqual:@"text"]) {
        _fauxLabel.text = self.titleLabel.text;
    }else if ([keyPath isEqual:@"textColor"]){
        [_fauxLabel setTextColor:self.titleLabel.textColor];
    }
}

#pragma mark - 
#pragma mark Style Specific Animation Methods


#pragma mark - 
#pragma mark - expand from center left/right

-(void)animateBackgroundExpandLeft{
        
    CGRect newBounds       = self.bounds;
    newBounds.size.width   += ((self.bounds.size.width * kExpandFromCenterFactor)*2);
    
    CGFloat offsetDelta = (newBounds.size.width - self.bounds.size.width)/2;
    CGPoint existingLayerPoint  = _fauxLabel.layer.position;
    CGPoint xOffsetPoint        = existingLayerPoint;
    xOffsetPoint.x              += offsetDelta;
    
    CGFloat zeroPosition = -xOffsetPoint.x + _indicator.bounds.size.width/2;
    zeroPosition += kExpandWidePadding;

    // calculated as delta for core animation
    CGFloat labelXPosDelta =  (newBounds.size.width - self.frame.size.width) /2;
    
    [_indicator.layer setPosition:CGPointMake([self indicatorHorizontalCenter], [self indicatorVerticalCenter])];
    
    if (!_isDisplayingActivityIndicator){
        
        [self translatePositionXInView:_fauxLabel fromValue:0 toValue:labelXPosDelta];
        
        /** animate activity indicator */
        [self translatePositionXInView:_indicator fromValue:0 toValue:zeroPosition];
        
        /** fade in activity indicator */
        [self modifyOpacityOnView:_indicator fromOpacity:0.0 toOpacity:1.0];
        
    }else{
        [self translatePositionXInView:_fauxLabel fromValue:labelXPosDelta toValue:0];
        
        /** animate activity indicator */
        [self translatePositionXInView:_indicator fromValue:zeroPosition toValue:0];

        /** fade in activity indicator */
        [self modifyOpacityOnView:_indicator fromOpacity:1.0 toOpacity:0.0];
        
    }
    
    /** animate background */
    [self expandBackgroundWidthFromCenter];
}

-(void)animateBackgroundExpandRight{
    
    CGRect newBounds       = self.bounds;
    newBounds.size.width   += ((self.bounds.size.width * kExpandFromCenterFactor)*2);
    
    CGFloat offsetDelta = (newBounds.size.width - self.bounds.size.width)/2;
    CGPoint existingLayerPoint  = _fauxLabel.layer.position;
    CGPoint xOffsetPoint        = existingLayerPoint;
    xOffsetPoint.x              -= offsetDelta;
    
    // calculated as delta for core animation
    CGFloat labelXPosDelta =  -(newBounds.size.width - self.frame.size.width) /2;
    
    [_indicator.layer setPosition:CGPointMake([self indicatorHorizontalCenter], [self indicatorVerticalCenter])];
    
    if (!_isDisplayingActivityIndicator){
        
        [self translatePositionXInView:_fauxLabel fromValue:0 toValue:labelXPosDelta];
        
        /** animate activity indicator */
        [self translatePositionXInView:_indicator fromValue:0.0 toValue:(newBounds.size.width/2 - _indicator.bounds.size.width/2)-kExpandWidePadding];
        
        /** fade in activity indicator */
        [self modifyOpacityOnView:_indicator fromOpacity:0.0 toOpacity:1.0];
        
    }else{
        
        [self translatePositionXInView:_fauxLabel fromValue:labelXPosDelta toValue:0];
        
        /** animate activity indicator */
        [self translatePositionXInView:_indicator fromValue:(newBounds.size.width/2 - _indicator.bounds.size.width/2)-kExpandWidePadding toValue:0];
        
        /** fade in activity indicator */
        [self modifyOpacityOnView:_indicator fromOpacity:1.0 toOpacity:0.0];
    }
    
    /** animate background */
    [self expandBackgroundWidthFromCenter];
}

-(void)expandBackgroundWidthFromCenter{
    
    CGRect largeBounds = self.bounds;
    largeBounds.origin.x     -= (self.bounds.size.width * kExpandFromCenterFactor);
    largeBounds.size.width   += ((self.bounds.size.width * kExpandFromCenterFactor)*2);
    
    CGRect newBounds       = (_isDisplayingActivityIndicator)? self.bounds : largeBounds;
    CGRect oldBounds       = (_isDisplayingActivityIndicator)? largeBounds : self.bounds;
    
    
    CAKeyframeAnimation* expandFromCenterAnimation = [self expandFromCenterAnimationWithNewRect:newBounds fromOldRect:oldBounds];
    expandFromCenterAnimation.fillMode = kCAFillModeForwards;
    expandFromCenterAnimation.removedOnCompletion = NO;
    [_buttonBackgroundShapeLayer addAnimation:expandFromCenterAnimation forKey:@"path"];
    
}

-(CAKeyframeAnimation*)expandFromCenterAnimationWithNewRect:(CGRect)newRect fromOldRect:(CGRect)oldRect{
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"path"];

    NSMutableArray *values = [NSMutableArray arrayWithCapacity:kDefaultFrameCount];
	
	CGFloat t = 0.0;
	CGFloat dt = 1.0 / (kDefaultFrameCount - 1);
    
	for(size_t frame = 0; frame < kDefaultFrameCount; ++frame, t += dt){
		
        CGFloat value = oldRect.size.width + _easingFunction(t) * (newRect.size.width - oldRect.size.width);
        
        CGFloat delta = value - oldRect.size.width;
        
        CGRect adjustedFrame    = CGRectMake(oldRect.origin.x - (delta/2), oldRect.origin.y, value, oldRect.size.height);
        CGPathRef adjustedPath  = [UIBezierPath bezierPathWithRoundedRect:adjustedFrame cornerRadius:_rectangleCornerRadius].CGPath;
        
		[values addObject:(__bridge id)(adjustedPath)];
	}
	
	[animation setValues:values];
    
    return animation;
}

#pragma mark -
#pragma mark - Expand Down top/bottom

-(void)expandBackgroundHeightTop{
    
    /* calculate background height and activity indicator position */
    
    CGRect newBounds       = self.bounds;
    newBounds.size.height  *= 2;

    CGPoint existingLayerPoint  = _fauxLabel.layer.position;
    CGPoint xOffsetPoint        = existingLayerPoint;
    xOffsetPoint.y              += self.bounds.size.height;
    
    CGFloat labelYPosDelta =  (newBounds.size.height - self.frame.size.height);
    
    /** center activity indicator */
    [_indicator.layer setPosition:CGPointMake([self indicatorHorizontalCenter], [self indicatorVerticalCenter])];
    
    if (!_isDisplayingActivityIndicator){
       
        [self translatePositionYInView:_fauxLabel fromValue:0 toValue:labelYPosDelta];
        /** fade in activity indicator */
        [self modifyOpacityOnView:_indicator fromOpacity:0.0 toOpacity:1.0];
        
    }else{
       
        [self translatePositionYInView:_fauxLabel fromValue:labelYPosDelta toValue:0];
        /** fade in activity indicator */
        [self modifyOpacityOnView:_indicator fromOpacity:1.0 toOpacity:0.0];
    }
    
    [self expandBackgroundHeightDownward];

}

-(void)expandBackgroundHeightBottom{    
    /** animate activity indicator */
    
    [_indicator.layer setPosition:CGPointMake([self indicatorHorizontalCenter], [self indicatorVerticalCenter])];
    
    if (!_isDisplayingActivityIndicator){
        /* move activity indicator from offscreen top to center of original bounds */
        [self translatePositionYInView:_indicator fromValue:0 toValue:[self indicatorVerticalCenter]+(_indicator.frame.size.height/2)];
        
        /** fade in activity indicator */
        [self modifyOpacityOnView:_indicator fromOpacity:0.0 toOpacity:1.0];
        
    }else{
        /* move activity indicator from offscreen top to center of original bounds */
        [self translatePositionYInView:_indicator fromValue:[self indicatorVerticalCenter]+(_indicator.frame.size.height/2) toValue:0];
        
        /** fade in activity indicator */
        [self modifyOpacityOnView:_indicator fromOpacity:1.0 toOpacity:0.0];
    }
    
    [self expandBackgroundHeightDownward];

}

-(void)expandBackgroundHeightDownward{
    
    CGFloat startHeight = (_isDisplayingActivityIndicator)? 2.0 : 1.0;
    CGFloat endHeight = (_isDisplayingActivityIndicator)? 1.0 : 2.0;
    
    
    CAAnimation *backgroundHeight = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"
                                                                     function:_easingFunction
                                                                    fromValue:startHeight toValue:endHeight];
    
    backgroundHeight.fillMode = kCAFillModeForwards;
    backgroundHeight.removedOnCompletion = NO;
    
    [_buttonBackgroundShapeLayer addAnimation:backgroundHeight forKey:@"transform.scale.y"];
}

#pragma mark - 
#pragma mark - Contract to circle

-(void)animateBackgroundToCircle{
    
    /** center activity indicator */
    [_indicator.layer setPosition:CGPointMake([self indicatorHorizontalCenter], [self indicatorVerticalCenter])];
    
    CGFloat endRadius   = MIN(self.bounds.size.height, self.bounds.size.width);
    
    if (!_isDisplayingActivityIndicator){
        
        _fauxLabel.alpha = 0;
        
        CAKeyframeAnimation* shapeAnimation = [self circleShapeAnimationForPathUpdateToRadius:endRadius];
        
        [self modifyOpacityOnView:_indicator fromOpacity:0.0 toOpacity:1.0];
        
        shapeAnimation.fillMode = kCAFillModeForwards;
        shapeAnimation.removedOnCompletion = NO;
        [_buttonBackgroundShapeLayer addAnimation:shapeAnimation forKey:@"path"];
        
    }else{
        
        [self modifyOpacityOnView:_indicator fromOpacity:1.0 toOpacity:0.0];
        
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            _fauxLabel.alpha = 1;
        }];
        
        CAKeyframeAnimation* shapeAnimation = [self defaultShapeAnimationForPathUpdateFromRadius:endRadius];
        shapeAnimation.fillMode = kCAFillModeForwards;
        shapeAnimation.removedOnCompletion = NO;
        [_buttonBackgroundShapeLayer addAnimation:shapeAnimation forKey:@"path"];
        
        [CATransaction commit];
    }

}

-(CAKeyframeAnimation*)defaultShapeAnimationForPathUpdateFromRadius:(CGFloat)currentRadius{
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:kDefaultFrameCount];
	
	CGFloat t = 0.0;
	CGFloat dt = 1.0 / (kDefaultFrameCount - 1);
	
    /** manually calculating the eased height and width and draw a circle path based on the MIN of the two as a radius */
    
    for(size_t frame = 0; frame < kDefaultFrameCount; ++frame, t += dt){
        
        CGFloat startRadius = currentRadius;
        
        CGFloat radius = startRadius + _easingFunction(t) * (_rectangleCornerRadius - startRadius);
        if (radius < 0) radius = 0;
        
        CGFloat adjustedWidth = radius + _easingFunction(t) * (self.bounds.size.width - radius);
        CGFloat widthDelta = adjustedWidth - self.bounds.size.width;
        
        CGFloat adjustedHeight = radius + _easingFunction(t) * (self.bounds.size.height - radius);
        CGFloat heightDelta = adjustedHeight - self.bounds.size.height;
        
        CGRect circlePathRect               = CGRectMake(self.bounds.origin.x - (widthDelta/2), self.bounds.origin.y - (heightDelta/2), adjustedWidth, adjustedHeight);
        
        CGPathRef circlePath                = [UIBezierPath bezierPathWithRoundedRect:circlePathRect cornerRadius:radius].CGPath;
        
        
		[values addObject:(__bridge id)(circlePath)];
	}
	
	[animation setValues:values];
    
    return animation;

}

-(CAKeyframeAnimation*)circleShapeAnimationForPathUpdateToRadius:(CGFloat)endRadius{
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
    
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:kDefaultFrameCount];
	
	CGFloat t = 0.0;
	CGFloat dt = 1.0 / (kDefaultFrameCount - 1);
	
    /** manually calculating the eased height and width and draw a circle path based on the MIN of the two as a radius */
    
    for(size_t frame = 0; frame < kDefaultFrameCount; ++frame, t += dt){
        
        CGFloat startRadius = _rectangleCornerRadius;
        
        CGFloat radius = startRadius + _easingFunction(t) * (endRadius - startRadius);
        if (radius < 0) radius = 0;
    
        CGFloat adjustedWidth = self.bounds.size.width + _easingFunction(t) * (endRadius - self.bounds.size.width);
        CGFloat widthDelta = adjustedWidth - self.bounds.size.width;
        
        CGFloat adjustedHeight = self.bounds.size.height + _easingFunction(t) * (endRadius - self.bounds.size.height);
        CGFloat heightDelta = adjustedHeight - self.bounds.size.height;
        
        
        CGRect circlePathRect               = CGRectMake(self.bounds.origin.x - (widthDelta/2), self.bounds.origin.y - (heightDelta/2), adjustedWidth, adjustedHeight);
        CGPathRef circlePath                = [UIBezierPath bezierPathWithRoundedRect:circlePathRect cornerRadius:radius].CGPath;
		        
        
		[values addObject:(__bridge id)(circlePath)];
	}
	
	[animation setValues:values];
    
    return animation;
}
#pragma mark - 
#pragma mark - zoom in/out

-(void)zoomOutTitleAndIndicator{
    
    [_indicator.layer setPosition:CGPointMake([self indicatorHorizontalCenter], [self indicatorVerticalCenter])];

    if (!_isDisplayingActivityIndicator){
        
        /** scale the label from regular size to small */
        [self scaleView:_fauxLabel fromScale:1.0 toScale:0.8];
        
        /** scale the activity indicator from twice the regular size to the regular size */
        [self scaleView:_indicator fromScale:2.0 toScale:1.0];
        
        /** fade in activity indicator */
        [self modifyOpacityOnView:_indicator fromOpacity:0.0 toOpacity:1.0];
        
        /** fade out title raster copy */
        [self modifyOpacityOnView:_fauxLabel fromOpacity:1.0 toOpacity:0.0];
        
    }else{
        
        /** scale the label from regular size to small */
        [self scaleView:_fauxLabel fromScale:0.8 toScale:1.0];
        
        /** scale the activity indicator from twice the regular size to the regular size */
        [self scaleView:_indicator fromScale:1.0 toScale:2.0];
        
        /** fade in activity indicator */
        [self modifyOpacityOnView:_indicator fromOpacity:1.0 toOpacity:0.0];
        
        /** fade out title raster copy */
        [self modifyOpacityOnView:_fauxLabel fromOpacity:0.0 toOpacity:1.0];
        
    }

}

-(void)zoomInTitleAndIndicator{
    
    [_indicator.layer setPosition:CGPointMake([self indicatorHorizontalCenter], [self indicatorVerticalCenter])];
    
    if (!_isDisplayingActivityIndicator){
       
        /** scale the label from regular size to extra large */
        [self scaleView:_fauxLabel fromScale:1.0 toScale:2.0];
        
        /** scale the activity indicator from small the regular size */
        [self scaleView:_indicator fromScale:0.3 toScale:1.0];
        
        /** fade in activity indicator */
        [self modifyOpacityOnView:_indicator fromOpacity:0.0 toOpacity:1.0];
        
        /** fade out title raster copy */
        [self modifyOpacityOnView:_fauxLabel fromOpacity:1.0 toOpacity:0.0];
        
    }else{
       
        /** scale the label from regular size to extra large */
        [self scaleView:_fauxLabel fromScale:2.0 toScale:1.0];
        
        /** scale the activity indicator from small the regular size */
        [self scaleView:_indicator fromScale:1.0 toScale:0.3];
        
        /** fade in activity indicator */
        [self modifyOpacityOnView:_indicator fromOpacity:1.0 toOpacity:0.0];
        
        /** fade out title raster copy */
        [self modifyOpacityOnView:_fauxLabel fromOpacity:0.0 toOpacity:1.0];
    }
}

#pragma mark - 
#pragma mark - slide left/right

-(void)slideLeft{
    
    self.clipsToBounds = YES;
    
    [_indicator.layer setPosition:CGPointMake([self indicatorHorizontalCenter], [self indicatorVerticalCenter])];
        
    if (!_isDisplayingActivityIndicator){
        
        /** move label from center to offscreen left */
        [self translatePositionXInView:_fauxLabel fromValue:0 toValue:-(_fauxLabel.frame.origin.x + _fauxLabel.frame.size.width)];
        
        /** move indicator from offscreen right to center */
        [self translatePositionXInView:_indicator fromValue:self.bounds.size.width toValue:0];
        
        /** fade in activity indicator */
        [self modifyOpacityOnView:_indicator fromOpacity:0.0 toOpacity:1.0];
        
        /** fade out title raster copy */
        [self modifyOpacityOnView:_fauxLabel fromOpacity:1.0 toOpacity:0.0];
        
    }else{
        
        /** move label from center to offscreen left */
        [self translatePositionXInView:_fauxLabel fromValue:-(_fauxLabel.frame.origin.x + _fauxLabel.frame.size.width) toValue:0];
        
        /** move indicator from offscreen right to center */
        [self translatePositionXInView:_indicator fromValue:0 toValue:self.bounds.size.width];
        
        /** fade in activity indicator */
        [self modifyOpacityOnView:_indicator fromOpacity:1.0 toOpacity:0.0];
        
        /** fade out title raster copy */
        [self modifyOpacityOnView:_fauxLabel fromOpacity:0.0 toOpacity:1.0];
        
    }
    
    
}


-(void)slideRight{
    
    self.clipsToBounds = YES;
    
    [_indicator.layer setPosition:CGPointMake([self indicatorHorizontalCenter], [self indicatorVerticalCenter])];
    
    if (!_isDisplayingActivityIndicator){
        
        /** animate label from center to offscreen right */
        [self translatePositionXInView:_fauxLabel fromValue:0 toValue:self.bounds.size.width];
        
        /** move indicator from offscreen right to center */
        [self translatePositionXInView:_indicator fromValue:-(_fauxLabel.frame.origin.x + _fauxLabel.frame.size.width) toValue:0];
        
        /** fade in activity indicator */
        [self modifyOpacityOnView:_indicator fromOpacity:0.0 toOpacity:1.0];
        
        /** fade out title raster copy */
        [self modifyOpacityOnView:_fauxLabel fromOpacity:1.0 toOpacity:0.0];
        
    }else{
        
        /** animate label from center to offscreen right */
        [self translatePositionXInView:_fauxLabel fromValue:self.bounds.size.width toValue:0];
        
        /** move indicator from offscreen right to center */
        [self translatePositionXInView:_indicator fromValue:0 toValue:-(_fauxLabel.frame.origin.x + _fauxLabel.frame.size.width)];
        
        /** fade in activity indicator */
        [self modifyOpacityOnView:_indicator fromOpacity:1.0 toOpacity:0.0];
        
        /** fade out title raster copy */
        [self modifyOpacityOnView:_fauxLabel fromOpacity:0.0 toOpacity:1.0];
    }
    
    
}

#pragma mark - 
#pragma mark - slide up/down

-(void)slideUp{
    
    self.clipsToBounds = YES;
    
    [_indicator.layer setPosition:CGPointMake([self indicatorHorizontalCenter], [self indicatorVerticalCenter])];
    
    if (!_isDisplayingActivityIndicator){
        /** move title updward offscreen */
        [self translatePositionYInView:_fauxLabel fromValue:0 toValue:-(_fauxLabel.frame.origin.y + _fauxLabel.frame.size.height)];
        
        /** move indicator updward to center */
        [self translatePositionYInView:_indicator fromValue:self.bounds.size.height toValue:0];
        
        /** fade in activity indicator */
        [self modifyOpacityOnView:_indicator fromOpacity:0.0 toOpacity:1.0];
        
        /** fade out title raster copy */
        [self modifyOpacityOnView:_fauxLabel fromOpacity:1.0 toOpacity:0.0];
        
    }else{
        
        /** move title updward offscreen */
        [self translatePositionYInView:_fauxLabel fromValue:-(_fauxLabel.frame.origin.y + _fauxLabel.frame.size.height) toValue:0];
        
        /** move indicator updward to center */
        [self translatePositionYInView:_indicator fromValue:0 toValue:self.bounds.size.height];
        
        /** fade in activity indicator */
        [self modifyOpacityOnView:_indicator fromOpacity:1.0 toOpacity:0.0];
        
        /** fade out title raster copy */
        [self modifyOpacityOnView:_fauxLabel fromOpacity:0.0 toOpacity:1.0];
    }

}


-(void)slideDown{
    
    self.clipsToBounds = YES;
    
    [_indicator.layer setPosition:CGPointMake([self indicatorHorizontalCenter], [self indicatorVerticalCenter])];
    
    if (!_isDisplayingActivityIndicator){
        
        /** move title down offscreen */
        [self translatePositionYInView:_fauxLabel fromValue:0 toValue:self.bounds.size.height];
        
        /** move indicator downward to center*/
        [self translatePositionYInView:_indicator fromValue:-(_indicator.frame.origin.y + _indicator.frame.size.height) toValue:0];
        
        /** fade in activity indicator */
        [self modifyOpacityOnView:_indicator fromOpacity:0.0 toOpacity:1.0];
        
        /** fade out title raster copy */
        [self modifyOpacityOnView:_fauxLabel fromOpacity:1.0 toOpacity:0.0];
        
    }else{
        
        /** move title down offscreen */
        [self translatePositionYInView:_fauxLabel fromValue:self.bounds.size.height toValue:0];
        
        /** move indicator downward to center*/
        [self translatePositionYInView:_indicator fromValue:0 toValue:-(_indicator.frame.origin.y + _indicator.frame.size.height)];
        
        /** fade in activity indicator */
        [self modifyOpacityOnView:_indicator fromOpacity:1.0 toOpacity:0.0];
        
        /** fade out title raster copy */
        [self modifyOpacityOnView:_fauxLabel fromOpacity:0.0 toOpacity:1.0];
    }
    
}

#pragma mark -
#pragma mark - Animation Utility Methods 

/** further abstraction here is very possible as much code duplication still exists
 these utility methods are constructed and named as such to aid readibility and
 ease in adding additiona functionality to a perticular animation */

-(void)translatePositionYInView:(UIView*)viewToTranslate fromValue:(CGFloat)startY toValue:(CGFloat)endY{
    
    CAAnimation *translateXPosition = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"
                                                                       function:_easingFunction
                                                                      fromValue:startY toValue:endY];
    
    translateXPosition.fillMode = kCAFillModeForwards;
    translateXPosition.removedOnCompletion = NO;
    
    [viewToTranslate.layer addAnimation:translateXPosition forKey:@"transform.translation.y"];
}

-(void)translatePositionXInView:(UIView*)viewToTranslate fromValue:(CGFloat)startX toValue:(CGFloat)endX{
    
    CAAnimation *translateXPosition = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"
                                                                   function:_easingFunction
                                                                  fromValue:startX toValue:endX];
    
    translateXPosition.fillMode = kCAFillModeForwards;
    translateXPosition.removedOnCompletion = NO;
    
    [viewToTranslate.layer addAnimation:translateXPosition forKey:@"transform.translation.x"];
}

-(void)modifyOpacityOnView:(UIView*)viewToFade fromOpacity:(CGFloat)startAlpha toOpacity:(CGFloat)endAlpha{
    
    CAAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"
                                                                 function:_easingFunction
                                                                fromValue:startAlpha toValue:endAlpha];
    
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.removedOnCompletion = NO;

    [viewToFade.layer addAnimation:opacityAnimation forKey:@"opacity"];
}

-(void)scaleView:(UIView*)viewToScale fromScale:(CGFloat)startScale toScale:(CGFloat)endScale{
 
    CAAnimation *indicatorAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"
                                                                       function:_easingFunction
                                                                      fromValue:startScale toValue:endScale];
    
    indicatorAnimation.fillMode = kCAFillModeForwards;
    indicatorAnimation.removedOnCompletion = NO;
    
    [viewToScale.layer addAnimation:indicatorAnimation forKey:@"transform.scale"];
    
}

-(void)positionView:(UIView*)view fromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint{
    
    
    CAAnimation *indicatorAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"
                                                                       function:_easingFunction
                                                                      fromPoint:fromPoint
                                                                        toPoint:toPoint];
    
    
    [view.layer addAnimation:indicatorAnimation forKey:@"position"];
    view.layer.position = toPoint;
}

#pragma mark -
#pragma mark Animation Method Dispatch Table 

-(void)prepareAnimationDispatchTable{
    
    /* This is presented as a Dictionary for easy readability */ 
    
    NSMutableDictionary* mutableAnimationMethodTable = [[NSMutableDictionary alloc]init];
    
    mutableAnimationMethodTable[@(JHActivityButtonStyleExpandLeft)]             = @"animateBackgroundExpandLeft";
    mutableAnimationMethodTable[@(JHActivityButtonStyleExpandRight)]            = @"animateBackgroundExpandRight";
    mutableAnimationMethodTable[@(JHActivityButtonStyleExpandDownTop)]          = @"expandBackgroundHeightTop";
    mutableAnimationMethodTable[@(JHActivityButtonStyleExpandDownBottom)]       = @"expandBackgroundHeightBottom";
    mutableAnimationMethodTable[@(JHActivityButtonStyleZoomIn)]                 = @"zoomInTitleAndIndicator";
    mutableAnimationMethodTable[@(JHActivityButtonStyleZoomOut)]                = @"zoomOutTitleAndIndicator";
    mutableAnimationMethodTable[@(JHActivityButtonStyleSlideLeft)]              = @"slideLeft";
    mutableAnimationMethodTable[@(JHActivityButtonStyleSlideRight)]             = @"slideRight";
    mutableAnimationMethodTable[@(JHActivityButtonStyleSlideUp)]                = @"slideUp";
    mutableAnimationMethodTable[@(JHActivityButtonStyleSlideDown)]              = @"slideDown";
    mutableAnimationMethodTable[@(JHActivityButtonStyleContractCircle)]         = @"animateBackgroundToCircle";
    
    _animationMethodTable = [NSDictionary dictionaryWithDictionary:mutableAnimationMethodTable];
}


-(SEL)animationSelectorForCurrentStyle:(BOOL)shouldAnimateToActivityState{
    
    NSString* methodNameString      = _animationMethodTable[@(_style)];
    
    return NSSelectorFromString(methodNameString);
}

#pragma mark - 
#pragma mark - Utility methods

-(CGFloat)indicatorVerticalCenter{
    /** eturn using CALayer center position */
    return (self.bounds.size.height/2);
}

-(CGFloat)indicatorHorizontalCenter{
    /** return using CALayer position */
    return (self.bounds.size.width/2);
}

-(UILabel*)fauxTitleLabel{
    
    if (!_fauxLabel){
        _fauxLabel = [[UILabel alloc] initWithFrame:self.titleLabel.frame];
        _fauxLabel.textAlignment = NSTextAlignmentCenter;
        _fauxLabel.backgroundColor = [UIColor clearColor];
        [_fauxLabel setFont:self.titleLabel.font];
    }
    
    return _fauxLabel;
}

-(UIColor*)validateRGBProfileForColor:(UIColor*)inputColor{
    
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([inputColor CGColor]);
    CGColorSpaceModel colorSpaceModel = CGColorSpaceGetModel(colorSpace);
    
    if (colorSpaceModel == kCGColorSpaceModelRGB){
        
        /** RGBA color, don't change a thing */
        
    }else if (colorSpaceModel == kCGColorSpaceModelMonochrome){
        
        /** convert from white and alpha to RGBA */
        
        CGFloat white = 0.0, alpha = 0.0;
        [inputColor getWhite:&white alpha:&alpha];
        
        inputColor = [UIColor colorWithRed:white green:white blue:white alpha:alpha];
        
    }else{
        NSLog(@"Only RGB and Monochrome colors are supported");
    }
    
    return inputColor;
}

@end
                                    
