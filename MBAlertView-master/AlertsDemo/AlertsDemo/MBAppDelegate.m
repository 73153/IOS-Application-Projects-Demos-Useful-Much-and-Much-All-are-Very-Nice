//
//  MBAppDelegate.m
//  AlertsDemo
//
//  Created by Mo Bitar on 1/15/13.
//  Copyright (c) 2013 progenius, inc. All rights reserved.
//

#import "MBAppDelegate.h"
#import "MBHUDView.h"
#import "RootViewController.h"

@implementation MBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    UIViewController *controller = [RootViewController new];
    self.window.rootViewController = controller;
    
    [self playDemo];

    return YES;
}

- (void)playDemo
{
    void (^goodbye)() = ^{
        [MBHUDView hudWithBody:@"Goodbye then" type:MBAlertViewHUDTypeDefault hidesAfter:2.0 show:YES];
    };
    
    [MBHUDView hudWithBody:@"Hello" type:MBAlertViewHUDTypeCheckmark hidesAfter:1.0 show:YES];
    MBAlertView *alert = [MBAlertView alertWithBody:@"Do you want to see more? \n\n(Note: you do have a choice with multibuttons, but you should tap yes)]" cancelTitle:nil cancelBlock:nil];
    [alert addButtonWithText:@"Yes" type:MBAlertViewItemTypePositive block:^{
        [MBHUDView hudWithBody:@"Say please" type:MBAlertViewHUDTypeExclamationMark hidesAfter:1.5 show:YES];
        MBAlertView *please = [MBAlertView alertWithBody:@"Did you say please?" cancelTitle:nil cancelBlock:nil];
        please.size = CGSizeMake(280, 180);
        [please addButtonWithText:@"Yes" type:MBAlertViewItemTypePositive block:^{
            
            [MBHUDView hudWithBody:@"Good boy." type:MBAlertViewHUDTypeCheckmark hidesAfter:1.0 show:YES];
            [MBHUDView hudWithBody:@"Wait." type:MBAlertViewHUDTypeActivityIndicator hidesAfter:4.0 show:YES];
            [MBHUDView hudWithBody:@"Ready?" type:MBAlertViewHUDTypeDefault hidesAfter:2.0 show:YES];
            
            MBAlertView *destruct = [MBAlertView alertWithBody:@"Do you want your device to self-destruct?" cancelTitle:nil cancelBlock:nil];
            destruct.imageView.image = [UIImage imageNamed:@"image.png"];
            [destruct addButtonWithText:@"Yes please" type:MBAlertViewItemTypeDestructive block:^{
                [MBHUDView hudWithBody:@"Ok" type:MBAlertViewHUDTypeCheckmark hidesAfter:1.0 show:YES];
                [MBHUDView hudWithBody:@"5" type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
                [MBHUDView hudWithBody:@"4" type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
                [MBHUDView hudWithBody:@"3" type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
                [MBHUDView hudWithBody:@"2" type:MBAlertViewHUDTypeDefault hidesAfter:1.0 show:YES];
                [MBHUDView hudWithBody:@"1" type:MBAlertViewHUDTypeDefault hidesAfter:2.0 show:YES];
                [self doSomething:^{
                    MBHUDView *hud = [MBHUDView hudWithBody:@"Goodbye" type:MBAlertViewHUDTypeExclamationMark hidesAfter:2.0 show:YES];
                    hud.uponDismissalBlock = ^{
                        [UIView animateWithDuration:0.5 animations:^{ [self.window.rootViewController.view setBackgroundColor:[UIColor blackColor]]; }];
                    };
                } afterDelay:2.0];
            }];
            
            [destruct addButtonWithText:@"No thank you" type:MBAlertViewItemTypeDefault block:^{
                [MBHUDView hudWithBody:@"Ok, bye." type:MBAlertViewHUDTypeDefault hidesAfter:2.0 show:YES];
            }];
            
            [destruct addToDisplayQueue];
            
        }];
        
        [please addButtonWithText:@"Maybe" type:MBAlertViewItemTypeDefault block:goodbye];
        [please addButtonWithText:@"No" type:MBAlertViewItemTypeDestructive block:goodbye];
        
        [please addToDisplayQueue];
    }];
    
    [alert addButtonWithText:@"I don\'t know" type:MBAlertViewItemTypeDefault block:goodbye];
    [alert addButtonWithText:@"Maybe" type:MBAlertViewItemTypeDefault block:goodbye];
    [alert addButtonWithText:@"No" type:MBAlertViewItemTypeDestructive block:goodbye];
    
    [alert addToDisplayQueue];
}

-(void)doSomething:(id)block afterDelay:(float)delay
{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        ((void (^)())block)();
    });
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
