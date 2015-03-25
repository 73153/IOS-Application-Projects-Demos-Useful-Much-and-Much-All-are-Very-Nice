//
//  LBAppDelegate.h
//  LBReadingTime
//
//  Created by Luca Bernardi on 12/03/13.
//  Copyright (c) 2013 Luca Bernardi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LBViewController;

@interface LBAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) LBViewController *viewController;

@end
