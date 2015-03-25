*Feel free to download the source and play with it, but remember that this source-library is no longer in active development. Therefore, the source might be outdated in terms of the latest iOS SDK.*


# GraphView, installation

-----------------------
-----------------------


## Step 1: Import

- Add GraphView (.h and .m) and GraphViewCore (.h and .m)

- import "GraphView.h"


## Step 2: Create an instance of GraphView and alloc, init it

- @property (strong, nonatomic) GraphView *graphView;

- _graphView = [[GraphView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];


## Step 3: Set some properties

- [_graphView setDefaultColor:[UIColor whiteColor]]; 
> (Optional, default is black).
>> Color of the graph (Lines and numbers).

- [_graphView setDefaultArray:_array];
> (Required, GraphView will not work if else).
>> Array for the graph.

- [_graphView setDefaultGradientBool:YES];
> (Optional, default is NO).
>> Determines if the graph should be filled with gradient.
>> You can set your own gradient (Default is gray), in GraphView.h. It´s defined as GRADIENT_FILL, the first four numbers is color one, the others is color two (RGBA numbers).

- [_graphView setDefaultDashWidth:2.0f];
> (Optional, default is 2.0f).
>> Line dash for the lines in the graph. Set this to 0.0f for clean lines.


## Step 4: Add the GraphView as subview of your main view

- [self.view addSubview:_graphView];



# Use of the source-library

-----------------------
-----------------------


- The NS(Mutable)Array must only include values of number-types at  a scale from 0.0 to 1.0. 
> Example: 0.50 is in the middle of the graph, 0.90 is almost at the top, 0.10 at the bottom.

- GraphView has an instance-method called *- (void)updateGraph*, use this method for updating and redrawing the GraphView. This can be useful if your NS(Mutable)Array is dynamic or if you´re passing the GraphView an another NS(Mutable)Array.
> Example: [_graphView updateGraph];
> You could update all the other properties before you call [_graphView updateGraph];, in that way you can self determine how your graph should look and be at any time. 


## Other properties you can customize (Found in the header of GraphView)

- define GRAPH_HEIGHT self.frame.size.height.

- define GRAPH_WIDTH self.frame.size.width.

- define OFFSET_X 10.0f.
> Offset x, set this to higher if you want more space at the side.

- define OFFSET_Y 10.0f.
> Offset y, set this to higher if you want more space at the bottom.

- define STEP_X 30.0f.
> Width of cells.

- define STEP_Y 20.0f.
> Height of cells.

- define GRAPH_TOP 0.0f.

- define CIRCLE_RADIUS 1.5f.
> Radius of dots on the graph.

- define GRADIENT_FILL {0.12f, 0.12f, 0.12f, 0.9f, 0.12f, 0.12f, 0.12f, 1.0f};.
> Set Gradient of choice!



# License

-----------------------
-----------------------

Copyright (c) 2012 Simen Gangstad

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

