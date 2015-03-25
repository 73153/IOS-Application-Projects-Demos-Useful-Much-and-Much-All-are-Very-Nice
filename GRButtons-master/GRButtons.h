//
//  GRButtons.h
//  MTStrategy
//
//  Created by Göncz Róbert on 11/28/12.
//  Copyright (c) 2012 Göncz Róbert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuartzCore/QuartzCore.h"

typedef enum {
    GRStyleIn,
    GRStyleOut,
    GRStyleNormal,
} GRButtonStyle;

typedef enum {
    GRTypeFacebook,
    GRTypeFacebookRect,
    GRTypeFacebookCircle,
    
    GRTypeTwitter,
    GRTypeTwitterRect,
    GRTypeTwitterCircle,
    
    GRTypeGooglePlus,
    GRTypeGooglePlusRect,
    GRTypeGooglePlusCircle,
    
    GRTypePinterest,
    GRTypePinterestRect,
    GRTypePinterestCircle,
    
    GRTypeDribble,
    GRTypeDribbleRect,
    GRTypeDribbleCircle,
    
    GRTypeFlickr,
    GRTypeFlickrRect,
    GRTypeFlickrCircle,
    
    GRTypeMail,
    GRTypeMailRect,
    GRTypeMailCircle,
    
} GRButtonType;

// Example:
//
// UIButton *button = GRButton(GRTypeMailRect, 10, 160, 32, self, @selector(action:), color, GRStyleIn);
//

UIButton *GRButton(GRButtonType type, int xPosition, int yPosition, CGFloat size, id target, SEL selector, UIColor *normalBgColor, GRButtonStyle normalStyle);

















