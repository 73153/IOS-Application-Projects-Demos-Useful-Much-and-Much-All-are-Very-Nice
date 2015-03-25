//
//  CNToolbarView.m
//  CNSplitView Example
//
//  Created by Frank Gregor on 17/01/14.
//  Copyright (c) 2014 cocoa:naut. All rights reserved.
//

#import "CNToolbarView.h"

@implementation CNToolbarView

- (void)drawRect:(NSRect)dirtyRect {
	NSRect bounds = [self bounds];
    NSGradient *backgroundGradient = [[NSGradient alloc] initWithStartingColor:[NSColor colorWithCalibratedWhite:0.656 alpha:1.000]
                                                                   endingColor:[NSColor colorWithCalibratedWhite:0.883 alpha:1.000]];
    NSBezierPath *backgroundGradientPath = [NSBezierPath bezierPathWithRect:bounds];
    [backgroundGradient drawInBezierPath:backgroundGradientPath angle:90];

    NSBezierPath *topLine = [NSBezierPath bezierPathWithRect:NSMakeRect(0, bounds.size.height-1, bounds.size.width, 1)];
    [[NSColor grayColor] set];
    [topLine fill];
}

@end
