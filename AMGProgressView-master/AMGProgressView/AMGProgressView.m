//
//  AMGProgressView.m
//  AMGProgressView
//
//  Created by Albert Mata on December 15th, 2012.
//  Copyright (c) Albert Mata. All rights reserved. FreeBSD License.
//  Please send comments/corrections to hello@albertmata.net or @almata on Twitter.
//  Download latest version from https://github.com/almata/AMGProgressView
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this
//  list of conditions and the following disclaimer.
//  2. Redistributions in binary form must reproduce the above copyright notice,
//  this list of conditions and the following disclaimer in the documentation
//  and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
//  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//  The views and conclusions contained in the software and documentation are those
//  of the authors and should not be interpreted as representing official policies,
//  either expressed or implied, of the FreeBSD Project.
//

#import "AMGProgressView.h"
#import <QuartzCore/QuartzCore.h>

#define HORIZONTAL_START_POINT  CGPointMake(0, 0.5)
#define HORIZONTAL_END_POINT    CGPointMake(1, 0.5)
#define VERTICAL_START_POINT    CGPointMake(0.5, 1)
#define VERTICAL_END_POINT      CGPointMake(0.5, 0)

@interface AMGProgressView ()
@property (nonatomic, strong) CALayer *whiteLayer;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@end

@implementation AMGProgressView

#pragma mark - Initializer

- (void)setup
{
    _minimumValue = 0.0f;
    _maximumValue = 1.0f;
    _progress = 0.0f;

    _outsideBorder = nil;
    
    _verticalGradient = NO;
    self.gradientLayer.startPoint = HORIZONTAL_START_POINT;
    self.gradientLayer.endPoint = HORIZONTAL_END_POINT;

    self.gradientColors = @[[UIColor blackColor], [UIColor whiteColor]];
    
    _emptyPartAlpha = 0.8f;
    [self changeWhiteLayer];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

#pragma mark - Accessors

- (void)setMinimumValue:(float)minimumValue
{
    _minimumValue = minimumValue;
    [self changeWhiteLayer];
}

- (void)setMaximumValue:(float)maximumValue
{
    _maximumValue = maximumValue;
    [self changeWhiteLayer];
}

- (void)setProgress:(float)progress
{
    _progress = MIN(self.maximumValue, MAX(self.minimumValue, progress));
    [self changeWhiteLayer];
}

- (void)setEmptyPartAlpha:(float)emptyPartAlpha
{
    _emptyPartAlpha = emptyPartAlpha;
    [self changeWhiteLayer];
}

- (void)setOutsideBorder:(UIColor *)outsideBorder
{
    _outsideBorder = outsideBorder;
    if (outsideBorder) {
        self.gradientLayer.borderWidth = 1;
        self.gradientLayer.borderColor = [outsideBorder CGColor];
        self.clipsToBounds = YES;
    } else {
        self.gradientLayer.borderWidth = 0;
    }
}

- (CAGradientLayer *)gradientLayer
{
    return (CAGradientLayer *)self.layer;
}

- (void)setGradientColors:(NSArray *)gradientColors
{
    NSMutableArray *cgColors = [NSMutableArray arrayWithCapacity:gradientColors.count];
    for (UIColor *color in gradientColors) {
        [cgColors addObject:(id)[color CGColor]];
    }
    if ([cgColors count] == 1) [cgColors addObject:cgColors[0]];
    self.gradientLayer.colors = cgColors;
}

- (void)setVerticalGradient:(BOOL)verticalGradient
{
    _verticalGradient = verticalGradient;
    self.gradientLayer.startPoint = verticalGradient ? VERTICAL_START_POINT : HORIZONTAL_START_POINT;
    self.gradientLayer.endPoint   = verticalGradient ? VERTICAL_END_POINT : HORIZONTAL_END_POINT;
}

#pragma mark - Drawing

- (void)changeWhiteLayer
{
    if (!self.whiteLayer) {
        self.whiteLayer = [CALayer layer];
        self.whiteLayer.backgroundColor = [UIColor whiteColor].CGColor;
        [self.layer addSublayer:self.whiteLayer];
    }
    self.whiteLayer.opacity = self.emptyPartAlpha;
    self.whiteLayer.frame = [self rectForWhite];
}

- (CGRect)rectForWhite
{     
    int border = (self.outsideBorder) ? 1 : 0;
    
    if (self.verticalGradient) {
        CGFloat whiteY = (self.progress / (self.maximumValue - self.minimumValue)) * (self.bounds.size.height - 2 * border);
        return CGRectMake(self.bounds.origin.x + border,
                          border,
                          self.bounds.size.width - 2 * border,
                          self.bounds.size.height - whiteY - 2 * border);
    } else {
        CGFloat whiteX = (self.progress / (self.maximumValue - self.minimumValue)) * (self.bounds.size.width - 2 * border);
        return CGRectMake(self.bounds.origin.x + whiteX + border,
                          self.bounds.origin.y + border,
                          self.bounds.size.width - whiteX - 2 * border,
                          self.bounds.size.height - 2 * border);
    }
}

#pragma mark - UIView

+ (Class)layerClass
{
    return [CAGradientLayer class];
}

@end