//
//  PXPColorSpace.h
//  PAGradientSample
//
//  Created by Louka Desroziers on 17/10/12.
//  Copyright (c) 2012 Louka Desroziers. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Objective-C Wrapper for CGColorSpaceRef */

@interface PXPColorSpace : NSObject

+ (id)deviceRGBColorSpace;
+ (id)deviceCMYKColorSpace;
+ (id)deviceGrayColorSpace;

- (id)initWithCGColorSpace:(CGColorSpaceRef)colorSpaceRef;

/** Getting Color Space properties */
- (CGColorSpaceRef)CGColorSpace;
- (NSInteger)numberOfComponents;

@end
