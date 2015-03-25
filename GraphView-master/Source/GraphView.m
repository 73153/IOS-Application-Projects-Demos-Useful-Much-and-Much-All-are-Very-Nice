//
//  GraphView.m
//
//  Created by Simen Gangstad on 09.11.12.
//  Copyright (c) 2012 Three Cards. All rights reserved.
//

#import "GraphView.h"
#import "GraphViewCore.h"

@interface GraphView ()

@property (strong, nonatomic) GraphViewCore *graphView;

@end

@implementation GraphView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        _graphView = [[GraphViewCore alloc] init];
        
        [_graphView setBackgroundColor:[UIColor clearColor]];
        
        [self setBackgroundColor:[UIColor clearColor]];
        [self setShowsHorizontalScrollIndicator:NO];
        [self setShowsVerticalScrollIndicator:NO];
        [self addSubview:_graphView];
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [_graphView setPrivateColor:_defaultColor];
    [_graphView setPrivateArray:_defaultArray];
    [_graphView setPrivateGradientBool:_defaultGradientBool];
    [_graphView setPrivateDashWidth:_defaultDashWidth];
    
    [_graphView setFrame:CGRectMake(0.0f, 0.0f, OFFSET_X + (_defaultArray.count * STEP_X), self.frame.size.height)];
    [self setContentSize:CGSizeMake(OFFSET_X + (_defaultArray.count * STEP_X), _graphView.frame.size.height)];
    
    float delayInSeconds = 0.25f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        if (_graphView.frame.size.width > GRAPH_WIDTH) [self setContentOffset:CGPointMake(_graphView.frame.size.width - GRAPH_WIDTH, 0.0f) animated:YES];
        
    });
}

- (void)updateGraph
{
    [_graphView setPrivateColor:_defaultColor];
    [_graphView setPrivateArray:_defaultArray];
    [_graphView setPrivateGradientBool:_defaultGradientBool];
    [_graphView setPrivateDashWidth:_defaultDashWidth];
    
    [_graphView privateUpdateGraph];
    [self setNeedsDisplay];
    
    if (_graphView.frame.size.width > GRAPH_WIDTH) [self setContentOffset:CGPointMake(_graphView.frame.size.width - GRAPH_WIDTH, 0.0f) animated:YES];
}

@end
