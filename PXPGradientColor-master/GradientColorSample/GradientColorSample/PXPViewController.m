//
//  PXPViewController.m
//  GradientColorSample
//
//  Created by Louka Desroziers on 17/08/13.
//  Copyright (c) 2013 PixiApps. All rights reserved.
//

#import "PXPViewController.h"


@implementation PXPGradientGeometryView

- (void)setBezierPath:(UIBezierPath *)bezierPath
{
    if(_bezierPath != bezierPath)
    {
        [self willChangeValueForKey:@"bezierPath"];
        _bezierPath = bezierPath;
        [self setNeedsDisplay];
        [self didChangeValueForKey:@"bezierPath"];
    }
}

- (void)setGradient:(PXPGradientColor *)gradient
{
    if(_gradient != gradient)
    {
        [self willChangeValueForKey:@"gradient"];
        _gradient = gradient;
        [self setNeedsDisplay];
        [self didChangeValueForKey:@"gradient"];
    }
}

- (void)setAngle:(CGFloat)angle
{
    if(_angle != angle)
    {
        [self willChangeValueForKey:@"angle"];
        _angle = angle;
        [self setNeedsDisplay];
        [self didChangeValueForKey:@"angle"];
    }
}

- (void)drawRect:(CGRect)rect
{
    if([self gradient] != nil)
    {
        [[self gradient] drawInBezierPath:([self bezierPath] == nil ? [UIBezierPath bezierPathWithRect:rect] : [self bezierPath])
                                    angle:[self angle]];
    }
    else
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGContextSaveGState(ctx);
        CGContextSetFillColorWithColor(ctx, [[UIColor blackColor] CGColor]);
        
        CGContextAddPath(ctx, [([self bezierPath] == nil ? [UIBezierPath bezierPathWithRect:rect] : [self bezierPath]) CGPath]);
        CGContextFillPath(ctx);
        
        CGContextRestoreGState(ctx);
        
    }
}


@end

@interface PXPViewController ()
@property (nonatomic, strong) IBOutlet UISlider *angleSlider;
@property (nonatomic, strong) IBOutlet PXPGradientGeometryView *rectangleView, *ovalView, *triangleView;
@end

@implementation PXPViewController

- (UIBezierPath *)__triangleBezierPathForFrame:(CGRect)frame
{
    UIBezierPath *trianglePath = [UIBezierPath bezierPath];
    
    [trianglePath moveToPoint:CGPointMake(CGRectGetMinX(frame), CGRectGetMinY(frame))];
    [trianglePath addLineToPoint:CGPointMake(CGRectGetMidX(frame), CGRectGetMaxY(frame))];
    [trianglePath addLineToPoint:CGPointMake(CGRectGetMaxX(frame), CGRectGetMinY(frame))];
    [trianglePath closePath];
    
    return trianglePath;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self angleSlider] addTarget:self
                           action:@selector(angleValueChanged:)
                 forControlEvents:UIControlEventValueChanged];
    
    
    [[self ovalView] setGradient:[PXPGradientColor gradientWithColors:@[[UIColor redColor],
                                                                       [UIColor greenColor],
                                                                       [UIColor blackColor],
                                                                       [UIColor blueColor],
                                                                       [UIColor yellowColor]
                                                                        ]]];
    [[self ovalView] setBezierPath:[UIBezierPath bezierPathWithOvalInRect:[[self ovalView] bounds]]];
    
    
    [[self rectangleView] setGradient:[PXPGradientColor gradientWithColors:@[[UIColor redColor],
                                                                             [UIColor greenColor],
                                                                             [UIColor blackColor],
                                                                             [UIColor blueColor],
                                                                             [UIColor yellowColor]
                                                                             ]]];
    [[self rectangleView] setBezierPath:nil];
    
    
    [[self triangleView] setGradient:[PXPGradientColor gradientWithStartingColor:[UIColor grayColor] endingColor:[UIColor redColor]]];
    [[self triangleView] setBezierPath:[self __triangleBezierPathForFrame:[[self triangleView] bounds]]];
    
}


- (void)angleValueChanged:(UISlider *)sender
{
    [[self ovalView] setAngle:[sender value]];
    [[self rectangleView] setAngle:[sender value]];
    [[self triangleView] setAngle:[sender value]];
    
}


@end
