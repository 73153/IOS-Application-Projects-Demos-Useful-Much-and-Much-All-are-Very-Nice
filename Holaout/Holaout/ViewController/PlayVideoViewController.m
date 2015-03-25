//
//  PlayVideoViewController.m
//  Holaout
//
//  Created by Amit Parmar on 10/01/14.
//  Copyright (c) 2014 N-Tech. All rights reserved.
//

#import "PlayVideoViewController.h"
#import "ContactPickerViewController.h"
#import "DataManager.h"

@implementation PlayVideoViewController
@synthesize movieUrl;
@synthesize theMoviPlayer;
@synthesize selectedFriend;
@synthesize friendsOnHolaout;
@synthesize hideSendButton;
@synthesize btnSend;
@synthesize activityIndicator;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    if(hideSendButton){
        [btnSend setHidden:YES];
    }
    else{
        [btnSend setHidden:NO];
    }
    NSDictionary *dictionary = [[NSUserDefaults standardUserDefaults] objectForKey:kStoredData];
    NSString *userId = [dictionary objectForKey:kUserId];
    [[DataManager sharedDataManager] getHolaoutContactsData:userId];
    
	theMoviPlayer = [[MPMoviePlayerController alloc] initWithContentURL:movieUrl];
    theMoviPlayer.controlStyle = MPMovieControlStyleFullscreen;
    [theMoviPlayer.view setFrame:CGRectMake(0,0,self.view.frame.size.width, 250)];
    theMoviPlayer.view.center = self.view.center;
    [self.view addSubview:theMoviPlayer.view];
    [theMoviPlayer play];
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (IBAction)btnBackClicked:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void) uploadVideoAndSendTextLinkToFriends{
    NSData *videoData = [NSData dataWithContentsOfURL:movieUrl];
    [QBContent TUploadFile:videoData fileName:@"video.mp4" contentType:@"video/mp4" isPublic:NO delegate:self];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if([alertView tag] == 101 && buttonIndex == 0){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


- (void)completedWithResult:(Result*)result{
    [activityIndicator stopAnimating];
    if(result.success && [result isKindOfClass:[QBCFileUploadTaskResult class]]){
        QBCFileUploadTaskResult *res = (QBCFileUploadTaskResult *)result;
        NSUInteger uploadedFileID = res.uploadedBlob.ID;
        
        NSData *videoData = [NSData dataWithContentsOfURL:movieUrl];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *yourArtPath = [NSString stringWithFormat:@"%@/%d.mp4",documentsDirectory,uploadedFileID];
        [videoData writeToFile:yourArtPath atomically:YES];
        
        QBChatMessage *message = [QBChatMessage message];
        message.senderID = [LocalStorageService shared].currentUser.ID;
        message.recipientID = [[selectedFriend objectForKey:kContactHolaoutId] intValue]; // opponent's id
        [message setCustomParameters:(NSMutableDictionary *)@{@"fileID": @(uploadedFileID),@"video":@"YES"}];
        [[QBChat instance] sendMessage:message];
        [[LocalStorageService shared] saveImageToHistory:[NSDictionary dictionaryWithObjectsAndKeys:message,kMessage,[NSString stringWithFormat:@"%d",uploadedFileID],@"image", nil] withUserID:message.recipientID];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Video sent successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:101];
        [alert show];
    }else{
        NSLog(@"errors=%@", result.errors);
    }
}


- (IBAction)btnSendClicked:(id)sender{
    NSData *videoData = [NSData dataWithContentsOfURL:movieUrl];
    if(selectedFriend){
        [activityIndicator startAnimating];
        [self uploadVideoAndSendTextLinkToFriends];
    }
    else{
        ContactPickerViewController *contactViewController;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            contactViewController = [[ContactPickerViewController alloc] initWithNibName:@"ContactPickerViewController_iPhone" bundle:nil];
        }
        else{
            contactViewController = [[ContactPickerViewController alloc] initWithNibName:@"ContactPickerViewController_iPad" bundle:nil];
        }
        contactViewController.videoDataToSend = videoData;
        contactViewController.contactArray = friendsOnHolaout;
        [self presentViewController:contactViewController animated:YES completion:nil];
    }
}


@end
