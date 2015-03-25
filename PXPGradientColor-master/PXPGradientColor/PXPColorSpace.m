//
//  PXPColorSpace.m
//  PAGradientSample
//
//  Created by Louka Desroziers on 17/10/12.
//  Copyright (c) 2012 Louka Desroziers. All rights reserved.
//

#import "PXPColorSpace.h"

@implementation PXPColorSpace
{
    CGColorSpaceRef _colorSpaceRef;
}

+ (id)deviceRGBColorSpace
{
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    PXPColorSpace *colorSpace = [[[self class] alloc] initWithCGColorSpace:colorSpaceRef];
    
    CGColorSpaceRelease(colorSpaceRef);
   
    return colorSpace;
}


+ (id)deviceCMYKColorSpace
{
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceCMYK();
    PXPColorSpace *colorSpace = [[[self class] alloc] initWithCGColorSpace:colorSpaceRef];
    
    CGColorSpaceRelease(colorSpaceRef);
    
    return colorSpace;
}

+ (id)deviceGrayColorSpace
{
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    PXPColorSpace *colorSpace = [[[self class] alloc] initWithCGColorSpace:colorSpaceRef];
    
    CGColorSpaceRelease(colorSpaceRef);
    
    return colorSpace;
}


- (id)initWithCGColorSpace:(CGColorSpaceRef)colorSpaceRef
{
    self = [super init];
    if(self)
    {
        _colorSpaceRef = CGColorSpaceRetain(colorSpaceRef);
    }
    
    return self;
}

#pragma mark - Color Space Informations

- (CGColorSpaceRef)CGColorSpace
{
    return _colorSpaceRef;
}

- (NSInteger)numberOfComponents
{
    return (NSInteger)CGColorSpaceGetNumberOfComponents([self CGColorSpace]);
}


#pragma mark - Dealloc

- (void)dealloc
{
    CGColorSpaceRelease(_colorSpaceRef);
}

@end
