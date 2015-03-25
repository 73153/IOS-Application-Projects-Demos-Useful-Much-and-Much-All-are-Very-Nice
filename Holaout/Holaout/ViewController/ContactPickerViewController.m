//
//  ContactPickerViewController.m
//  Holaout
//
//  Created by Amit Parmar on 09/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "ContactPickerViewController.h"

@implementation ContactPickerViewController

@synthesize btnSelectUnSelect;
@synthesize tblView;
@synthesize contactArray;
@synthesize isAllSelected;
@synthesize selectedArray;
@synthesize imageToSend;
@synthesize vidImgToSend;
@synthesize vidIDString;
@synthesize btnInviteOrSend;
@synthesize videoDataToSend;
@synthesize isVideo;
@synthesize isYTVideo;
@synthesize activityIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

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
    self.contactArray = holaoutArray;
    [self.tblView reloadData];
}

- (UIImage *)imageWithImage:(UIImage *)image convertToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return destImage;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    selectedArray = [[NSMutableArray alloc] init];
    [tblView setAllowsMultipleSelectionDuringEditing:YES];
     [tblView setEditing:YES animated:YES];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [DataManager sharedDataManager].contactDelegate = self;
    NSDictionary *dictionary = [[NSUserDefaults standardUserDefaults] objectForKey:kStoredData];
    NSString *userId = [dictionary objectForKey:kUserId];
    [[DataManager sharedDataManager] getHolaoutContactsData:userId];

    if(imageToSend || videoDataToSend || vidImgToSend){
        [btnInviteOrSend setTitle:@"Send" forState:UIControlStateNormal];
    }
    else{
       [btnInviteOrSend setTitle:@"Send" forState:UIControlStateNormal];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [contactArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Identifier"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Identifier"];
    }
    if(imageToSend || videoDataToSend || vidImgToSend){
        cell.imageView.image = [UIImage imageWithContentsOfFile:[[contactArray objectAtIndex:indexPath.row] objectForKey:kContactImage]];
        cell.textLabel.text = [[contactArray objectAtIndex:indexPath.row] objectForKey:kContactName];
    }
    else{
        cell.imageView.image = [UIImage imageWithContentsOfFile:[[contactArray objectAtIndex:indexPath.row] objectForKey:kPersonImage]];
        cell.textLabel.text = [[contactArray objectAtIndex:indexPath.row] objectForKey:kContactName];
        cell.detailTextLabel.text = [[contactArray objectAtIndex:indexPath.row] objectForKey:kPhone];
    }
    return cell;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (IBAction)btnBackClicked:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)sendMessage{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for(int i=0;i<[selectedArray count];i++){
        NSString *phone = [[selectedArray objectAtIndex:i] objectForKey:kPhone];
        if(phone)
            [array addObject:phone];
    }
    NSDictionary *dictionary = [[NSUserDefaults standardUserDefaults] objectForKey:kStoredData];
    MFMessageComposeViewController *mailComposer = [[MFMessageComposeViewController alloc]init];
    mailComposer.messageComposeDelegate = self;
    [mailComposer setRecipients:array];
    [mailComposer setSubject:@"would like to invite you to join Hola out!"];
    [mailComposer setBody:[NSString stringWithFormat:@"hey,\nI just downloaded Hola out on my phone.Its an app that lets you decide how long the message you send exist before disappearing forever.\nYou can chat off the record, so no trace of a conversation is left behind;send self-destructing photos and videos,and take back the messages you already sent with synced deletion. In other words,we can finally chat without worrying about other people seeing what we say!\nHola out is available for iPhone and Android. Download it now, then add me with username %@.\nChat Soon!",[dictionary objectForKey:kUserName]]];
    [self presentViewController:mailComposer animated:YES completion:nil];
}

- (void) uploadImageAndSendTextLinkToFriends{
    isVideo = false;
    NSData *imageData = UIImagePNGRepresentation(imageToSend);
    [QBContent TUploadFile:imageData fileName:@"image.png" contentType:@"image/png" isPublic:NO delegate:self];
}

- (void) uploadVideoAndSendTextLinkToFriends{
    isVideo = true;
    NSData *vidImageData = UIImagePNGRepresentation(vidImgToSend);
    if (isYTVideo) {
        [QBContent TUploadFile:vidImageData fileName:@"image.png" contentType:@"image/png" isPublic:NO delegate:self];
    } else {
        [QBContent TUploadFile:videoDataToSend fileName:@"video.mp4" contentType:@"video/mp4" isPublic:NO delegate:self];
    }
}


- (void)completedWithResult:(Result*)result{
    [activityIndicator stopAnimating];
    if(result.success && [result isKindOfClass:[QBCFileUploadTaskResult class]]){
        QBCFileUploadTaskResult *res = (QBCFileUploadTaskResult *)result;
        NSUInteger uploadedFileID = res.uploadedBlob.ID;
        
        for(int i=0;i<[selectedArray count];i++){
            NSDictionary *dictionary = [selectedArray objectAtIndex:i];
            QBChatMessage *message = [QBChatMessage message];
            message.text = @"test";
            message.senderID = [LocalStorageService shared].currentUser.ID;
            message.recipientID = [[dictionary objectForKey:kContactHolaoutId] intValue]; // opponent's id
            if(isVideo){
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                NSString *yourArtPath;
                if (isYTVideo) {
                    yourArtPath = [NSString stringWithFormat:@"%@/%d.png",documentsDirectory,res.uploadedBlob.ID];
                    NSData *vidImageData = UIImagePNGRepresentation(vidImgToSend);
                    [vidImageData writeToFile:yourArtPath atomically:YES];
                    [message setCustomParameters:(NSMutableDictionary *)@{@"fileID": @(uploadedFileID),@"video":@"YES",@"isYouTubeVideo": @"YES",@"videoID": vidIDString}];
                } else {
                    yourArtPath = [NSString stringWithFormat:@"%@/%d.mp4",documentsDirectory,res.uploadedBlob.ID];
                    [videoDataToSend writeToFile:yourArtPath atomically:YES];
                    [message setCustomParameters:(NSMutableDictionary *)@{@"fileID": @(uploadedFileID),@"video":@"YES"}];
                }
                
            }
            else{
                NSData *imageData = UIImagePNGRepresentation(imageToSend);
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                NSString *yourArtPath = [NSString stringWithFormat:@"%@/%d.png",documentsDirectory,res.uploadedBlob.ID];
                [imageData writeToFile:yourArtPath atomically:YES];
                
                [message setCustomParameters:(NSMutableDictionary *)@{@"fileID": @(uploadedFileID)}];
            }
            [[ChatService instance] sendMessage:message];
            [[LocalStorageService shared] saveImageToHistory:[NSDictionary dictionaryWithObjectsAndKeys:message,kMessage,[NSString stringWithFormat:@"%d",uploadedFileID],@"image", nil] withUserID:message.recipientID];
        }
        NSString *msg = @"Video sent successfully";
        if(isVideo){
           msg = @"Video sent successfully";
            isVideo = false;
        }
        else{
           msg = @"Image sent successfully";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:msg delegate:self cancelButtonTitle:kOK otherButtonTitles:nil, nil];
        [alert show];
    }else{
        NSLog(@"errors=%@", result.errors);
    }
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    if (result) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Invitation sent successfully" delegate:self cancelButtonTitle:kOK otherButtonTitles:nil, nil];
        [alert show];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnInviteClicked:(id)sender{
    if([selectedArray count] > 0){
        if(imageToSend){
            [activityIndicator startAnimating];
            [self uploadImageAndSendTextLinkToFriends];
        }
        else if(videoDataToSend || vidImgToSend){
            [activityIndicator startAnimating];
            [self uploadVideoAndSendTextLinkToFriends];
        }
        else{
           [self sendMessage];
        }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Please select at lease one fiend to send invitation" delegate:self cancelButtonTitle:kOK otherButtonTitles:nil, nil];
        [alert show];
    }
}
- (IBAction)btnSelectUnSelectClicked:(id)sender{
    if(!isAllSelected){
        [selectedArray removeAllObjects];
        isAllSelected = true;
        [btnSelectUnSelect setTitle:@"Unselect all" forState:UIControlStateNormal];
        for(int i=0;i<[contactArray count];i++){
            [selectedArray addObject:[contactArray objectAtIndex:i]];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [tblView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        }
    }
    else{
        [selectedArray removeAllObjects];
        isAllSelected = false;
        for(int i=0;i<[contactArray count];i++){
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [tblView deselectRowAtIndexPath:indexPath animated:YES];
        }
        [btnSelectUnSelect setTitle:@"Select all" forState:UIControlStateNormal];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    [selectedArray addObject:[contactArray objectAtIndex:indexPath.row]];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dataDictionary = [contactArray objectAtIndex:indexPath.row];
    [selectedArray removeObject:dataDictionary];
}
@end
