//
//  AKGradientImageEffect.h
//  AmazeKit
//
//  Created by Jeffrey Kelley on 6/12/12.
//  Copyright (c) 2013 Detroit Labs. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//


#import "AKImageEffect.h"


/** The AKGradientImageEffect draws a gradient, either vertical or horizontal, between at least two
 *  intermediate colors.
 */


typedef enum {
	AKGradientDirectionVertical = 0,
	AKGradientDirectionHorizontal,
} AKGradientDirection;


@interface AKGradientImageEffect : AKImageEffect

/**--------------------------------------
 * @name Creating a Gradient Image Effect
 * --------------------------------------
 */

/** The designated initializer for a gradient image effect.
 *
 *  @param alpha The value for the alpha property.
 *  @param blendMode The value for the blendMode property.
 *  @param colors The value for the colors property.
 *  @param direction The value for the direction property.
 *  @param locations The value for the locations property.
 *  @return An initialized image effect.
 */
- (id)initWithAlpha:(CGFloat)alpha
		  blendMode:(CGBlendMode)blendMode
			 colors:(NSArray *)colors
		  direction:(AKGradientDirection)direction
		  locations:(NSArray *)locations;


/**----------------------------
 * @name Customizing Appearance
 * ----------------------------
 */

/** An array of UIColor objects for the gradient. Must be at least two. */
@property (readonly) NSArray	*colors;

/** The direction to draw the gradient in. Defaults to AKGradientDirectionVertical. */
@property (readonly) AKGradientDirection	direction;

/** An array of NSNumber objects with values between 0 and 1. Represents the location along the
 *  gradient for the color at the corresponding index. If nil, the colors are spaced evenly.
 */
@property (readonly) NSArray	*locations;

@end
