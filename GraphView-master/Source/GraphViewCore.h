//
//  GraphViewCore.h
//
//  Created by Simen Gangstad on 08.11.12.
//  Copyright (c) 2012 Three Cards. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GraphViewCore : UIView

@property (strong, nonatomic) UIColor *privateColor; // Private color, set by defaultColor (GraphView).
@property (strong, nonatomic) NSArray *privateArray; // Private array, set by defaultArray (GraphView).
@property (nonatomic) BOOL privateGradientBool; // Private gradientBool, set by defaultGradientBool (GraphView).
@property (nonatomic) float privateDashWidth; // Private dashWidth, set by defaultDashWidth (GraphView).

- (void)privateUpdateGraph; // Update the graph with a new NSArray (privateArray).

@end
