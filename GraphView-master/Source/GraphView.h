//
//  GraphView.h
//
//  Created by Simen Gangstad on 09.11.12.
//  Copyright (c) 2012 Three Cards. All rights reserved.
//

#import <UIKit/UIKit.h>

#define GRAPH_HEIGHT self.frame.size.height
#define GRAPH_WIDTH self.frame.size.width
#define OFFSET_X 10.0f // Offset x, set this to higher if you want more space at the side.
#define OFFSET_Y 10.0f // Offset y, set this to higher if you want more space at the bottom.
#define STEP_X 30.0f // Width of cells.
#define STEP_Y 20.0f // Height of cells.
#define GRAPH_TOP 0.0f 
#define CIRCLE_RADIUS 1.5f // Radius og dots on the graph.
#define GRADIENT_FILL {0.12f, 0.12f, 0.12f, 0.9f, 0.12f, 0.12f, 0.12f, 1.0f}; // Set Gradient of choice!

#define GRAPH_ONE 0.09 // When graph is devided in six horizontal parts (125 pixels).
#define GRAPH_TWO 0.265
#define GRAPH_THREE 0.44
#define GRAPH_FOUR 0.615
#define GRAPH_FIVE 0.79
#define GRAPH_SIX 0.965

@interface GraphView : UIScrollView

@property (assign, nonatomic) UIColor *defaultColor; // Default color of the graph.
@property (assign, nonatomic) NSArray *defaultArray; // NSArray of the graph, pass only values from 0.0 to 1.0! (It could be a double or float (0.5f))
@property (nonatomic) BOOL defaultGradientBool; // Determines if the graph has a gradient.
@property (nonatomic) float defaultDashWidth; // Determines how big (or small) dash width of the lines are.

- (void)updateGraph; // Update the graph with a new NSArray (defaultArray).

@end
