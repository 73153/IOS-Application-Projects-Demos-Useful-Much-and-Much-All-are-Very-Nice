//
//  AKPatternImageEffect.h
//  AmazeKit
//
//  Created by Jeff Kelley on 7/26/12.
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


/** The AKPatternImageEffect class repeats a single image as a pattern.
 */


// Constants
extern NSString * const kPatternImageHashKey;


@interface AKPatternImageEffect : AKImageEffect

/**-------------------------------------
 * @name Creating a Pattern Image Effect
 * -------------------------------------
 */

/** The designated initializer for a pattern image effect.
 *
 *  @param alpha The value for the alpha property.
 *  @param blendMode The value for the blendMode property.
 *  @param patternImage The value for the patternImage property.
 *  @return An initialized image effect.
 */
- (id)initWithAlpha:(CGFloat)alpha
		  blendMode:(CGBlendMode)blendMode
	   patternImage:(UIImage *)patternImage;


/**----------------------------
 * @name Customizing Appearance
 * ----------------------------
 */

/** The image to draw as a pattern. This image will be tiled.
 */
@property (readonly) UIImage	*patternImage;

@end
