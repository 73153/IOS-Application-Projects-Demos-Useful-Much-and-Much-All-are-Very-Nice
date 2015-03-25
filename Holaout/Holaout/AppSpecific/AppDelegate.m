//
//  AppDelegate.m
//  Holaout
//
//  Created by Amit Parmar on 04/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import "LeftMenuViewController.h"
#import "FriendsViewController.h"
#import "AcceptCallViewController.h"
#import "CallViewController.h"
#import "AcceptCallViewController.h"
#import "SubDetailFriendsViewController.h"

static AppDelegate *appdelegate;
@implementation AppDelegate
@synthesize databaseName;
@synthesize databasePath;
@synthesize userID;
@synthesize videoChat;
@synthesize selectedFriend;
@synthesize acceptViewController;

+(AppDelegate *)appdelegate{
    if(!appdelegate){
        appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    return appdelegate;
}

-(void) createAndCheckDatabase{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    success = [fileManager fileExistsAtPath:databasePath];
    if(success) return;
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.databaseName];
    [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleBlackTranslucent;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    [QBSettings setApplicationID:kApplicationId];
    [QBSettings setAuthorizationKey:kAuthorizationKey];
    [QBSettings setAuthorizationSecret:kAuthorizationSecret];
    [QBAuth createSessionWithDelegate:self];
    
    NSMutableDictionary *videoChatConfiguration = [[QBSettings videoChatConfiguration] mutableCopy];
    [videoChatConfiguration setObject:@20 forKey:kQBVideoChatCallTimeout];
    [videoChatConfiguration setObject:AVCaptureSessionPresetLow forKey:kQBVideoChatFrameQualityPreset];
    [videoChatConfiguration setObject:@2 forKey:kQBVideoChatVideoFramesPerSecond];
    [videoChatConfiguration setObject:@3 forKey:kQBVideoChatP2PTimeout];
    [QBSettings setVideoChatConfiguration:videoChatConfiguration];
    
    self.databaseName = @"Holaout.sqlite";
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [documentPaths objectAtIndex:0];
    self.databasePath = [documentDir stringByAppendingPathComponent:self.databaseName];
    
    [self createAndCheckDatabase];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    if([[NSUserDefaults standardUserDefaults] boolForKey:kISLoggedIn]){
    }
    else{
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            self.viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil];
        } else {
            self.viewController = [[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil];
        }
        UINavigationController *navigationController;
        navigationController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
        [navigationController setNavigationBarHidden:YES animated:YES];
        self.window.rootViewController = navigationController;
        [self.window makeKeyAndVisible];
    }
    [QBChat instance].delegate = self;
    return YES;
}

- (void)completedWithResult:(Result *)result{
    [QBChat instance].delegate = self;
    if(result.success && [result isKindOfClass:QBAAuthSessionCreationResult.class]){
        NSLog(@"Session Created SuccessFully");
        [QBMessages TRegisterSubscriptionWithDelegate:self];
        if([[NSUserDefaults standardUserDefaults] boolForKey:kISLoggedIn]){
            NSDictionary *dataDictionary = [[NSUserDefaults standardUserDefaults] objectForKey:kStoredData];
            [QBUsers logInWithUserLogin:[dataDictionary objectForKey:kUserName] password:[dataDictionary objectForKey:kPassword]  delegate:self];
        }
    }
    else if([result isKindOfClass:QBCFileUploadTaskResult.class]){
        QBCFileUploadTaskResult *res = (QBCFileUploadTaskResult *)result;
        QBUUser *user = [QBUUser user];
        user.ID = userID;
        user.blobID = res.uploadedBlob.ID;
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:kStoredData]];
        [dictionary setObject:[NSString stringWithFormat:@"%d",user.blobID] forKey:kUserBlobId];
        [[NSUserDefaults standardUserDefaults] setObject:dictionary forKey:kStoredData];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [QBUsers updateUser:user delegate:self];
    }
    else if(result.success && [result isKindOfClass:QBUUserLogInResult.class]){
        QBUUserLogInResult *loginResult = (QBUUserLogInResult *)result;
        QBUUser *user = loginResult.user;
         NSDictionary *dataDictionary = [[NSUserDefaults standardUserDefaults] objectForKey:kStoredData];
        user.password = [dataDictionary objectForKey:kPassword];
        [[ChatService instance] loginWithUser:user completionBlock:nil];
        [LocalStorageService shared].currentUser = user;
        LeftMenuViewController *leftMenu;
        FriendsViewController *friendsViewController;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            leftMenu = [[LeftMenuViewController alloc] initWithNibName:@"LeftMenuViewController_iPhone" bundle:nil];
            friendsViewController = [[FriendsViewController alloc] initWithNibName:@"FriendsViewController_iPhone" bundle:nil];
        }
        else{
            leftMenu = [[LeftMenuViewController alloc] initWithNibName:@"LeftMenuViewController_iPad" bundle:nil];
            friendsViewController = [[FriendsViewController alloc] initWithNibName:@"FriendsViewController_iPad" bundle:nil];
        }
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:friendsViewController];
        UINavigationController *navController1 = [[UINavigationController alloc] initWithRootViewController:leftMenu];
        [navController1 setNavigationBarHidden:YES animated:YES];
        MFSideMenuContainerViewController *container = [MFSideMenuContainerViewController
                                                        containerWithCenterViewController:navController
                                                        leftMenuViewController:navController1
                                                        rightMenuViewController:nil];
        self.window.rootViewController = container;
        [self.window makeKeyAndVisible];
    }
    else if(result.success && [result isKindOfClass:QBLGeoDataPagedResult.class]){
        QBLGeoDataPagedResult *checkinsResult = (QBLGeoDataPagedResult *)result;
        NSLog(@"Checkins: %@", checkinsResult.geodata);
        
    }
    else{
        NSLog(@"errors=%@",result.errors);
    }
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
    [FBAppEvents activateApp];
    [FBAppCall handleDidBecomeActive];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [FBSession.activeSession close];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSString *message = [[userInfo objectForKey:QBMPushMessageApsKey] objectForKey:QBMPushMessageAlertKey];
    NSLog(@"message=%@",message);
}

-(void) chatCallUserDidNotAnswer:(NSUInteger)userID{
    NSLog(@"chatCallUserDidNotAnswer %d", userID);
}

- (void) chatDidReceiveCallRequestFromUser:(NSUInteger)userID withSessionID:(NSString*)sessionID conferenceType:(enum QBVideoChatConferenceType)conferenceType customParameters:(NSDictionary *)customParameters{
    UIViewController *viewController =self.window.rootViewController;
    if(![viewController isKindOfClass:[AcceptCallViewController class]]){
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            acceptViewController = [[AcceptCallViewController alloc] initWithNibName:@"AcceptCallViewController_iPhone" bundle:nil];
        }
        else{
            acceptViewController = [[AcceptCallViewController alloc] initWithNibName:@"AcceptCallViewController_iPad" bundle:nil];
        }
        acceptViewController.userId =userID;
        acceptViewController.sessionId = sessionID;
        acceptViewController.selectedFriend = selectedFriend;
        [AppDelegate appdelegate].window.rootViewController = acceptViewController;
        [[AppDelegate appdelegate].window makeKeyAndVisible];
    }
}

-(void) chatCallDidAcceptByUser:(NSUInteger)userID{
    [[SubDetailFriendsViewController subdetail] presentCallView:selectedFriend];
}

- (void)chatCallDidStartWithUser:(NSUInteger)userID sessionID:(NSString *)sessionID{
    NSLog(@"chatCallUserDidNotAnswer %d", userID);
}


- (void) callButtoClicked:(int)userId{
    if(self.videoChat)
        self.videoChat = nil;
    self.videoChat = [[QBChat instance] createAndRegisterVideoChatInstance];
    [self.videoChat callUser:userId conferenceType:QBVideoChatConferenceTypeAudio];
}

@end
