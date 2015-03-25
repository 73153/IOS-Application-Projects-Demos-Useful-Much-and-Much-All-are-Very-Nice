//
//  AppDelegate.m
//  Dialysis_New
//
//  Created by Amit Parmar on 27/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "EditPersonalInfoViewController.h"
#import "FirstViewController.h"
#import "MedicineViewController.h"
#import "GraphViewController.h"
#import "AppConstant.h"
#import "InformationViewController.h"

@implementation AppDelegate
@synthesize databaseName;
@synthesize databasePath;

@synthesize tabBarController;
@synthesize firstViewController;
@synthesize graphViewController;
@synthesize editViewController;
@synthesize medicineViewController;

-(void) createAndCheckDatabase{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    success = [fileManager fileExistsAtPath:databasePath];
    if(success) return;
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.databaseName];
    [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
}

-(void)addTabbarController{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.editViewController = [[EditPersonalInfoViewController alloc] initWithNibName:@"EditPersonalInfoViewController_iPhone" bundle:nil];
        self.firstViewController = [[FirstViewController alloc] initWithNibName:@"FirstViewController_iPhone" bundle:nil];
        self.medicineViewController = [[MedicineViewController alloc] initWithNibName:@"MedicineViewController_iPhone" bundle:nil];
        self.graphViewController = [[GraphViewController alloc] initWithNibName:@"GraphViewController_iPhone" bundle:nil];
    }
    else{
        self.editViewController = [[EditPersonalInfoViewController alloc] initWithNibName:@"EditPersonalInfoViewController_iPad" bundle:nil];
        self.firstViewController = [[FirstViewController alloc] initWithNibName:@"FirstViewController_iPad" bundle:nil];
        self.medicineViewController = [[MedicineViewController alloc] initWithNibName:@"MedicineViewController_iPad" bundle:nil];
        self.graphViewController = [[GraphViewController alloc] initWithNibName:@"GraphViewController_iPad" bundle:nil];
    }
    
    
    UINavigationController *navController1 = [[UINavigationController alloc] initWithRootViewController:self.editViewController];
    [navController1 setNavigationBarHidden:YES animated:NO];
    
    UINavigationController *navController2 = [[UINavigationController alloc] initWithRootViewController:self.firstViewController];
    [navController2 setNavigationBarHidden:YES animated:NO];
    
    UINavigationController *navController3 = [[UINavigationController alloc] initWithRootViewController:self.medicineViewController];
    [navController3 setNavigationBarHidden:YES animated:NO];
    
    UINavigationController *navController4 = [[UINavigationController alloc] initWithRootViewController:self.graphViewController];
    [navController4 setNavigationBarHidden:YES animated:NO];
    
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:navController1,navController2,navController3,navController4, nil];
    self.tabBarController.selectedIndex = 1;
    self.tabBarController.view.autoresizesSubviews = YES;
    self.tabBarController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    if([[[UIDevice currentDevice] systemVersion] intValue] >= 7){
        [self.tabBarController.tabBar setBarTintColor:[UIColor colorWithRed:0.4863 green:0.0000 blue:0.0196 alpha:1.0]];
    }
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:kIsSelected]){
        [self addTabbarController];
        self.window.rootViewController = self.tabBarController;
    }
    else{
        InformationViewController *informationViewController;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            informationViewController = [[InformationViewController alloc] initWithNibName:@"InformationViewController_iPhone" bundle:nil];
        }
        else{
            informationViewController = [[InformationViewController alloc] initWithNibName:@"InformationViewController_iPad" bundle:nil];
        }
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:informationViewController];
        [navController setNavigationBarHidden:YES animated:YES];
        self.window.rootViewController = navController;
    }
    
    
    [self.window makeKeyAndVisible];
    
     self.databaseName = @"Dialysis.sqlite";
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [documentPaths objectAtIndex:0];
    self.databasePath = [documentDir stringByAppendingPathComponent:self.databaseName];
    
    [self createAndCheckDatabase];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
