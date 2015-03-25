//
//  GraphViewCore.m
//
//  Created by Simen Gangstad on 08.11.12.
//  Copyright (c) 2012 Three Cards. All rights reserved.
//

#import "GraphViewCore.h"
#import "GraphView.h"

@implementation GraphViewCore

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {}
    return self;
}

- (void)privateUpdateGraph
{
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext(); // Our context.
    
    CGContextSetLineWidth(context, 0.6f); // Set line width for our context.    
    CGContextSetStrokeColorWithColor(context, _privateColor.CGColor); // Set stroke color for our context.
    
    if (_privateDashWidth) { // Set line width for our context.
        
        CGFloat dash[] = {_privateDashWidth, _privateDashWidth};
        CGContextSetLineDash(context, 0.0f, dash, 2);
        
    }else {
    
    CGFloat dash[] = {2.0f, 2.0f};
    CGContextSetLineDash(context, 0.0f, dash, 2);
    
    }
    
    int linesInContextVertical = _privateArray.count; // Vertical lines in our context.
    float linesInContextHorizontal = (GRAPH_HEIGHT - GRAPH_TOP - OFFSET_Y) / STEP_Y; // Horizontal lines in our context.
    
    for (int i = 0; i < linesInContextVertical; i++) { // For-loop for drawing vertical lines in our context.
        
        CGContextMoveToPoint(context, OFFSET_X + i * STEP_X, GRAPH_TOP);
        CGContextAddLineToPoint(context, OFFSET_X + i * STEP_X, GRAPH_HEIGHT);
    }
        
    for (int i = 0; i < linesInContextHorizontal; i++) { // For-loop for drawing horizontal lines in our context.
        
        CGContextMoveToPoint(context, 0.0f, GRAPH_HEIGHT - OFFSET_Y - i * STEP_Y);
        CGContextAddLineToPoint(context, GRAPH_WIDTH, GRAPH_HEIGHT - OFFSET_Y - i * STEP_Y);
    }
    
    CGContextStrokePath(context); // Stroke our lines.
    
    CGContextSetLineDash(context, 0.0f, NULL, 0.0f); // Set our line-dash to nil for further drawing.
    
    for (int i = 0; i <= linesInContextHorizontal; i++) { // Draw numbers horizontaly.
        
        CGPoint point = CGPointMake(0.0f, GRAPH_HEIGHT - OFFSET_Y - i * STEP_Y - 1.0f);
        [self drawText:[NSString stringWithFormat:@"%i.", i + 1] atContext:context withPoint:point];
    }
    
    if (_privateArray.count != 0) {
        
    [self drawLineGraphWithContext:context]; // Draw the graph.
    
    CGContextSetTextMatrix(context, CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0)); // Draw numbers in the bottom.
    CGContextSelectFont(context, "AmericanTypewriter-Light", 11.0f, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextSetFillColorWithColor(context, _privateColor.CGColor);
    
    for (int i = 0; i < _privateArray.count; i++) {
        
        float difference;
                
        if (i < 9) difference = 5.0f;            
        else if (i > 9 && i < 98) difference = 8.0f;
        else if (i == 9) difference = 9.0f;
        else if (i == 99) difference = 12.0f;
        else if (i > 99 && i < 998) difference = 12.0f;

        NSString *text = [NSString stringWithFormat:@"%i.", i + 1];
        CGSize labelSize = [text sizeWithFont:[UIFont fontWithName:@"AmericanTypewriter-Light" size:11.0f]];
        CGContextShowTextAtPoint(context, OFFSET_X - difference + i * STEP_X - labelSize.width/2, GRAPH_HEIGHT - 1.0f, [text cStringUsingEncoding:NSUTF8StringEncoding], text.length);
        
        }
    }
}

- (void)drawLineGraphWithContext:(CGContextRef)context
{    
    CGContextSetLineWidth(context, 2.0f); // Line-width for our context. 
    CGContextSetStrokeColorWithColor(context, _privateColor.CGColor); // Line-color for our context.
    
    int maxGraphHeight = GRAPH_HEIGHT - OFFSET_Y;
    
    /////////////////////////////////////////////
    
    CGContextSetFillColorWithColor(context, [[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5] CGColor]);
    
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, OFFSET_X, GRAPH_HEIGHT);
        
    CGContextAddLineToPoint(context, OFFSET_Y, GRAPH_HEIGHT - maxGraphHeight * [[_privateArray objectAtIndex:0] floatValue]);
    
    for (int i = 0; i < _privateArray.count; i++) { // For-loop for drawing fill in the graph.
        
        CGContextAddLineToPoint(context, OFFSET_X + i * STEP_X, GRAPH_HEIGHT - maxGraphHeight * [[_privateArray objectAtIndex:i] floatValue]);
    }
    
    CGContextAddLineToPoint(context, OFFSET_X + (_privateArray.count - 1) * STEP_X, GRAPH_HEIGHT);
    
    CGContextClosePath(context);
    CGContextSaveGState(context);
    CGContextClip(context);
    
    if (_privateGradientBool == YES) {
    
        CGGradientRef gradient; // Gradient for the fill.
        CGColorSpaceRef colorSpace;
        size_t num_locations = 2;
        CGFloat locations[2] = {0.0f, 1.0f};
        CGFloat components[8] = GRADIENT_FILL;
        
        colorSpace = CGColorSpaceCreateDeviceRGB();
        gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, num_locations);
        CGPoint startPoint, endPoint;
        startPoint.x = OFFSET_X;
        startPoint.y = GRAPH_HEIGHT - OFFSET_Y;
        endPoint.x = OFFSET_X;
        endPoint.y = OFFSET_Y;
        
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
        
        CGContextRestoreGState(context);
        CGColorSpaceRelease(colorSpace);
        CGGradientRelease(gradient);
        
    }
    
    /////////////////////////////////////////////
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, OFFSET_Y, GRAPH_HEIGHT - maxGraphHeight * [[_privateArray objectAtIndex:0] floatValue]); // Set our first point.
    CGFloat dash[] = {2.0f, 2.0f};
    CGContextSetLineDash(context, 0.0f, dash, 2);
    
    for (int i = 0; i < _privateArray.count; i++) { // For-loop for drawing our graph.
        
        CGContextAddLineToPoint(context, OFFSET_X + i * STEP_X, GRAPH_HEIGHT - maxGraphHeight * [[_privateArray objectAtIndex:i] floatValue]); // Add line to a point.
    }
    
    CGContextDrawPath(context, kCGPathStroke); // Draw our context.
    
    CGContextSetLineDash(context, 0.0f, NULL, 0.0f); // Set our line-dash to nil for further drawing.
    
    /////////////////////////////////////////////
    
    CGContextSetFillColorWithColor(context, _privateColor.CGColor);
    
    for (int i = 0; i < _privateArray.count; i++) { // Draw circles at point.
        
        float x = OFFSET_X + i * STEP_X;
        float y = GRAPH_HEIGHT - maxGraphHeight * [[_privateArray objectAtIndex:i] floatValue];
        
        CGRect rect = CGRectMake(x - CIRCLE_RADIUS, y - CIRCLE_RADIUS, 2 * CIRCLE_RADIUS, 2 * CIRCLE_RADIUS);
        
        CGContextAddEllipseInRect(context, rect);
    }
    
    CGContextDrawPath(context, kCGPathFillStroke);
    
}

- (void)drawText:(NSString *)text atContext:(CGContextRef)context withPoint:(CGPoint)point
{
    CGContextSelectFont(context, "AmericanTypewriter-Light", 11.0f, kCGEncodingMacRoman); // Font and style of the text.
    CGContextSetTextDrawingMode(context, kCGTextFill); // Drawning-mode of the text.
    CGContextSetFillColorWithColor(context, _privateColor.CGColor); // Color of the text.
    CGContextSetTextMatrix (context, CGAffineTransformMake(1.0f, 0.0f, 0.0f, -1.0f, 0.0f, 0.0f)); // Flip the text around.
    CGContextShowTextAtPoint(context, point.x, point.y, [text cStringUsingEncoding:NSUTF8StringEncoding], text.length); // Show the text.
}

@end