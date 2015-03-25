//
//  SubDetailFriendsViewController.m
//  Holaout
//
//  Created by Amit Parmar on 27/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "SubDetailFriendsViewController.h"
#import "SettingsViewController.h"
#import "VideoViewController.h"
#import "PhotoViewController.h"
#import "MessageViewController.h"
#import "DrawingViewController.h"
#import "CallViewController.h"
#import "AcceptCallViewController.h"

static SubDetailFriendsViewController *subDetail;
@implementation SubDetailFriendsViewController
@synthesize selectedFriend;
@synthesize lblUsername;
@synthesize userImageView;
@synthesize lblPlace;
@synthesize lblStatus;

+(SubDetailFriendsViewController *)subdetail{
    if(!subDetail){
        if([[UIDevice currentDevice] userInterfaceIdiom]== UIUserInterfaceIdiomPhone){
            subDetail = [[SubDetailFriendsViewController alloc] initWithNibName:@"SubDetailFriendsViewController_iPhone" bundle:nil];
        }
        else{
            subDetail = [[SubDetailFriendsViewController alloc] initWithNibName:@"SubDetailFriendsViewController_iPad" bundle:nil];
        }
    }
    return subDetail;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self getCheckIns];
}
- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    lblUsername.text = [selectedFriend objectForKey:kContactName];
    userImageView.image = [UIImage imageWithContentsOfFile:[selectedFriend objectForKey:kContactImage]];
    [QBUsers userWithID:[[selectedFriend objectForKey:kContactHolaoutId] intValue] delegate:self];
    [NSTimer scheduledTimerWithTimeInterval:30 target:[QBChat instance] selector:@selector(sendPresence) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButtonClicked:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)settingsClicked:(id)sender{
    SettingsViewController *settingsViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        settingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController_iPhone" bundle:nil];
    }
    else{
        settingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController_iPad" bundle:nil];
    }
    [self presentViewController:settingsViewController animated:YES completion:nil];
}

- (IBAction)btnVideoClicked:(id)sender{
    VideoViewController *videoViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        videoViewController = [[VideoViewController alloc] initWithNibName:@"VideoViewController_iPhone" bundle:nil];
    }
    else{
        videoViewController = [[VideoViewController alloc] initWithNibName:@"VideoViewController_iPad" bundle:nil];
    }
    videoViewController.needToHideBottomView = YES;
    videoViewController.seledtedFriend = selectedFriend;
    [self presentViewController:videoViewController animated:YES completion:nil];
}
- (IBAction)btnPhotoClicked:(id)sender{
    PhotoViewController *photoViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        photoViewController = [[PhotoViewController alloc] initWithNibName:@"PhotoViewController_iPhone" bundle:nil];
    }
    else{
        photoViewController = [[PhotoViewController alloc] initWithNibName:@"PhotoViewController_iPad" bundle:nil];
    }
    photoViewController.needToHideBottomView = YES;
    photoViewController.seledtedFriend = selectedFriend;
    [self presentViewController:photoViewController animated:YES completion:nil];
    
}
- (IBAction)btnChatClicked:(id)sender{
    MessageViewController *messageViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        messageViewController = [[MessageViewController alloc] initWithNibName:@"MessageViewController_iPhone" bundle:nil];
    }
    else{
        messageViewController = [[MessageViewController alloc] initWithNibName:@"MessageViewController_iPad" bundle:nil];
    }
    QBUUser *user = [QBUUser user];
    user.email = [selectedFriend objectForKey:kContactEmail];
    user.ID = [[selectedFriend objectForKey:kContactHolaoutId] intValue];
    user.fullName = [selectedFriend objectForKey:kContactName];
    user.phone = [selectedFriend objectForKey:KContactPhone];
    messageViewController.opponent = user;
     messageViewController.selectedFriend = selectedFriend;
    [self presentViewController:messageViewController animated:YES completion:nil];
}

- (void) presentCallView:(NSDictionary *)data{
    CallViewController *callViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        callViewController = [[CallViewController alloc] initWithNibName:@"CallViewController_iPhone" bundle:nil];
    }
    else{
        callViewController = [[CallViewController alloc] initWithNibName:@"CallViewController_iPad" bundle:nil];
    }
    callViewController.selectedFriend = data;
    [self presentViewController:callViewController animated:YES completion:nil];
}
- (IBAction)btnCallClicked:(id)sender{
    [[AppDelegate appdelegate] callButtoClicked:[[selectedFriend objectForKey:kContactHolaoutId] intValue]];
    [AppDelegate appdelegate].selectedFriend = selectedFriend;
}
- (IBAction)btnDrawingClicked:(id)sender{
    DrawingViewController *drawingView;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        drawingView = [[DrawingViewController alloc] initWithNibName:@"DrawingViewController_iPhone" bundle:nil];
    }
    else{
         drawingView = [[DrawingViewController alloc] initWithNibName:@"DrawingViewController_iPad" bundle:nil];
    }
    drawingView.needToHideBottomView = YES;
    drawingView.selectedFriend = selectedFriend;
    [self presentViewController:drawingView animated:YES completion:nil];
}

- (void) getCheckIns{
    QBLGeoDataGetRequest *getRequest = [QBLGeoDataGetRequest request];
    getRequest.status = YES;
    getRequest.lastOnly = YES;
    getRequest.userID = [[selectedFriend objectForKey:kContactHolaoutId] intValue];
    [QBLocation geoDataWithRequest:getRequest delegate:self];
}

- (void)completedWithResult:(Result *)result{
    if(result.success && [result isKindOfClass:[QBUUserResult class]]){
        QBUUserResult *userResult = (QBUUserResult *)result;
        NSInteger currentTimeInterval = [[NSDate date] timeIntervalSince1970];
        NSInteger userLastRequestAtTimeInterval   = [[userResult.user lastRequestAt] timeIntervalSince1970];
        if((currentTimeInterval - userLastRequestAtTimeInterval) > 5*60){
            lblStatus.text = @"I am currently unavailable you can send me message";
        }
        else{
            lblStatus.text = @"I am available";
        }
    }
    else if(result.success && [result isKindOfClass:QBLGeoDataPagedResult.class]){
        QBLGeoDataPagedResult *checkinsResult = (QBLGeoDataPagedResult *)result;
        QBLGeoData *geoData = [checkinsResult.geodata objectAtIndex:0];
        lblPlace.text = [NSString stringWithFormat:@"Last online in %@",geoData.status];
    }else{
        NSLog(@"errors=%@",result.errors);
    }
}

@end
