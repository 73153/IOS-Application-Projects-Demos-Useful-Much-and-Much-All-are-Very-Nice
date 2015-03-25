//
//  QuadCurveMenuItemEventDelegate.h
//  AwesomeMenu
//
//  Created by Franklin Webber on 4/2/12.
//  Copyright (c) 2012 Franklin Webber. All rights reserved.
//

#import "QuadCurveMenuItem.h"

@class QuadCurveMenuItem;

@protocol QuadCurveMenuItemEventDelegate <NSObject>

@optional

- (void)quadCurveMenuItemLongPressed:(QuadCurveMenuItem *)item;
- (void)quadCurveMenuItemTapped:(QuadCurveMenuItem *)item;

@end