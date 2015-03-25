//
//  J1Button.m
//  J1Button
//
//  Created by John Campbell on 2/10/13.
//  Copyright (c) 2013 John Campbell. All rights reserved.
//

#import "J1Button.h"
@interface J1Button()

@property (nonatomic,readonly) UIEdgeInsets insets;

@end
@implementation J1Button


- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self commonInit];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}
-(void)commonInit
{
    self.color = J1ButtonColorGray;
}
- (void) setSize:(J1ButtonSize)size
{
    _size = size;
    self.color = self.color;
}
- (void) setColor:(J1ButtonColor)color
{
    _color = color;
    switch(color) {
        case J1ButtonColorGray:
            [self setGrayStyle];
            break;
        case J1ButtonColorGrayOnBlack:
            [self setGrayOnBlackStyle];
            break;
        case J1ButtonColorRed:
            [self setRedStyle];
            break;
        case J1ButtonColorBlue:
            [self setBlueStyle];
            break;
        case J1ButtonColorGreen:
            [self setGreenStyle];
            break;
        default:
            [self setGrayStyle];
    }
    
}
- (void)setGrayStyle
{
    [self applyColor:@"gray"];
    
    self.titleLabel.shadowOffset = CGSizeMake(0, 1);
    
    [self setTitleColor:[UIColor colorWithWhite:.41 alpha:1] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithWhite:.71 alpha:1] forState:UIControlStateDisabled];
    [self setTitleColor:[UIColor colorWithWhite:.31 alpha:1] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor colorWithWhite:.41 alpha:1] forState:UIControlStateSelected];
    
    [self setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    
}
- (void)setGrayOnBlackStyle
{
    [self applyColor:@"grayOnBlack"];
    
    self.titleLabel.shadowOffset = CGSizeMake(0, 1);
    
    [self setTitleColor:[UIColor colorWithWhite:.41 alpha:1] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithWhite:.71 alpha:1] forState:UIControlStateDisabled];
    [self setTitleColor:[UIColor colorWithWhite:.31 alpha:1] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor colorWithWhite:.41 alpha:1] forState:UIControlStateSelected];
    
    [self setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    
}

- (void)setRedStyle
{
    [self applyColor:@"red"];
        
    self.titleLabel.shadowOffset = CGSizeMake(0, -1);
    
    [self setTitleColor:[UIColor colorWithWhite:1 alpha:1] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithWhite:.8 alpha:1] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor colorWithWhite:.7 alpha:1] forState:UIControlStateSelected];
    
    [self setTitleShadowColor:[UIColor colorWithRed:.5 green:0 blue:0 alpha:1] forState:UIControlStateNormal];

}
- (void)setBlueStyle
{
    [self applyColor:@"blue"];
    
    self.titleLabel.shadowOffset = CGSizeMake(0, -1);
    
    [self setTitleColor:[UIColor colorWithWhite:1 alpha:1] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithWhite:.8 alpha:1] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor colorWithWhite:.7 alpha:1] forState:UIControlStateSelected];
    
    [self setTitleShadowColor:[UIColor colorWithRed:.2 green:.2 blue:.5 alpha:1] forState:UIControlStateNormal];
    
}
- (void)setGreenStyle
{
    [self applyColor:@"green"];
    
    self.titleLabel.shadowOffset = CGSizeMake(0, -1);
    
    [self setTitleColor:[UIColor colorWithWhite:1 alpha:1] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithWhite:.8 alpha:1] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor colorWithWhite:.7 alpha:1] forState:UIControlStateSelected];
    
    [self setTitleShadowColor:[UIColor colorWithRed:.1 green:.5 blue:.1 alpha:1] forState:UIControlStateNormal];
    
}
- (void)applyColor:(NSString*)color
{
    UIImage *n = [self imageWithColorNamed:color stateNamed:@"normal"];
    UIImage *h = [self imageWithColorNamed:color stateNamed:@"highlighted"];
    UIImage *s = [self imageWithColorNamed:color stateNamed:@"selected"];
    // disabled always takes a gray color
    UIImage *d = [self imageWithColorNamed:@"gray" stateNamed:@"disabled"];
    if([color isEqual:@"grayOnBlack"]) {
        d = [self imageWithColorNamed:@"grayOnBlack" stateNamed:@"disabled"];
    }
    
    [self setBackgroundImage:n forState:UIControlStateNormal];
    [self setBackgroundImage:d forState:UIControlStateDisabled];
    [self setBackgroundImage:h forState:UIControlStateHighlighted];
    [self setBackgroundImage:s forState:UIControlStateSelected];
}
- (UIImage*) imageWithColorNamed:(NSString*) color stateNamed:(NSString*) state
{
    NSString *size = self.size == J1ButtonSizeSmall ? @"-small" : @"";
    NSString *imageFile = [NSString stringWithFormat:@"J1-%@%@-%@.png",color,size,state];
    return [[UIImage imageNamed:imageFile] resizableImageWithCapInsets:self.insets resizingMode:UIImageResizingModeStretch];
}
- (UIEdgeInsets)insets
{
    return self.size == J1ButtonSizeSmall ?
        UIEdgeInsetsMake(3, 3, 3, 3) :
        UIEdgeInsetsMake(8, 8, 8, 8);
}
@end
