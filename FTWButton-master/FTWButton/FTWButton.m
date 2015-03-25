//
//  FTWButton.h
//  FTW
//
//  Created by Soroush Khanlou on 1/26/12.
//  Copyright (c) 2012 FTW. All rights reserved.
//


#import "FTWButton.h"
#import "SKInnerShadowLayer.h"

@interface FTWButton()

@property (strong, nonatomic) SKInnerShadowLayer *backgroundLayer;
@property (strong, nonatomic) CAGradientLayer *borderLayer;

@property (strong, nonatomic) UIImageView *normalIcon;
@property (strong, nonatomic) UIImageView *selectedIcon;
@property (strong, nonatomic) UIImageView *highlightedIcon;

@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UILabel *selectedLabel;
@property (strong, nonatomic) NSMutableDictionary *texts;

@property (strong, nonatomic) NSMutableDictionary *textColors;
@property (strong, nonatomic) NSMutableDictionary *textShadowColors;
@property (strong, nonatomic) NSMutableDictionary *textShadowOffsets;

@property (strong, nonatomic) NSMutableDictionary *borderWidths;
@property (strong, nonatomic) NSMutableDictionary *borderGradients;

@property (strong, nonatomic) NSMutableDictionary *cornerRadii;

@property (strong, nonatomic) NSMutableDictionary *gradients;
@property (strong, nonatomic) NSMutableDictionary *frames;

@property (strong, nonatomic) NSMutableDictionary *shadowColors;
@property (strong, nonatomic) NSMutableDictionary *shadowOffsets;
@property (strong, nonatomic) NSMutableDictionary *shadowRadii;
@property (strong, nonatomic) NSMutableDictionary *shadowOpacities;

@property (strong, nonatomic) NSMutableDictionary *innerShadowColors;
@property (strong, nonatomic) NSMutableDictionary *innerShadowOffsets;
@property (strong, nonatomic) NSMutableDictionary *innerShadowRadii;

@property (strong, nonatomic) NSMutableDictionary *icons;


- (id) getValueFromDictionary:(NSMutableDictionary*)dictionary forControlState:(UIControlState)controlState;
- (void) setValue:(id)value inDictionary:(NSMutableDictionary*)dictionary forControlState:(UIControlState)controlState;


- (void) configureViewForControlState:(UIControlState)controlState;
- (void) configureLayerPropertiesForControlState:(UIControlState)controlState;
- (void) configureViewPropertiesForControlState:(UIControlState)controlState;
- (UIControlState) currentControlState;

- (void) commonInit;

@end

@implementation FTWButton

@synthesize borderLayer, backgroundLayer;
@synthesize normalIcon, selectedIcon, highlightedIcon;
@synthesize label, selectedLabel;
@synthesize texts;
@synthesize textColors, textShadowColors, textShadowOffsets, textAlignment;
@synthesize borderWidths, borderGradients, cornerRadii;
@synthesize gradients, frames;
@synthesize shadowColors, shadowOffsets, shadowRadii, shadowOpacities;
@synthesize innerShadowColors, innerShadowOffsets, innerShadowRadii;
@synthesize icons;
@synthesize iconAlignment, iconPlacement;


#pragma mark - init methods

- (id) init {
	self = [super init];
	if (self) {
		[self commonInit];
	}
	return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	if (self) {
		[self commonInit];
	}
	return self;
}

- (id) initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self commonInit];
		self.frame = frame;
	}
	return self;
}


- (void) commonInit {
	self.backgroundColor = [UIColor clearColor];
	
	self.label = [[UILabel alloc] init];
	label.font = [UIFont boldSystemFontOfSize:12.0f];
	label.textColor = [UIColor whiteColor];
	label.shadowColor = [UIColor colorWithRed:107.0f/255.0f green:107.0f/255.0f blue:107.0f/255.0f alpha:0.5f];
	label.shadowOffset = CGSizeMake(0, 1);
	label.backgroundColor = [UIColor clearColor];
	[self addSubview:label];
	
	self.selectedLabel = [[UILabel alloc] init];
	selectedLabel.font = [UIFont boldSystemFontOfSize:12.0f];
	selectedLabel.textColor = [UIColor whiteColor];
	selectedLabel.shadowColor = [UIColor colorWithRed:50.0f/255.0f green:50.0f/255.0f blue:50.0f/255.0f alpha:0.3f];
	selectedLabel.shadowOffset = CGSizeMake(0, 1);
	selectedLabel.backgroundColor = [UIColor clearColor];
	selectedLabel.alpha = 0;
	[self addSubview:selectedLabel];
	
	normalIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
	selectedIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
    highlightedIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
	normalIcon.contentMode = UIViewContentModeScaleAspectFit;
	selectedIcon.contentMode = normalIcon.contentMode;
    highlightedIcon.contentMode = normalIcon.contentMode;
	
	label.lineBreakMode = NSLineBreakByClipping;
	selectedLabel.lineBreakMode = NSLineBreakByClipping;
	
	
	[self addSubview:normalIcon];
	[self addSubview:selectedIcon];
    [self addSubview:highlightedIcon];
	
	backgroundLayer = [SKInnerShadowLayer layer];
	[self.layer insertSublayer:backgroundLayer atIndex:0];
	//	backgroundLayer.delegate = self;
	
	borderLayer = [CAGradientLayer layer];
	[self.layer insertSublayer:borderLayer atIndex:0];
	//	borderLayer.delegate = self;
	
	
	
	gradients = [NSMutableDictionary new];
	borderGradients = [NSMutableDictionary new];
	
	borderWidths = [NSMutableDictionary new];
	cornerRadii = [NSMutableDictionary new];
	
	shadowRadii = [NSMutableDictionary new];
	shadowOffsets = [NSMutableDictionary new];
	shadowColors = [NSMutableDictionary new];
	shadowOpacities = [NSMutableDictionary new];
	
	innerShadowOffsets = [NSMutableDictionary new];
	innerShadowColors = [NSMutableDictionary new];
	innerShadowRadii = [NSMutableDictionary new];
	
	textColors = [NSMutableDictionary new];
	textShadowOffsets = [NSMutableDictionary new];
	textShadowColors = [NSMutableDictionary new];
	
	frames = [NSMutableDictionary new];
	texts = [NSMutableDictionary new];
	icons = [NSMutableDictionary new];
	
	self.textAlignment = NSTextAlignmentCenter;
	[self setFont:[UIFont boldSystemFontOfSize:15.0f]];
	[self setCornerRadius:3.0f forControlState:UIControlStateNormal];
}


#pragma mark - layout

- (void) layoutSubviews {
	[super layoutSubviews];
	NSInteger horizontalPadding = 7;
	NSInteger verticalPadding = 6;

    NSString *text = [self textForControlState:self.state];
    UIFont *font = self.state == UIControlStateNormal ? label.font : selectedLabel.font;
    CGSize textSize = [self sizeOfText:text font:font];

	NSInteger imageSize = 0;
	if (normalIcon.image != nil) {
		imageSize = MAX(normalIcon.image.size.height, normalIcon.image.size.width);
		NSInteger padding = (self.frame.size.height - imageSize)/2;
        horizontalPadding = MAX(5, padding);
		verticalPadding = padding;

        CGFloat iconX = 0;
        CGFloat iconY = verticalPadding;

        switch (iconPlacement) {
            case FTWButtonIconPlacementTight:
                switch (iconAlignment) {
                    case FTWButtonIconAlignmentLeft:
                        if (textSize.width > 0) {
                            iconX = CGRectGetMidX(self.bounds) - textSize.width/2.0 - horizontalPadding - imageSize;
                        } else {
                            iconX = CGRectGetMidX(self.bounds) - imageSize/2.0;
                        }
                        break;
                    case FTWButtonIconAlignmentRight:
                        if (textSize.width > 0) {
                            iconX = CGRectGetMidX(self.bounds) + textSize.width/2.0 + horizontalPadding;
                        } else {
                            iconX = CGRectGetMidX(self.bounds) - imageSize/2.0;
                        }
                        break;
                }
                break;

            case FTWButtonIconPlacementEdge:
                switch (iconAlignment) {
                    case FTWButtonIconAlignmentLeft:
                        iconX = horizontalPadding;
                        break;
                    case FTWButtonIconAlignmentRight:
                        iconX = CGRectGetWidth(self.bounds) - imageSize - horizontalPadding;
                        break;
                }
                break;
        }

		normalIcon.layer.frame = CGRectMake(iconX, iconY, imageSize, imageSize);
		selectedIcon.layer.frame = normalIcon.layer.frame;
        highlightedIcon.layer.frame = normalIcon.layer.frame;
		imageSize += horizontalPadding;
	}

    CGRect labelRect = self.bounds;

    if (normalIcon != nil && textAlignment != NSTextAlignmentCenter) {
      labelRect = CGRectMake(horizontalPadding + imageSize, verticalPadding, self.frame.size.width - horizontalPadding*2 - imageSize, self.frame.size.height - verticalPadding*2);
    }

    label.frame = selectedLabel.frame = labelRect;
}

- (CGSize)sizeOfText:(NSString *)text font:(UIFont *)font {
    CGSize textSize = CGSizeZero;
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_7_0
    if (font) {
        textSize = [text sizeWithAttributes:@{ NSFontAttributeName: font }];
    }
#else
    textSize = [text sizeWithFont:font];
#endif
    return [self integralSize:textSize];
}

- (CGSize)integralSize:(CGSize)size {
    CGRect rect = { CGPointZero, size };
    rect = CGRectIntegral(rect);
    return rect.size;
}

- (void) setFrame:(CGRect)aFrame {
	[self setFrame:aFrame forControlState:UIControlStateNormal];
	[self configureViewForControlState:[self currentControlState]];
}

- (void) setFrameInternal:(CGRect)aFrame {
	[super setFrame:aFrame];
	
}

- (void) setTextAlignment:(NSTextAlignment)newTextAlignment {
    textAlignment = newTextAlignment;
	label.textAlignment = newTextAlignment;
	selectedLabel.textAlignment = newTextAlignment;
    [self setNeedsLayout];
}

- (NSTextAlignment) textAlignment {
	return label.textAlignment;
}

- (void) setFont:(UIFont *)font {
	label.font = font;
	selectedLabel.font = font;
}

- (UIFont*) font {
	return label.font;
}


- (void) setSelected:(BOOL)selected {
	if (selected != self.selected) {
		super.selected = selected;
		[self setSelected:selected animated:YES];
	}
}


- (void) setHighlighted:(BOOL)highlighted {
	if (highlighted != self.highlighted) {
		super.highlighted = highlighted;
		[self setHighlighted:highlighted animated:YES];
	}
}

- (void) setEnabled:(BOOL)newEnabled {
	[super setEnabled:newEnabled];
	[self configureViewForControlState:[self currentControlState]];
}

- (void) setSelected:(BOOL)newSelected animated:(BOOL)animated {
	UIControlState controlState = [self currentControlState];
	if (animated) {
		NSTimeInterval duration = 0.2;
		
		[CATransaction begin];
		[CATransaction setAnimationDuration:duration];
		[CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut] ];
		[self configureLayerPropertiesForControlState:controlState];
		[CATransaction commit];
		
		[UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationCurveEaseInOut animations:^{
			[self configureViewPropertiesForControlState:controlState];
		} completion:^(BOOL finished) { }];
	} else {
		[self configureViewForControlState:controlState];
	}
}

- (void) setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
	UIControlState controlState = [self currentControlState];
	if (animated) {
		CGFloat duration = 0.18f;
		
		[CATransaction begin];
		[CATransaction setAnimationDuration:duration];
		[CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut] ];
		[self configureLayerPropertiesForControlState:controlState];
		[CATransaction commit];
		
		[UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationCurveEaseInOut animations:^{
			[self configureViewPropertiesForControlState:controlState];
		} completion:^(BOOL finished) { }];
	} else {
		[self configureViewForControlState:controlState];
	}
}


- (void) configureViewForControlState:(UIControlState)controlState {
	[self configureLayerPropertiesForControlState:controlState];
	[self configureViewPropertiesForControlState:controlState];
}

- (void) configureLayerPropertiesForControlState:(UIControlState)controlState {
	//rename layers to ease readability
	SKInnerShadowLayer *innerShadowLayer = backgroundLayer;
	CALayer *dropShadowLayer = self.layer;
	
	
	//set background colors and gradients
	backgroundLayer.colors =  [self colorsForControlState:controlState];
	//	backgroundLayer.backgroundColor = [self backgroundColorForControlState:controlState].CGColor;
	
	//set border widths, colors, and gradients
	if ([self borderWidthForControlState:controlState] > 0) {
		if ([self borderColorsForControlState:controlState]) {
			borderLayer.colors = [self borderColorsForControlState:controlState];
			borderLayer.backgroundColor = [UIColor clearColor].CGColor;
		} else {
			if ([self borderColorsForControlState:controlState]) {
				borderLayer.colors = [self borderColorsForControlState:controlState];
			} else {
				borderLayer.colors = [self colorsForControlState:controlState];
			}
		}
	}
	
	//set corner radii appropriately
	CGFloat cornerRadiusForControlState = [self cornerRadiusForControlState:[self currentControlState]];
	backgroundLayer.cornerRadius = cornerRadiusForControlState - [self borderWidthForControlState:[self currentControlState]];
	backgroundLayer.cornerRadius = MAX(0, backgroundLayer.cornerRadius);
	borderLayer.cornerRadius = cornerRadiusForControlState;
	
	//add drop shadow
	if ([self shadowColorForControlState:controlState]) {
		dropShadowLayer.shadowColor = [self shadowColorForControlState:controlState].CGColor;
		if ([self shadowOpacityForControlState:controlState]) {
			dropShadowLayer.shadowOpacity = [self shadowOpacityForControlState:controlState];
		} else {
			dropShadowLayer.shadowOpacity = 0.0f;
		}
	}
	dropShadowLayer.shadowOffset = [self shadowOffsetForControlState:controlState];
	dropShadowLayer.shadowRadius = [self shadowRadiusForControlState:controlState];
	
	
	//add inner shadow
	if ([self innerShadowColorForControlState:controlState]) {
		innerShadowLayer.innerShadowColor = [self innerShadowColorForControlState:controlState].CGColor;
		innerShadowLayer.innerShadowOpacity = 1.0f;
	}
	innerShadowLayer.innerShadowOffset = [self innerShadowOffsetForControlState:controlState];
	innerShadowLayer.innerShadowRadius = [self innerShadowRadiusForControlState:controlState];
	
	CGFloat borderWidth = [self borderWidthForControlState:controlState];
	CGRect rectForState = [self frameForControlState:controlState];
	borderLayer.frame = CGRectMake(0, 0, CGRectGetWidth(rectForState), CGRectGetHeight(rectForState));
	backgroundLayer.frame = CGRectMake(
								0 + borderWidth,
								0 + borderWidth,
								CGRectGetWidth(rectForState) - borderWidth*2,
								CGRectGetHeight(rectForState) - borderWidth*2
								);
	
	
}

- (void) configureViewPropertiesForControlState:(UIControlState)controlState {
	[self setFrameInternal:[self frameForControlState:controlState]];
	[self layoutSubviews];
	
	//set text shadow
	UILabel *labelForControlState = label;
	if (controlState & UIControlStateSelected) {
		labelForControlState = selectedLabel;
	}
	labelForControlState.shadowColor = [self textShadowColorForControlState:controlState];
	labelForControlState.shadowOffset = [self textShadowOffsetForControlState:controlState];
	if ([self textColorForControlState:controlState]) {
		labelForControlState.textColor = [self textColorForControlState:controlState];
	}
	
	CGFloat alpha = 1.0f;
    CGFloat alphaHighlight = 0.0f;
	
	//show the selected icon and label, if necessary
	if (self.selected) {
		alpha = 0.0f;
	}
    if (self.highlighted) {
        alphaHighlight = 1.0f;
    }
	label.alpha = alpha;
	normalIcon.alpha = alpha - alphaHighlight;
	selectedIcon.alpha = 1.0f - alpha;
	selectedLabel.alpha = 1.0f - alpha;
    highlightedIcon.alpha = alphaHighlight;
}


- (UIControlState) currentControlState {
	UIControlState controlState = UIControlStateNormal;
	if (self.selected) {
		controlState += UIControlStateSelected;
	}
	if (self.highlighted) {
		controlState += UIControlStateHighlighted;
	}
	if (!self.enabled) {
		controlState += UIControlStateDisabled;
	}
	return controlState;
}



#pragma mark - default setter and getter

- (void) setValue:(id)value inDictionary:(NSMutableDictionary*)dictionary forControlState:(UIControlState)controlState {
	if (value) {
		[dictionary setValue:value forKey:[NSString stringWithFormat:@"%lu", (unsigned long)controlState]];
	} else {
		[dictionary removeObjectForKey:[NSString stringWithFormat:@"%lu", (unsigned long)controlState]];
	}
	[self configureViewForControlState:[self currentControlState]];
}

- (id) getValueFromDictionary:(NSMutableDictionary*)dictionary forControlState:(UIControlState)controlState {
	if ([dictionary valueForKey:[NSString stringWithFormat:@"%lu", (unsigned long)controlState]]) {
		return [dictionary valueForKey:[NSString stringWithFormat:@"%lu", (unsigned long)controlState]];
	}
	
	
	if ((controlState & UIControlStateSelected) && [dictionary valueForKey:[NSString stringWithFormat:@"%lu", (unsigned long)UIControlStateSelected]]) {
		return [dictionary valueForKey:[NSString stringWithFormat:@"%lu", (unsigned long)UIControlStateSelected]];
	} else if ((controlState & UIControlStateHighlighted) && [dictionary valueForKey:[NSString stringWithFormat:@"%lu", (unsigned long)UIControlStateHighlighted]]) {
		return [dictionary valueForKey:[NSString stringWithFormat:@"%lu", (unsigned long)UIControlStateHighlighted]];
	} else {
		return [dictionary valueForKey:[NSString stringWithFormat:@"%lu", (unsigned long)UIControlStateNormal]];
	}
}




#pragma mark -  setters and getters

- (void) setTextColor:(UIColor *)newTextColor forControlState:(UIControlState)controlState {
	if (controlState == UIControlStateNormal) {
		label.textColor = newTextColor;
	}
	if (controlState & UIControlStateSelected) {
		selectedLabel.textColor = newTextColor;
	}
	[textColors setValue:newTextColor forKey:[NSString stringWithFormat:@"%lu", (unsigned long)controlState]];
	[self setValue:newTextColor inDictionary:textColors forControlState:controlState];
}

- (UIColor*) textColorForControlState:(UIControlState)controlState {
	return [self getValueFromDictionary:textColors forControlState:controlState];
}

- (void) setBorderWidth:(CGFloat)borderWidth forControlState:(UIControlState)controlState {
	[self setValue:[NSNumber numberWithFloat:borderWidth] inDictionary:borderWidths forControlState:controlState];
}

- (CGFloat) borderWidthForControlState:(UIControlState)controlState {
	return [[self getValueFromDictionary:borderWidths forControlState:controlState] floatValue];
}

- (void) setCornerRadius:(CGFloat)cornerRadius forControlState:(UIControlState)controlState {
	[self setValue:[NSNumber numberWithFloat:cornerRadius] inDictionary:cornerRadii forControlState:controlState];
}

- (CGFloat) cornerRadiusForControlState:(UIControlState)controlState {
	return [[self getValueFromDictionary:cornerRadii forControlState:controlState] floatValue];
}


- (void) setTextShadowColor:(UIColor *)newTextShadowColor forControlState:(UIControlState)controlState {
	if (controlState == UIControlStateNormal) {
		label.shadowColor = newTextShadowColor;
	}
	if (controlState & UIControlStateSelected) {
		selectedLabel.shadowColor = newTextShadowColor;
	}
	if (controlState & UIControlStateDisabled && [self currentControlState] & UIControlStateDisabled) {
		label.shadowColor = newTextShadowColor; //this isn't ideal
	}
	[self setValue:newTextShadowColor inDictionary:textShadowColors forControlState:controlState];
}

- (UIColor*) textShadowColorForControlState:(UIControlState)controlState {
	return [self getValueFromDictionary:textShadowColors forControlState:controlState];
}



- (void) setTextShadowOffset:(CGSize)textShadowOffset forControlState:(UIControlState)controlState {
	if (controlState == UIControlStateNormal) {
		label.shadowOffset = textShadowOffset;
	}
	if (controlState & UIControlStateSelected) {
		selectedLabel.shadowOffset = textShadowOffset;
	}
	[self setValue:[NSValue valueWithCGSize:textShadowOffset] inDictionary:textShadowOffsets forControlState:controlState];
}

- (CGSize) textShadowOffsetForControlState:(UIControlState)controlState {
	return [[self getValueFromDictionary:textShadowOffsets forControlState:controlState] CGSizeValue];
}


- (void) setText:(NSString*)text forControlState:(UIControlState)controlState {
	if (controlState == UIControlStateNormal) {
		if (selectedLabel.text == nil || selectedLabel.text.length == 0 || [selectedLabel.text isEqualToString:label.text]) {
			selectedLabel.text = text;
		}
		label.text = text;
	}
	if (controlState & UIControlStateSelected) {
		selectedLabel.text = text;
	}
	[self setValue:text inDictionary:texts forControlState:controlState];
}

- (NSString*) textForControlState:(UIControlState)controlState {
	return [self getValueFromDictionary:texts forControlState:controlState];
}

- (void) setFrame:(CGRect)frame forControlState:(UIControlState)controlState {
	if (frames.allKeys.count == 0) {
		[self setFrameInternal:frame];
	}
	[self setValue:[NSValue valueWithCGRect:frame] inDictionary:frames forControlState:controlState];
	[self configureViewForControlState:[self currentControlState]];
}

- (CGRect) frameForControlState:(UIControlState)controlState {
	return [[self getValueFromDictionary:frames forControlState:controlState] CGRectValue];
}


#pragma mark drop shadow

- (void) setShadowColor:(UIColor*)shadowColor forControlState:(UIControlState)controlState {
	[self setValue:shadowColor inDictionary:shadowColors forControlState:controlState];
}

- (UIColor*) shadowColorForControlState:(UIControlState)controlState {
	return [self getValueFromDictionary:shadowColors forControlState:controlState];
}

- (void) setShadowOffset:(CGSize)shadowOffset forControlState:(UIControlState)controlState {
	[self setValue:[NSValue valueWithCGSize:shadowOffset] inDictionary:shadowOffsets forControlState:controlState];
}

- (CGSize) shadowOffsetForControlState:(UIControlState)controlState {
	return [[self getValueFromDictionary:shadowOffsets forControlState:controlState] CGSizeValue];
}

- (void) setShadowRadius:(CGFloat)shadowRadius forControlState:(UIControlState)controlState {
	[self setValue:[NSNumber numberWithFloat:shadowRadius] inDictionary:shadowRadii forControlState:controlState];
}

- (CGFloat) shadowRadiusForControlState:(UIControlState)controlState {
	return [[self getValueFromDictionary:shadowRadii forControlState:controlState] floatValue];
}

- (void) setShadowOpacity:(CGFloat)shadowOpacity forControlState:(UIControlState)controlState {
	[self setValue:[NSNumber numberWithFloat:shadowOpacity] inDictionary:shadowOpacities forControlState:controlState];
}

- (CGFloat) shadowOpacityForControlState:(UIControlState)controlState {
	return [[self getValueFromDictionary:shadowOpacities forControlState:controlState] floatValue];
}


#pragma mark inner shadow

- (void) setInnerShadowColor:(UIColor*)shadowColor forControlState:(UIControlState)controlState {
	[self setValue:shadowColor inDictionary:innerShadowColors forControlState:controlState];
}

- (UIColor*) innerShadowColorForControlState:(UIControlState)controlState {
	return [self getValueFromDictionary:innerShadowColors forControlState:controlState];
}

- (void) setInnerShadowOffset:(CGSize)shadowOffset forControlState:(UIControlState)controlState {
	[self setValue:[NSValue valueWithCGSize:shadowOffset] inDictionary:innerShadowOffsets forControlState:controlState];
}

- (CGSize) innerShadowOffsetForControlState:(UIControlState)controlState {
	return [[self getValueFromDictionary:innerShadowOffsets forControlState:controlState] CGSizeValue];
}

- (void) setInnerShadowRadius:(CGFloat)shadowRadius forControlState:(UIControlState)controlState {
	[innerShadowRadii setValue:[NSNumber numberWithFloat:shadowRadius] forKey:[NSString stringWithFormat:@"%lu", (unsigned long)controlState]];
	[self setValue:[NSNumber numberWithFloat:shadowRadius] inDictionary:innerShadowRadii forControlState:controlState];
}

- (CGFloat) innerShadowRadiusForControlState:(UIControlState)controlState {
	return [[self getValueFromDictionary:innerShadowRadii forControlState:controlState] floatValue];
}

#pragma mark images

- (void) setIcon:(UIImage*)icon forControlState:(UIControlState)controlState {
	if (controlState == UIControlStateNormal) {
		normalIcon.image = icon;
	}
	if (controlState & UIControlStateSelected) {
		selectedIcon.image = icon;
	}
    if (controlState & UIControlStateHighlighted) {
		highlightedIcon.image = icon;
	}
	[self setValue:icons inDictionary:icons forControlState:controlState];
	[self setNeedsLayout];
}

- (UIImage*) iconForControlState:(UIControlState)controlState {
	return [self getValueFromDictionary:icons forControlState:controlState];
}


#pragma mark background colors

- (void) setBackgroundColor:(UIColor*)color forControlState:(UIControlState)controlState {
	[self setValue:@[ [color copy], [color copy] ] inDictionary:gradients forControlState:controlState];
}

- (void) setColors:(NSArray*)colors forControlState:(UIControlState)controlState {
	[self setValue:colors inDictionary:gradients forControlState:controlState];
}

- (NSArray*) colorsForControlState:(UIControlState)controlState {
	NSArray *colors = [self getValueFromDictionary:gradients forControlState:controlState];
	if (!colors) {
		return nil;
	}
	
	NSMutableArray *mutableColors = [NSMutableArray new];
	NSInteger numberOfColors = colors.count;
	for (NSInteger i = 0; i < numberOfColors; i++) {
		id color = [colors objectAtIndex:i];
		if ([color isKindOfClass:[UIColor class]]) {
			UIColor *theColor = (UIColor*) color;
			[mutableColors addObject:(id)theColor.CGColor];
		}
	}
	return [mutableColors copy];
}

- (void) setBorderColors:(NSArray*)borderColor forControlState:(UIControlState)controlState {
	[self setValue:borderColor inDictionary:borderGradients forControlState:controlState];
}

- (NSArray*) borderColorsForControlState:(UIControlState)controlState {
	NSArray *colors = [self getValueFromDictionary:borderGradients forControlState:controlState];
	if (!colors) {
		return nil;
	}
	NSMutableArray *mutableColors = [NSMutableArray new];
	NSInteger numberOfColors = colors.count;
	for (NSInteger i = 0; i < numberOfColors; i++) {
		id color = [colors objectAtIndex:i];
		if ([color isKindOfClass:[UIColor class]]) {
			UIColor *theColor = (UIColor*) color;
			[mutableColors addObject:(id)theColor.CGColor];
		}
	}
	return [mutableColors copy];
}


- (void) setBorderColor:(UIColor*)borderColor forControlState:(UIControlState)controlState {
	[self setValue:@[[borderColor copy], [borderColor copy]] inDictionary:borderGradients forControlState:controlState];
}

#pragma mark - built in styles

- (void) addDisabledStyleForState:(UIControlState)state {
	[self setColors:[NSArray arrayWithObjects:
				  [UIColor colorWithWhite:170.0f/255 alpha:1.0f],
				  [UIColor colorWithWhite:97.0f/255 alpha:1.0f],
				  nil] forControlState:state];
	
	[self setInnerShadowColor:[UIColor colorWithWhite:205.0f/255 alpha:1.0f] forControlState:state];
	[self setInnerShadowOffset:CGSizeMake(0, 1) forControlState:state];
	
	[self setTextColor:[UIColor colorWithWhite:181.0f/255 alpha:1.0f] forControlState:state];
	[self setTextShadowColor:[UIColor colorWithWhite:97.0f/255 alpha:1.0f] forControlState:state];
	[self setTextShadowOffset:CGSizeMake(0, -1) forControlState:state];
	
	[self setShadowColor:[UIColor blackColor] forControlState:state];
	[self setShadowOffset:CGSizeMake(0, 1) forControlState:state];
}

- (void) addDeleteStyleForState:(UIControlState)state {
	
	[self setInnerShadowColor:[UIColor colorWithRed:255.0f/255 green:96.0f/255 blue:53.0f/255 alpha:1.0f] forControlState:state];
	[self setInnerShadowOffset:CGSizeMake(0, 1) forControlState:state];
	
	[self setShadowColor:[UIColor colorWithRed:103.0f/255 green:12.0f/255 blue:5.0f/255 alpha:1.0f] forControlState:state];
	[self setShadowOffset:CGSizeMake(0, 1) forControlState:state];
	
	[self setColors:[NSArray arrayWithObjects:
				  [UIColor colorWithRed:255.0f/255 green:73.0f/255 blue:1.0f/255 alpha:1.0f],
				  [UIColor colorWithRed:254.0f/255 green:2.0f/255 blue:1.0f/255 alpha:1.0f],
				  nil] forControlState:state];
	
	[self setTextColor:[UIColor colorWithWhite:1.0f alpha:1.0f] forControlState:state];
	[self setTextShadowColor:[UIColor colorWithRed:115.0f/255 green:4.0f/255 blue:0 alpha:1.0f] forControlState:state];
	[self setTextShadowOffset:CGSizeMake(0, -1) forControlState:state];
	
	
	if (state == UIControlStateSelected || state == UIControlStateNormal) {
		UIControlState highlightedState = state | UIControlStateHighlighted;
		[self setInnerShadowColor:[UIColor colorWithRed:202.0f/255 green:67.0f/255 blue:30.0f/255 alpha:1.0f] forControlState:highlightedState];
		
		[self setColors:[NSArray arrayWithObjects:
					  [UIColor colorWithRed:194.0f/255 green:38.0f/255 blue:0.0f/255 alpha:1.0f],
					  [UIColor colorWithRed:166.0f/255 green:16.0f/255 blue:0.0f/255 alpha:1.0f],
					  nil] forControlState:highlightedState];
	}
}

- (void) addGrayStyleForState:(UIControlState)state {
	
	[self setColors:[NSArray arrayWithObjects:
				  [UIColor colorWithWhite:170.0f/255 alpha:1.0f],
				  [UIColor colorWithWhite:98.0f/255 alpha:1.0f],
				  nil] forControlState:state];
	
	[self setInnerShadowColor:[UIColor colorWithWhite:230.0f/255 alpha:1.0f] forControlState:state];
	[self setInnerShadowOffset:CGSizeMake(0, 1) forControlState:state];
	
	[self setShadowColor:[UIColor blackColor] forControlState:state];
	[self setShadowOffset:CGSizeMake(0, 1) forControlState:state];
	
	
	[self setTextColor:[UIColor colorWithWhite:1.0f alpha:1.0f] forControlState:state];
	[self setTextShadowColor:[UIColor colorWithWhite:78.0f/255 alpha:1.0f] forControlState:state];
	[self setTextShadowOffset:CGSizeMake(0, -1) forControlState:state];
	
	
	if (state == UIControlStateSelected || state == UIControlStateNormal) {
		UIControlState highlightedState = state | UIControlStateHighlighted;
		[self setInnerShadowColor:[UIColor colorWithWhite:150.0f/255 alpha:1.0f] forControlState:highlightedState];
		[self setColors:[NSArray arrayWithObjects:
					  [UIColor colorWithWhite:121.0f/255 alpha:1.0f],
					  [UIColor colorWithWhite:90.0f/255 alpha:1.0f],
					  nil] forControlState:highlightedState];
	}
}

- (void) addBlackStyleForState:(UIControlState)state {
	
	[self setColors:[NSArray arrayWithObjects:
				  [UIColor colorWithWhite:95.0f/255 alpha:1.0f],
				  [UIColor colorWithWhite:48.0f/255 alpha:1.0f],
				  nil] forControlState:state];
	
	[self setInnerShadowColor:[UIColor colorWithWhite:140.0f/255 alpha:1.0f] forControlState:state];
	[self setInnerShadowOffset:CGSizeMake(0, 1) forControlState:state];
	
	[self setShadowColor:[UIColor blackColor] forControlState:state];
	[self setShadowOffset:CGSizeMake(0, 1) forControlState:state];
	
	
	[self setTextColor:[UIColor colorWithWhite:1.0f alpha:1.0f] forControlState:state];
	[self setTextShadowColor:[UIColor colorWithWhite:40.0f/255 alpha:1.0f] forControlState:state];
	[self setTextShadowOffset:CGSizeMake(0, -1) forControlState:state];
	
	
	if (state == UIControlStateSelected || state == UIControlStateNormal) {
		UIControlState highlightedState = state | UIControlStateHighlighted;
		[self setInnerShadowColor:[UIColor colorWithWhite:150.0f/255 alpha:1.0f] forControlState:highlightedState];
		[self setColors:[NSArray arrayWithObjects:
					  [UIColor colorWithWhite:121.0f/255 alpha:1.0f],
					  [UIColor colorWithWhite:90.0f/255 alpha:1.0f],
					  nil] forControlState:highlightedState];
	}
}

- (void) addLightBlueStyleForState:(UIControlState)state {
	[self setColors:[NSArray arrayWithObjects:
				  [UIColor colorWithRed:0.0f/255 green:196.0f/255 blue:255.0f/255 alpha:1.0f],
				  [UIColor colorWithRed:0.0f/255 green:103.0f/255 blue:255.0f/255 alpha:1.0f],
				  nil] forControlState:state];
	
	[self setTextShadowColor:[UIColor colorWithRed:0.0f/255 green:130.0f/255 blue:208.0f/255 alpha:1.0f] forControlState:state];
	[self setTextShadowOffset:CGSizeMake(0, -1) forControlState:state];
	
	[self setShadowColor:[UIColor blackColor] forControlState:state];
	[self setShadowOffset:CGSizeMake(0, 1) forControlState:state];
	
	[self setInnerShadowColor:[UIColor colorWithRed:124.0f/255 green:225.0f/255 blue:255.0f/255 alpha:1.0f] forControlState:state];
	[self setInnerShadowOffset:CGSizeMake(0, 1) forControlState:state];
	
	[self setTextColor:[UIColor whiteColor] forControlState:state];
	[self setTextShadowColor:[UIColor colorWithRed:0.0f/255 green:130.0f/255 blue:208.0f/255 alpha:1.0f] forControlState:state];
}

- (void) addYellowStyleForState:(UIControlState)state {
	[self setColors:[NSArray arrayWithObjects:
				  [UIColor colorWithRed:255.0f/255 green:203.0f/255 blue:0.0f/255 alpha:1.0f],
				  [UIColor colorWithRed:251.0f/255 green:154.0f/255 blue:0.0f/255 alpha:1.0f],
				  nil] forControlState:state];
	
	
	[self setInnerShadowColor:[UIColor colorWithRed:255.0f/255 green:215.0f/255 blue:94.0f/255 alpha:1.0f] forControlState:state];
	[self setInnerShadowOffset:CGSizeMake(0, 1) forControlState:state];
	
	[self setShadowColor:[UIColor blackColor] forControlState:state];
	[self setShadowOffset:CGSizeMake(0, 1) forControlState:state];
	
	[self setTextColor:[UIColor colorWithWhite:1.0f alpha:1.0f] forControlState:state];
	[self setTextShadowColor:[UIColor colorWithRed:173.0f/255 green:120.0f/255 blue:0.0f/255 alpha:1.0f] forControlState:state];
	[self setTextShadowOffset:CGSizeMake(0, -1) forControlState:state];
	
	if (state == UIControlStateSelected || state == UIControlStateNormal) {
		UIControlState highlightedState = state | UIControlStateHighlighted;
		
		[self setColors:[NSArray arrayWithObjects:
					  [UIColor colorWithRed:233.0f/255 green:169.0f/255 blue:0.0f/255 alpha:1.0f],
					  [UIColor colorWithRed:223.0f/255 green:121.0f/255 blue:0.0f/255 alpha:1.0f],
					  nil] forControlState:highlightedState];
		
		[self setInnerShadowColor:[UIColor colorWithRed:255.0f/255 green:197.0f/255 blue:85.0f/255 alpha:1.0f] forControlState:highlightedState];
		
	}
}

- (void) addBlueStyleForState:(UIControlState)state {
	[self setColors:[NSArray arrayWithObjects:
				  [UIColor colorWithRed:2.0f/255 green:184.0f/255 blue:255.0f/255 alpha:1.0f],
				  [UIColor colorWithRed:0.0f/255 green:68.0f/255 blue:255.0f/255 alpha:1.0f],
				  nil] forControlState:state];
	
	
	[self setInnerShadowColor:[UIColor colorWithRed:108.0f/255 green:221.0f/255 blue:253.0f/255 alpha:1.0f] forControlState:state];
	[self setInnerShadowOffset:CGSizeMake(0, 1) forControlState:state];
	
	[self setShadowColor:[UIColor blackColor] forControlState:state];
	[self setShadowOffset:CGSizeMake(0, 1) forControlState:state];
	
	[self setTextColor:[UIColor colorWithWhite:1.0f alpha:1.0f] forControlState:state];
	[self setTextShadowColor:[UIColor colorWithWhite:78.0f/255 alpha:1.0f] forControlState:state];
	[self setTextShadowOffset:CGSizeMake(0, -1) forControlState:state];
	
	if (state == UIControlStateSelected || state == UIControlStateNormal) {
		UIControlState highlightedState = state | UIControlStateHighlighted;
		
		[self setColors:[NSArray arrayWithObjects:
					  [UIColor colorWithRed:1.0f/255 green:150.0f/255 blue:207.0f/255 alpha:1.0f],
					  [UIColor colorWithRed:0.0f/255 green:51.0f/255 blue:191.0f/255 alpha:1.0f],
					  nil] forControlState:highlightedState];
		[self setInnerShadowColor:[UIColor colorWithRed:86.0f/255 green:174.0f/255 blue:199.0f/255 alpha:1.0f] forControlState:highlightedState];
	}
}



@end
