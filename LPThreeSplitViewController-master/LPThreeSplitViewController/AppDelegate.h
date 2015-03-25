//
//  AppDelegate.h
//  LPThreeSplitViewController
//
//  Created by Luka Penger on 4/21/13.
//  Copyright (c) 2013 LukaPenger. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LPThreeSplitViewController.h"
#import "ListViewController.h"
#import "MenuViewController.h"
#import "DetailViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LPThreeSplitViewController *threeSplitViewController;

@end
