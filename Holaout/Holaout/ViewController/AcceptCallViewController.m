//
//  AcceptCallViewController.m
//  Holaout
//
//  Created by Amit Parmar on 09/01/14.
//  Copyright (c) 2014 N-Tech. All rights reserved.
//

#import "AcceptCallViewController.h"
#import "SettingsViewController.h"
#import "LeftMenuViewController.h"
#import "FriendsViewController.h"

@implementation AcceptCallViewController

@synthesize lblUserName;
@synthesize lblTime;
@synthesize lblDay;
@synthesize userImageView;
@synthesize sessionId;
@synthesize userId;
@synthesize selectedFriend;
@synthesize timer;
@synthesize count;
@synthesize dateFormatter;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)populateLabel:(UILabel *)label withTimeInterval:(NSTimeInterval)timeInterval {
    uint seconds = fabs(timeInterval);
    uint minutes = seconds / 60;
    uint hours = minutes / 60;
    
    seconds -= minutes * 60;
    minutes -= hours * 60;
    
    [label setText:[NSString stringWithFormat:@"%@%02uh:%02um:%02us", (timeInterval<0?@"-":@""), hours, minutes, seconds]];
}

- (void) showTime{
    count++;
    [self populateLabel:lblTime withTimeInterval:count];
}

- (void)completedWithResult:(Result *)result{
    if(result.success && [result isKindOfClass:[QBUUserResult class]]){
        QBUUserResult *userResult = (QBUUserResult *)result;
        if(userResult.user.fullName){
            lblUserName.text = userResult.user.fullName;
        }
        else{
            lblUserName.text = userResult.user.login;
        }
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *yourArtPath = [NSString stringWithFormat:@"%@/%d.png",documentsDirectory,userResult.user.blobID];
        if([[NSFileManager defaultManager] fileExistsAtPath:yourArtPath isDirectory:NO]){
           userImageView.image = [UIImage imageWithContentsOfFile:yourArtPath];
        }
        else{
            [QBContent TDownloadFileWithBlobID:userResult.user.blobID delegate:self];
        }
    }
    else if(result.success && [result isKindOfClass:QBCFileDownloadTaskResult.class]){
        QBCFileDownloadTaskResult *res = (QBCFileDownloadTaskResult *)result;
        UIImage *profilePicture = [UIImage imageWithData:res.file];
        userImageView.image = profilePicture;
    }

    else{
        NSLog(@"errors=%@",result.errors);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    lblUserName.text = [selectedFriend objectForKey:kContactName];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    int weekday = [comps weekday];
    if(weekday == 1){
        lblDay.text = @"Sunday";
    }
    else if (weekday == 2){
        lblDay.text = @"Monday";
    }
    else if (weekday == 3){
        lblDay.text = @"Tuesday";
    }
    else if (weekday == 4){
        lblDay.text = @"Wednesday";
    }
    else if (weekday == 5){
        lblDay.text = @"Thursday";
    }
    else if (weekday == 6){
        lblDay.text = @"Friday";
    }
    else if (weekday == 7){
        lblDay.text = @"Saturday";
    }
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle: NSDateFormatterShortStyle];
    
    [QBUsers userWithID:userId delegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnBackClicked:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)btnSettingsClicked:(id)sender{
    SettingsViewController *settingsViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        settingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController_iPhone" bundle:nil];
    }
    else{
        settingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController_iPad" bundle:nil];
    }
    [self presentViewController:settingsViewController animated:YES completion:nil];
}

- (IBAction)btnAcceptClicked:(id)sender{
    [AppDelegate appdelegate].videoChat = [[QBChat instance] createAndRegisterVideoChatInstanceWithSessionID:sessionId];
    [[AppDelegate appdelegate].videoChat acceptCallWithOpponentID:userId conferenceType:QBVideoChatConferenceTypeAudio];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(showTime)
                                           userInfo:nil
                                            repeats:YES];
}
- (IBAction)btnRejectClicked:(id)sender{
    [AppDelegate appdelegate].videoChat = [[QBChat instance] createAndRegisterVideoChatInstanceWithSessionID:sessionId];
    [[AppDelegate appdelegate].videoChat rejectCallWithOpponentID:userId];
    [[QBChat instance] unregisterVideoChatInstance:[AppDelegate appdelegate].videoChat];
    [AppDelegate appdelegate].videoChat = nil;
    
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
    [AppDelegate appdelegate].window.rootViewController = container;
    [[AppDelegate appdelegate].window makeKeyAndVisible];
    
}

@end
