//
//  PXPGradientColor.m
//  PAGradientSample
//
//  Created by Louka Desroziers on 17/10/12.
//  Copyright (c) 2012 Louka Desroziers. All rights reserved.
//

#define _ClassInitFailedWithReason(msg) [NSString stringWithFormat:@"%@ couldn't be initialized: %@", NSStringFromClass([self class]), msg]
#import "PXPGradientColor.h"

@implementation PXPGradientColor
{
    CGGradientRef   _gradientRef;
}

+ (NSArray *)__automaticLocationsForColors:(NSArray *)colors
{
    NSMutableArray *locations = [[NSMutableArray alloc] init];
    
    for (NSInteger idx = 0; idx < [colors count]; idx++)
        [locations addObject:@(1./([colors count]-1)*idx)];

    return [NSArray arrayWithArray:locations];
}

- (id)initWithStartingColor:(UIColor *)startingColor endingColor:(UIColor *)endingColor
{
    return [self initWithColors:@[ startingColor, endingColor ]
                    atLocations:@[ @(0.0), @(1.0) ]
                     colorSpace:[PXPColorSpace deviceRGBColorSpace]];
}

+ (id)gradientWithStartingColor:(UIColor *)startingColor endingColor:(UIColor *)endingColor
{
    return [[[self class] alloc] initWithStartingColor:startingColor endingColor:endingColor];
}

- (id)initWithColors:(NSArray *)colors
{
    return [self initWithColors:colors
                    atLocations:[[self class] __automaticLocationsForColors:colors]
                     colorSpace:[PXPColorSpace deviceRGBColorSpace]];
}

+ (id)gradientWithColors:(NSArray *)colors
{
    return [[[self class] alloc] initWithColors:colors];;
}

- (id)initWithColors:(NSArray *)colors atLocations:(NSArray *)locations colorSpace:(PXPColorSpace *)colorSpace
{
    self = [super init];
    
    if(self)
    {
        
        NSAssert([colors count] >= 2,
                 _ClassInitFailedWithReason(@"You must provide at least two colors."));
        NSAssert([colors count] == [locations count],
                 _ClassInitFailedWithReason(@"The number of locations must be equals to the number of colors provided."));
        NSAssert(colorSpace != nil,
                 _ClassInitFailedWithReason(@"You must provide a color space."));

        _colorSpace = colorSpace;
        
        double *locationsCArray = malloc([locations count] * sizeof(float));
        [locations enumerateObjectsWithOptions:NSEnumerationConcurrent
                                    usingBlock:^(id locationNumber, NSUInteger locationIdx, BOOL *stop){
                                        
                                        locationsCArray[locationIdx] = [(NSNumber *)locationNumber doubleValue];
                                        
                                    }];
        
        // @unionOfObjects.CGColor doest not work
        NSMutableArray *CGColors = [[NSMutableArray alloc] initWithCapacity:[colors count]];
        for(UIColor *color in colors)
            [CGColors addObject:(id)[color CGColor]];
        
        _gradientRef = CGGradientCreateWithColors([colorSpace CGColorSpace],
                                                  (__bridge CFArrayRef)CGColors,
                                                  locationsCArray);
        
        free(locationsCArray);
        
    }
    
    return self;
}


#pragma mark - Private but useful methods

- (CGFloat)__scopedAngleFromAngle:(CGFloat)angle
{
    return (CGFloat)fmod(angle, 360);
}

// ##Credits goes to Cocotron

- (void)__startingPoint:(CGPoint *)outStartingPoint endingPoint:(CGPoint *)outEndingPoint withAngle:(CGFloat)angle rect:(CGRect)rect
{
    CGPoint start; //start coordinate of gradient
    CGPoint end; //end coordinate of gradient
    //tanSize is the rectangle size for atan2 operation. It is the size of the rect in relation to the offset start point
    CGPoint tanSize;
     
    CGFloat scopedAngle = [self __scopedAngleFromAngle:angle]; // Scopes the angle from 0 to 360. For example, if 'angle' equals 365, the scoped angle will be 5
    CGFloat positiveAngle = abs(scopedAngle);
    
    if(scopedAngle < 0.f) // if provided angle < 0.0
        positiveAngle = 360. - positiveAngle; // then the new angle is equal to 360 - abs(scopedAngle)
    
    if (positiveAngle < 90)
 	{
        start = CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect));
        tanSize = CGPointMake(CGRectGetWidth(rect), CGRectGetHeight(rect));
    }
    else if (positiveAngle < 180)
 	{
        start = CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect));
        tanSize = CGPointMake(-CGRectGetWidth(rect), CGRectGetHeight(rect));
 	}
 	else if (positiveAngle < 270)
 	{
        start = CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect));
        tanSize = CGPointMake(-CGRectGetWidth(rect),-CGRectGetHeight(rect));
 	}
 	else
 	{
        start = CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect));
        tanSize = CGPointMake(CGRectGetWidth(rect), -CGRectGetHeight(rect));
 	}
 	
    
    CGFloat radAngle = positiveAngle / 180 * M_PI; //Angle in radians
    CGFloat distanceToEnd = cos(atan2(tanSize.y,tanSize.x) - radAngle) * sqrt(rect.size.width * rect.size.width + rect.size.height * rect.size.height);
    end = CGPointMake(cos(radAngle) * distanceToEnd + start.x, sin(radAngle) * distanceToEnd + start.y);
    
    *outStartingPoint = start;
    *outEndingPoint = end;
}


// ##End of Credits

#pragma mark - Drawing Linear Gradients


- (void)drawInRect:(CGRect)rect angle:(CGFloat)angle
{
    [self drawInBezierPath:[UIBezierPath bezierPathWithRect:rect]
                     angle:angle];
}

- (void)drawInBezierPath:(UIBezierPath *)bezierPath angle:(CGFloat)angle
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(ctx);
    
    CGContextAddPath(ctx, [bezierPath CGPath]);
    CGContextClip(ctx);
    
    CGPoint startPoint, endPoint;
    [self __startingPoint:&startPoint endingPoint:&endPoint withAngle:angle rect:[bezierPath bounds]];
    
    CGContextDrawLinearGradient(ctx,
                                [self CGGradient],
                                startPoint,
                                endPoint,
                                kCGGradientDrawsAfterEndLocation);
    
    CGContextRestoreGState(ctx);
}


#pragma mark - Getting Gradient Properties

- (CGGradientRef)CGGradient
{
    return _gradientRef;
}

#pragma mark - Dealloc

- (void)dealloc
{
    CGGradientRelease(_gradientRef);
}

@end
