//
//  DetailFriendsViewController.m
//  Holaout
//
//  Created by Amit Parmar on 27/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "DetailFriendsViewController.h"
#import "SettingsViewController.h"
#import "SubDetailFriendsViewController.h"

@implementation DetailFriendsViewController
@synthesize btnBack;
@synthesize btnInfo;
@synthesize friendsArray;
@synthesize selectedFriend;
@synthesize lblUserName;
@synthesize userImageView;
@synthesize lblPlace;
@synthesize lblStatus;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    lblUserName.text = [selectedFriend objectForKey:kContactName];
    userImageView.image = [UIImage imageWithContentsOfFile:[selectedFriend objectForKey:kContactImage]];
    [self getCheckIns];
    [QBUsers userWithID:[[selectedFriend objectForKey:kContactHolaoutId] intValue] delegate:self];
    
}
- (IBAction)backButtonClicked:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)infoButtonClicked:(id)sender{
    SubDetailFriendsViewController *settingsViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        settingsViewController = [[SubDetailFriendsViewController alloc] initWithNibName:@"SubDetailFriendsViewController_iPhone" bundle:nil];
    }
    else{
        settingsViewController = [[SubDetailFriendsViewController alloc] initWithNibName:@"SubDetailFriendsViewController_iPad" bundle:nil];
    }
    settingsViewController.selectedFriend = selectedFriend;
    [self presentViewController:settingsViewController animated:YES completion:nil];
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
