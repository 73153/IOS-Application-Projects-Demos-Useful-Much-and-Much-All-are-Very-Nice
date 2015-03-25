//
//  M13PanGestureRecognizer.h
//  M13InfiniteTabBar
/*
 Copyright (c) 2013 Brandon McQuilkin
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 One does not claim this software as ones own.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

/** Directional constants. */
typedef enum {
    M13PanGestureRecognizerDirectionVertical,
    M13PanGestureRecognizerDirectionHorizontal
} M13PanGestureRecognizerDirection;

/** A `UIPanGestureRecognizer allowing panning in one direction */
@interface M13PanGestureRecognizer : UIPanGestureRecognizer
/** The direction to allow dragging in. 
 
    Available Values: 
    typedef enum {
        M13PanGestureRecognizerDirectionVertical,
        M13PanGestureRecognizerDirectionHorizontal
    } M13PanGestureRecognizerDirection;
 
 */
@property (nonatomic, assign) M13PanGestureRecognizerDirection panDirection;

@end
