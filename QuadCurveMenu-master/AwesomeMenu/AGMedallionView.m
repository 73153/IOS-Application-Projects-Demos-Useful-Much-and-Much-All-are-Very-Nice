//
//  AGMedallionView.m
//  AGMedallionView
//
//  Created by Artur Grigor on 1/23/12.
//  Copyright (c) 2012 - 2013 Artur Grigor. All rights reserved.
//
//  For the full copyright and license information, please view the LICENSE
//  file that was distributed with this source code.
//

#import "AGMedallionView.h"

#define DEGREES_2_RADIANS(x) (0.0174532925 * (x))

@interface AGMedallionView (){
    CGGradientRef alphaGradient;
}

- (void)setup;

@end

@implementation AGMedallionView

#pragma mark - Properties

@synthesize
    image = _image,
    highlightedImage = _highlightedImage,
    borderColor = _borderColor,
    borderWidth = _borderWidth,
    shadowColor = _shadowColor,
    shadowOffset = _shadowOffset,
    shadowBlur = _shadowBlur;

@synthesize highlighted = _highlighted;

@synthesize progressColor = _progressColor;
@synthesize progress = _progress;

#pragma mark - Property Setters

- (void)setImage:(UIImage *)aImage {
    
    if (_image != aImage) {
        _image = aImage;
        
        [self setNeedsDisplay];
    }
}

- (void)setBorderColor:(UIColor *)aBorderColor {
    if (_borderColor != aBorderColor) {
        _borderColor = aBorderColor;
        
        [self setNeedsDisplay];
    }
}

- (void)setBorderWidth:(CGFloat)aBorderWidth {
    if (_borderWidth != aBorderWidth) {
        _borderWidth = aBorderWidth;
        
        [self setNeedsDisplay];
    }
}

- (void)setShadowColor:(UIColor *)aShadowColor {
    if (_shadowColor != aShadowColor) {
        _shadowColor = aShadowColor;
        
        [self setNeedsDisplay];
    }
}

- (void)setShadowOffset:(CGSize)aShadowOffset {
    if (!CGSizeEqualToSize(self.shadowOffset, aShadowOffset)) {
        _shadowOffset.width = aShadowOffset.width;
        _shadowOffset.height = aShadowOffset.height;
        
        [self setNeedsDisplay];
    }
}

- (void)setShadowBlur:(CGFloat)aShadowBlur {
    if (_shadowBlur != aShadowBlur) {
        _shadowBlur = aShadowBlur;
        
        [self setNeedsDisplay];
    }
}

- (void)setProgress:(CGFloat)aProgress {
    
    if (_progress != aProgress) {
        _progress = aProgress;
        
        [self setNeedsDisplay];
    }
}

#pragma mark - Object Lifecycle

- (void)dealloc {
    // Release the alpha gradient
    CGGradientRelease(alphaGradient);
}

- (void)setup {
    alphaGradient = NULL;
    
    self.borderColor = [UIColor whiteColor];
    self.borderWidth = 5.f;
    self.shadowColor = [UIColor colorWithRed:0.25f green:0.25f blue:0.25f alpha:.75f];
    self.shadowOffset = CGSizeMake(0, 0);
    self.shadowBlur = 2.f;
    self.backgroundColor = [UIColor clearColor];
    self.progress = 0.0;
    self.progressColor = [UIColor grayColor];
}

- (id)init {
    return [self initWithFrame:CGRectMake(0, 0, 128.f, 128.f)];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setup];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setup];
    }
    
    return self;
}

#pragma mark - Drawing

- (CGGradientRef)alphaGradient
{
    if (NULL == alphaGradient) {
        CGFloat colors[6] = {1.f, 0.75f, 1.f, 0.f, 0.f, 0.f};
        CGFloat colorStops[3] = {1.f, 0.35f, 0.f};
        CGColorSpaceRef grayColorSpace = CGColorSpaceCreateDeviceGray();
        alphaGradient = CGGradientCreateWithColorComponents(grayColorSpace, colors, colorStops, 3);
        CGColorSpaceRelease(grayColorSpace);
    }
    
    return alphaGradient;
}

- (void)drawRect:(CGRect)rect
{
    // Image rect
    CGRect imageRect = CGRectMake((self.borderWidth), 
                                  (self.borderWidth) , 
                                  rect.size.width - (self.borderWidth * 2), 
                                  rect.size.height - (self.borderWidth * 2));
    
    // Start working with the mask
    CGColorSpaceRef maskColorSpaceRef = CGColorSpaceCreateDeviceGray();
    CGContextRef mainMaskContextRef = CGBitmapContextCreate(NULL,
                                                        rect.size.width, 
                                                        rect.size.height, 
                                                        8, 
                                                        rect.size.width, 
                                                        maskColorSpaceRef, 
                                                        0);
    CGContextRef shineMaskContextRef = CGBitmapContextCreate(NULL,
                                                             rect.size.width, 
                                                             rect.size.height, 
                                                             8, 
                                                             rect.size.width, 
                                                             maskColorSpaceRef, 
                                                             0);
    CGColorSpaceRelease(maskColorSpaceRef);
    CGContextSetFillColorWithColor(mainMaskContextRef, [UIColor blackColor].CGColor);
    CGContextSetFillColorWithColor(shineMaskContextRef, [UIColor blackColor].CGColor);
    CGContextFillRect(mainMaskContextRef, rect);
    CGContextFillRect(shineMaskContextRef, rect);
    CGContextSetFillColorWithColor(mainMaskContextRef, [UIColor whiteColor].CGColor);
    CGContextSetFillColorWithColor(shineMaskContextRef, [UIColor whiteColor].CGColor);
    
    // Create main mask shape
    CGContextMoveToPoint(mainMaskContextRef, 0, 0);
    CGContextAddEllipseInRect(mainMaskContextRef, imageRect);
    CGContextFillPath(mainMaskContextRef);
    // Create shine mask shape
    CGContextTranslateCTM(shineMaskContextRef, -(rect.size.width / 4), rect.size.height / 4 * 3);
    CGContextRotateCTM(shineMaskContextRef, -45.f);
    CGContextMoveToPoint(shineMaskContextRef, 0, 0);
    CGContextFillRect(shineMaskContextRef, CGRectMake(0, 
                                                      0, 
                                                      rect.size.width / 8 * 5, 
                                                      rect.size.height));
    
    CGImageRef mainMaskImageRef = CGBitmapContextCreateImage(mainMaskContextRef);
    CGImageRef shineMaskImageRef = CGBitmapContextCreateImage(shineMaskContextRef);
    CGContextRelease(mainMaskContextRef);
    CGContextRelease(shineMaskContextRef);
    // Done with mask context
    
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextSaveGState(contextRef);
    
    UIImage *currentImage = (self.highlighted ? self.highlightedImage : self.image);
    
    CGImageRef imageRef = CGImageCreateWithMask(currentImage.CGImage, mainMaskImageRef);
    
    CGContextTranslateCTM(contextRef, 0, rect.size.height);
    CGContextScaleCTM(contextRef, 1.0, -1.0);
    
    CGContextSaveGState(contextRef);
    
    // Draw image
    CGContextDrawImage(contextRef, rect, imageRef);
    
    CGContextRestoreGState(contextRef);
    CGContextSaveGState(contextRef);
    
    // Clip to shine's mask
    CGContextClipToMask(contextRef, self.bounds, mainMaskImageRef);
    CGContextClipToMask(contextRef, self.bounds, shineMaskImageRef);
    CGContextSetBlendMode(contextRef, kCGBlendModeLighten);
    CGContextDrawLinearGradient(contextRef, [self alphaGradient], CGPointMake(0, 0), CGPointMake(0, self.bounds.size.height), 0);
    
    CGImageRelease(mainMaskImageRef);
    CGImageRelease(shineMaskImageRef);
    CGImageRelease(imageRef);
    // Done with image

    CGContextRestoreGState(contextRef);
    
    CGContextSetLineWidth(contextRef, self.borderWidth);
    CGContextSetStrokeColorWithColor(contextRef, self.borderColor.CGColor);
    CGContextMoveToPoint(contextRef, 0, 0);
    CGContextAddEllipseInRect(contextRef, imageRect);
    // Drop shadow
    CGContextSetShadowWithColor(contextRef, 
                                self.shadowOffset, 
                                self.shadowBlur, 
                                self.shadowColor.CGColor);
    CGContextStrokePath(contextRef);
    CGContextRestoreGState(contextRef);
    
    CGContextSaveGState(contextRef);
    
    // Progress Arc
    
    CGPoint centerPoint = CGPointMake(imageRect.origin.x + imageRect.size.width / 2,imageRect.origin.y + imageRect.size.height / 2);
    
    if (self.progress != 0.0f) {
        
        float radius = (imageRect.size.height / 2);
        float endAngle = DEGREES_2_RADIANS((self.progress*359.9)-90);
        float startAngle = DEGREES_2_RADIANS(270);
        
        CGMutablePathRef progressPath = CGPathCreateMutable();
        CGPathAddArc(progressPath, NULL, centerPoint.x, centerPoint.y, radius, startAngle, endAngle, NO);
        
        CGContextSetStrokeColorWithColor(contextRef, self.progressColor.CGColor);
        CGContextSetLineWidth(contextRef, 3.0);
        CGContextAddPath(contextRef, progressPath);
        CGContextStrokePath(contextRef);
        CGPathRelease(progressPath);
    }
    
    CGContextRestoreGState(contextRef);
}

@end
