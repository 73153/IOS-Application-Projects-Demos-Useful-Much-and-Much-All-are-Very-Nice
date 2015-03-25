//
//  FTWAppDelegate.m
//  FTWButton
//
//  Created by Soroush Khanlou on 10/12/12.
//  Copyright (c) 2012 FTW. All rights reserved.
//

#import "FTWAppDelegate.h"

#import "FTWViewController.h"

@implementation FTWAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
	self.viewController = [[FTWViewController alloc] initWithNibName:@"FTWViewController" bundle:nil];
	self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}


@end
