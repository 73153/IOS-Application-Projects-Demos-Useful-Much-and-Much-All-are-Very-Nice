//
//  AppDelegate.m
//  AKTabBar Example
//
//  Created by Ali KARAGOZ on 03/05/12.
//  Copyright (c) 2012 Ali Karagoz. All rights reserved.
//

#import "AppDelegate.h"
#import "AKTabBarController.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // If the device is an iPad, we make it taller.
    _tabBarController = [[AKTabBarController alloc] initWithTabBarHeight:(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 70 : 50];
    
    // Comment out the line above and uncomment the line below to show the tab bar at the top of the UI.
    /*
    _tabBarController = [[AKTabBarController alloc] initWithTabBarHeight:(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 70 : 50 position:AKTabBarPositionBottom];
     */
    
    [_tabBarController setMinimumHeightToDisplayTitle:40.0];
    
    // If needed, disable the resizing when switching display orientations.
    /*
    [_tabBarController setTabBarHasFixedHeight:YES];
     */

    FirstViewController *tableViewController = [[FirstViewController alloc] initWithStyle:UITableViewStylePlain];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tableViewController];
    navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    
    [_tabBarController setViewControllers:[NSMutableArray arrayWithObjects:
                                               navigationController,
                                               [[SecondViewController alloc] init],
                                               [[ThirdViewController alloc] init],
                                               [[FourthViewController alloc] init],nil]];
    
    // Below you will find an example of the possible customizations, just uncomment the lines below
    
    // Tab background Image
    [_tabBarController setBackgroundImageName:@"noise-dark-gray.png"];
    [_tabBarController setSelectedBackgroundImageName:@"noise-dark-blue.png"];
    
    /*
    // If needed, set cap insets for the background image
    [_tabBarController setBackgroundImageCapInsets:UIEdgeInsetsMake(4, 4, 4, 4)];

    // Tabs top embos Color
    [_tabBarController setTabEdgeColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.8]];
         
    // Tabs Colors settings
    [_tabBarController setTabColors:@[[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.0],
                                          [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0]]]; // MAX 2 Colors
    
    [_tabBarController setSelectedTabColors:@[[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1.0],
                                                  [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0]]]; // MAX 2 Colors

    // Tab Stroke Color
    [_tabBarController setTabStrokeColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];

    // Icons Color settings
    [_tabBarController setIconColors:@[[UIColor colorWithRed:174.0/255.0 green:174.0/255.0 blue:174.0/255.0 alpha:1],
                                           [UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1]]]; // MAX 2 Colors
    
    // Icon Shadow
    [_tabBarController setIconShadowColor:[UIColor blackColor]];
    [_tabBarController setIconShadowOffset:CGSizeMake(0, 1)];
    
    [_tabBarController setSelectedIconColors:@[[UIColor colorWithRed:174.0/255.0 green:174.0/255.0 blue:174.0/255.0 alpha:1],
                                                   [UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1]]]; // MAX 2 Colors
    
    [_tabBarController setSelectedIconOuterGlowColor:[UIColor darkGrayColor]];
    
    // Text Color
    [_tabBarController setTextColor:[UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:1.0]];
    [_tabBarController setSelectedTextColor:[UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0]];

    // Text font
    [_tabBarController setTextFont:[UIFont fontWithName:@"Chalkduster" size:14]];
    
    // Hide / Show glossy on tab icons
    [_tabBarController setIconGlossyIsHidden:YES];

    // Enable / Disable pre-rendered image mode
    [_tabBarController setTabIconPreRendered:NO];
    */

    // Uncomment the following lines to completely remove the border from all elements.
    /*
    [_tabBarController setTabEdgeColor:[UIColor clearColor]];
    [_tabBarController setTabInnerStrokeColor:[UIColor clearColor]];
    [_tabBarController setTabStrokeColor:[UIColor clearColor]];
    [_tabBarController setTopEdgeColor:[UIColor clearColor]];
     */

    // Uncomment the following to display centered image in the center of the tabbar, similar to Instagram.
    /*
    UIImage *img = [UIImage imageNamed:@"sample-center-image"];
    UIImageView *bottomCenterView = [[UIImageView alloc] initWithImage:img];
    CGRect rect = _tabBarController.view.frame;
    bottomCenterView.frame = CGRectMake(rect.size.width/2 - img.size.width/2, rect.size.height - img.size.height,
                                        img.size.width, img.size.height);
    [_tabBarController.view addSubview:bottomCenterView];
     */
  
    /*
    // Background gradient and fill noise pattern
    [_tabBarController setIsGradient:NO];
    [_tabBarController setIsFillBackgroundNoisePattern:NO];
     */
    [_window setRootViewController:_tabBarController];
    [_window makeKeyAndVisible];
    return YES;
}

@end
