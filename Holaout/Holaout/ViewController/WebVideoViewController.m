//
//  WebVideoViewController.m
//  YTBrowser
//
//  Created by Marin Todorov on 09/01/2013.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import "WebVideoViewController.h"
#import "ContactPickerViewController.h"

@implementation WebVideoViewController
@synthesize webView;
@synthesize friendsOnHolaout;
@synthesize activityIndicator;
@synthesize seledtedFriend;
@synthesize video;
@synthesize btnSend;
@synthesize hideSendBtn;
@synthesize strVideoID;
@synthesize resVideoID;

-(void)returnContactArray:(NSArray *)dataArray{
    NSLog(@"%@",dataArray);
    NSMutableArray *holaoutArray  = [[NSMutableArray alloc] init];
    NSMutableArray *otherArray = [[NSMutableArray alloc] init];
    for(int i=0;i<[dataArray count];i++){
        if([[[dataArray objectAtIndex:i] objectForKey:kISBlocked] intValue] != 1){
            if([[[dataArray objectAtIndex:i] objectForKey:kContactIsHolaout] intValue] == 1){
                [holaoutArray addObject:[dataArray objectAtIndex:i]];
            }
            else{
                [otherArray addObject:[dataArray objectAtIndex:i]];
            }
        }
    }
    friendsOnHolaout = holaoutArray;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [DataManager sharedDataManager].contactDelegate = self;
    NSDictionary *dictionary = [[NSUserDefaults standardUserDefaults] objectForKey:kStoredData];
    NSString *userId = [dictionary objectForKey:kUserId];
    [[DataManager sharedDataManager] getHolaoutContactsData:userId];
    
    VideoLink* link = self.video.link[0];
    NSString* videoId = nil;
    
    NSArray *queryComponents = [link.href.query componentsSeparatedByString:@"&"];
    for (NSString* pair in queryComponents) {
        NSArray* pairComponents = [pair componentsSeparatedByString:@"="];
        if ([pairComponents[0] isEqualToString:@"v"]) {
            videoId = pairComponents[1];
            break;
        }
    }
    
    resVideoID = videoId;
    NSString *resultVidID;
    if (hideSendBtn) {
        btnSend.hidden = YES;
        resultVidID = strVideoID;
    } else {
        btnSend.hidden = NO;
         resultVidID = resVideoID;
    }

    if (!resultVidID) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Video ID not found in video URL" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil]show];
        return;
    }
    NSLog(@"Embed video id: %@", resVideoID);

    int height;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        height = 233;
    }
    else{
        height = 469;
    }
    NSString *htmlString = [NSString stringWithFormat:@"<html><head>\
                            <meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no, width = 320\"/></head>\
                            <body style=\"background:#000;margin-top:0px;margin-left:0px\">\
                            <iframe id=\"ytplayer\" type=\"text/html\" width=\"%f\" height=\"%d\"\
                            src=\"http://www.youtube.com/embed/%@?autoplay=1\"\
                            frameborder=\"0\"/>\
                            </body></html>",self.view.frame.size.width,height,resultVidID];
    [webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:@"http://www.youtube.com"]];

}

- (IBAction)backButtonClicked:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) uploadImageAndSendTextLinkToFriends{
    MediaThumbnail *thumb = self.video.thumbnail[0];
    NSData *vidImageData = [NSData dataWithContentsOfURL:thumb.url];
    [QBContent TUploadFile:vidImageData fileName:@"image.png" contentType:@"image/png" isPublic:NO delegate:self];
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
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *yourArtPath = [NSString stringWithFormat:@"%@/%d.png",documentsDirectory,res.uploadedBlob.ID];
        MediaThumbnail *thumb = self.video.thumbnail[0];
        NSData *vidImageData = [NSData dataWithContentsOfURL:thumb.url];
        UIImage *vidImage = [UIImage imageWithData:vidImageData];
        NSData *ResVidImgData;
        if (vidImage.size.width > 40  || vidImage.size.height > 40) {
            ResVidImgData = UIImagePNGRepresentation([self imageWithImage:vidImage scaledToSize:CGSizeMake(40, 40)]);
        } else {
            ResVidImgData = UIImagePNGRepresentation(vidImage);
        }
        [ResVidImgData writeToFile:yourArtPath atomically:YES];
        
        QBChatMessage *message = [QBChatMessage message];
        message.senderID = [LocalStorageService shared].currentUser.ID;
        message.recipientID = [[seledtedFriend objectForKey:kContactHolaoutId] intValue]; // opponent's id
        VideoLink *vidID = self.video.link[0];
        NSURL *videoID = vidID.href;
        NSString *strVidID = [videoID absoluteString];
        [message setCustomParameters:(NSMutableDictionary *)@{@"fileID": @(uploadedFileID),@"video":@"YES",@"isYouTubeVideo": @"YES",@"videoID": strVidID}];
        [[ChatService instance] sendMessage:message];
        [[LocalStorageService shared] saveImageToHistory:[NSDictionary dictionaryWithObjectsAndKeys:message,kMessage,[NSString stringWithFormat:@"%d",uploadedFileID],@"image", nil] withUserID:message.recipientID];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Video sent successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert setTag:101];
        [alert show];
    }else{
        NSLog(@"errors=%@", result.errors);
    }
}

- (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (IBAction)sendButtonClicked:(id)sender{
    if(seledtedFriend){
        [activityIndicator startAnimating];
        [self uploadImageAndSendTextLinkToFriends];
    }
    else{
        ContactPickerViewController *contactViewController;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            contactViewController = [[ContactPickerViewController alloc] initWithNibName:@"ContactPickerViewController_iPhone" bundle:nil];
        }
        else{
            contactViewController = [[ContactPickerViewController alloc] initWithNibName:@"ContactPickerViewController_iPad" bundle:nil];
        }
        MediaThumbnail *thumb = self.video.thumbnail[0];
        NSData *imageData = [NSData dataWithContentsOfURL:thumb.url];
        UIImage *vidImage = [UIImage imageWithData:imageData];
        NSLog(@"image size:%f & %f",vidImage.size.width,vidImage.size.height);
        UIImage *vidResImage;
        if (vidImage.size.width > 40  || vidImage.size.height > 40) {
            vidResImage = [self imageWithImage:vidImage scaledToSize:CGSizeMake(40, 40)];
        } else {
            vidResImage = vidImage;
        }
        contactViewController.vidImgToSend = vidResImage;
        contactViewController.vidIDString = resVideoID;
        contactViewController.isVideo = true;
        contactViewController.isYTVideo = true;
        contactViewController.contactArray = friendsOnHolaout;
        [self presentViewController:contactViewController animated:YES completion:nil];
    }
}
@end
