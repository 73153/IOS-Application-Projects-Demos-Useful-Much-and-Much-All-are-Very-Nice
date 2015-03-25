//
//  Copyright (c) 2012 Click'nTap SRL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (CS_Extensions)
- (UIImage *)imageAtRect:(CGRect)rect;
//- (UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize;
//- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

@end;