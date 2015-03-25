//
//  PXPGradientColor.h
//  PAGradientSample
//
//  Created by Louka Desroziers on 17/10/12.
//  Copyright (c) 2012 Louka Desroziers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PXPColorSpace.h"

#define PXPColorRGBConvert(x) x*1./255. // Converts the given decimal (from 0 to 255) into a decimal value in a range of 0.0 to 1.0 for UIColor

/** Objective-C Wrapper for CGGradientRef, intended to be used for iOS developments. 
 * Works like NSGradient (OSX) 
 */

@interface PXPGradientColor : NSObject


/** ------------ */
/** Initialization */

/** Initializes a newly allocated gradient object with two colors..
 * @param startingColor: The starting color of the gradient. The location of this color is fixed at 0.0.
 * @param endingColor: The ending color of the gradient. The location of this color is fixed at 1.0.
 *
 * @returns The initialized PXPGradientColor object.
  */
- (id)initWithStartingColor:(UIColor *)startingColor endingColor:(UIColor *)endingColor;

/** Commodity method for -initWithStartingColor:endingColor: */
+ (id)gradientWithStartingColor:(UIColor *)startingColor endingColor:(UIColor *)endingColor;



/** Initializes a newly allocated gradient object with an array of colors.
 * @param colors: An array of UIColor objects representing the colors to use to initialize the gradient. There must be at least two colors in the array. The first color is placed at location 0.0 and the last at location 1.0. If there are more than two colors, the additional colors are placed at evenly spaced intervals between the first and last colors.
 *
 * @returns The initialized PXPGradientColor object.
 */
- (id)initWithColors:(NSArray *)colors;

/** Commodity method for -initWithColors: */
+ (id)gradientWithColors:(NSArray *)colors;



/** Initializes a newly allocated gradient object with the specified colors, color locations, and color space.
 * @param colors: An array of UIColor objects representing the colors to use to initialize the gradient.
 * @param locations: An array of NSNumber objects initialized using float values. Each value must be in the range 0.0 to 1.0. There must be the same number of locations as are colors in the 'colors' parameter.
 * @param colorSpace: The color space to use for the gradient.
 *
 * @returns The initialized PXPGradientColor object.
 */
- (id)initWithColors:(NSArray *)colors atLocations:(NSArray *)locations colorSpace:(PXPColorSpace *)colorSpace;



/** ------------ */
/** Drawing Linear Gradients */

/** Draws the gradient in the given rect or bezierPath, using the given angle value.
 * @param rect: the rect which the gradient should be drawn in.
 * @param bezierPath: the bezierPath which the gradient should be drawn in.
 * @param angle: the angle which the gradient will use for determining the drawing direction
 * @discussion: For an angle of 0, the gradient is drawn from left to right. For an angle from 0 to 360, the direction evolves clockwise.
 * For a negative value (-360 to 0), the direction evolves counter-clockwise
 * Another example, for a value of 90°, the gradient is drawn from top to bottom. For a value of -90°, the gradient is drawn from bottom to top
 */
- (void)drawInRect:(CGRect)rect angle:(CGFloat)angle;
- (void)drawInBezierPath:(UIBezierPath *)bezierPath angle:(CGFloat)angle;


/** ------------ */
/** Getting Gradient Properties */
@property (nonatomic, readonly) PXPColorSpace *colorSpace;
- (CGGradientRef)CGGradient;

@end
