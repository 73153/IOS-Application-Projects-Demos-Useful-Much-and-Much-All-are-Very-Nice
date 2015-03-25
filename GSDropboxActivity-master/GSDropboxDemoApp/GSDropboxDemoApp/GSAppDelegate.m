//
//  GSAppDelegate.m
//  GSDropboxDemoApp
//
//  Created by Simon Whitaker on 25/11/2012.
//  Copyright (c) 2012 Goo Software Ltd. All rights reserved.
//

#import "GSAppDelegate.h"
#import "GSViewController.h"
#import <DropboxSDK/DropboxSDK.h>

@implementation GSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#warning Potentially incomplete method implementation. Fill in your Dropbox credentials!
#warning NB: you must also update the URL scheme listed under the CFBundleURLTypes key in GSDropboxDemoApp-Info.plist
    NSString *dropboxAppKey = @"DROPBOX API KEY";
    NSString *dropboxAppSecret = @"DROPBOX APP SECRET";
    NSString *dropboxRoot = @"CHANGE ME";  // either kDBRootAppFolder or kDBRootDropbox

    DBSession* dbSession = [[DBSession alloc] initWithAppKey:dropboxAppKey
                                                   appSecret:dropboxAppSecret
                                                        root:dropboxRoot];
    [DBSession setSharedSession:dbSession];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[GSViewController alloc] initWithNibName:@"GSViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([[DBSession sharedSession] handleOpenURL:url]) {
        if ([[DBSession sharedSession] isLinked]) {
            NSLog(@"App linked to Dropbox successfully");
        } else {
            NSLog(@"App not linked to Dropbox!");
        }
        return YES;
    }
    return NO;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
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
