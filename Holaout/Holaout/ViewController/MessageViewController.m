//
//  MessageViewController.m
//  Holaout
//
//  Created by Amit Parmar on 12/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "MessageViewController.h"
#import "SettingsViewController.h"
#import "ChatMessageTableViewCell.h"
#import "ImageViewController.h"
#import "PlayVideoViewController.h"
#import "PhotoViewController.h"
#import "VideoViewController.h"
#import "DrawingViewController.h"
#import "WebVideoViewController.h"

@implementation MessageViewController

@synthesize imgViewProfile;
@synthesize messageTableView;
@synthesize messageTextField;
@synthesize btnAdd;
@synthesize btnSend;
@synthesize btnDestruct;
@synthesize lblUserName;
@synthesize lblDestruct;
@synthesize messages;
@synthesize objDeleteIDsArray;
@synthesize opponent;
@synthesize selectedFriend;
@synthesize btnDestructSelected;
@synthesize timer;
@synthesize contactArray;
@synthesize btnBlockUser;
@synthesize btnClearHistory;
@synthesize btnEditProfile;
@synthesize settingView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void) checkForUpdate{
    
    NSMutableArray *dataArray = [NSMutableArray array];
    for (int i = 0; i < [self.messages count]; i++) {
        NSDictionary *dict = self.messages[i];
        if(![dict isKindOfClass:[QBChatMessage class]] && [dict objectForKey:@"image"]){
            QBChatMessage *message = [dict objectForKey:kMessage];
            NSString *destructTime = message.customParameters[@"destructID"];
            NSTimeInterval msgTimeInterval = [message.datetime timeIntervalSince1970];
            NSTimeInterval nowTimeInterval = [[NSDate date] timeIntervalSince1970];
            int presentTimeInterval = nowTimeInterval;
            
            if ([destructTime isEqual:@"1"] && (presentTimeInterval >= (msgTimeInterval + 1*60))) {
                [dataArray addObject:[message.customParameters objectForKey:@"deleteID"]];
            } else if ([destructTime isEqual:@"2"] && (presentTimeInterval >= (msgTimeInterval + 2*60))) {
                [dataArray addObject:[message.customParameters objectForKey:@"deleteID"]];
            } else if ([destructTime isEqual:@"5"] && (presentTimeInterval >= (msgTimeInterval + 5*60))) {
                [dataArray addObject:[message.customParameters objectForKey:@"deleteID"]];
            } else if ([destructTime isEqual:@"10"] && (presentTimeInterval >= (msgTimeInterval + 10*60))) {
                [dataArray addObject:[message.customParameters objectForKey:@"deleteID"]];
            } else {
                // nothing
            }
        }
        else{
            QBChatMessage *message = (QBChatMessage *)self.messages[i];
            NSString *destructTime = [message.customParameters objectForKey:@"destructID"];
            NSTimeInterval msgTimeInterval = [message.datetime timeIntervalSince1970];
            NSTimeInterval nowTimeInterval = [[NSDate date] timeIntervalSince1970];
            int presentTimeInterval = nowTimeInterval;
            if ([destructTime isEqual:@"1"] && (presentTimeInterval >= (msgTimeInterval + 1*60))) {
                [dataArray addObject:[message.customParameters objectForKey:@"deleteID"]];
            } else if ([destructTime isEqual:@"2"] && (presentTimeInterval >= (msgTimeInterval + 2*60))) {
                [dataArray addObject:[message.customParameters objectForKey:@"deleteID"]];
            } else if ([destructTime isEqual:@"5"] && (presentTimeInterval >= (msgTimeInterval + 5*60))) {
                [dataArray addObject:[message.customParameters objectForKey:@"deleteID"]];
            } else if ([destructTime isEqual:@"10"] && (presentTimeInterval >= (msgTimeInterval + 10*60))) {
                [dataArray addObject:[message.customParameters objectForKey:@"deleteID"]];
            } else {
                // nothing
            }
        }
    }
    if ([dataArray count] > 0) {
        [[LocalStorageService shared] clearChatMessagesOnDestruction:dataArray];
    }
    
}

-(void)returnContactArray:(NSArray *)dataArray{
    NSLog(@"%@",dataArray);
    contactArray  = [NSMutableArray array];
    
    for(int i=0;i<[dataArray count];i++){
        if([[[dataArray objectAtIndex:i] objectForKey:kISBlocked] intValue] != 1){
            if([[[dataArray objectAtIndex:i] objectForKey:kContactIsHolaout] intValue] == 1){
                [contactArray addObject:[dataArray objectAtIndex:i]];
            }
        }
        else
        {
            [contactArray addObject:[dataArray objectAtIndex:i]];
        }
    }
    
    for (int i=0; i<contactArray.count; i++)
    {
        NSString *str = [[contactArray objectAtIndex:i] valueForKey:kContactHolaoutId];
        
        if([str isEqualToString:[@(opponent.ID) stringValue]]){
            
            if ([[[contactArray objectAtIndex:i] objectForKey:kISBlocked] intValue] != 1)//Blocked or Unblocked
            {
                [btnBlockUser setTitle:@"Block" forState:UIControlStateNormal];
                [btnBlockUser setTag:102];
            }
            else
            {
                [btnBlockUser setTitle:@"UnBlock" forState:UIControlStateNormal];
                [btnBlockUser setTag:101];
            }
            return;
            
        }
        else{
            //nothing
        }
    }
}

-(void)historyWithUserID:(NSMutableArray *)dataArray {
    
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:kDate ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
    NSArray *sortedArray = [dataArray sortedArrayUsingDescriptors:sortDescriptors];

    if(self.opponent.ID != 0){
        self.messages = [NSMutableArray array];
        self.messages = (NSMutableArray *)sortedArray;
        NSLog(@"self.messages:%@",self.messages);
    }
    
    NSMutableArray *deleteIDsArray = [NSMutableArray array];
    for (int i = 0; i < [self.messages count]; i++) {
        NSDictionary *dict = self.messages[i];
        if(![dict isKindOfClass:[QBChatMessage class]] && [dict objectForKey:@"image"]){
            QBChatMessage *message = [dict objectForKey:kMessage];
            [deleteIDsArray addObject:message.customParameters[@"deleteID"]];
        }
        else{
            QBChatMessage *message = (QBChatMessage *)self.messages[i];
            [deleteIDsArray addObject:message.customParameters[@"deleteID"]];
        }
    }
    if ([dataArray count] > 0) {
        self.objDeleteIDsArray = [NSMutableArray array];
        self.objDeleteIDsArray = deleteIDsArray;
    }

    if(timer){
        [timer invalidate];
        timer = nil;
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(checkForUpdate) userInfo:nil repeats:YES];

    [messageTableView reloadData];
    if(self.messages.count > 0){
        [self.messageTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.messages count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

- (IBAction)btnClearHistoryClicked:(id)sender {
    [[LocalStorageService shared] clearChatHistoryWithUserID:self.objDeleteIDsArray];
    settingView.hidden = YES;
}

- (IBAction)btnBlockUserClicked:(id)sender {
    for(int i=0;i<[contactArray count];i++)
    {
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:opponent.fullName,kContactName,opponent.phone,KContactPhone,opponent.email,kContactEmail,@"1",kContactIsHolaout,[@(opponent.ID) stringValue],kContactHolaoutId,@"1",kISBlocked,@"1",kContactId, nil];
        NSString *str = [[contactArray objectAtIndex:i] valueForKey:kContactHolaoutId];
        if ([btnBlockUser tag]==102) {
            if ([[[contactArray objectAtIndex:i] objectForKey:kISBlocked] intValue] != 1 && [str isEqualToString:[@(opponent.ID) stringValue]]) {
                
                [btnBlockUser setTitle:@"Block" forState:UIControlStateNormal];
                
                [[QBChat instance] removeUserFromContactList:opponent.ID];
                
                [[DataManager sharedDataManager] updateContactsData:dictionary forRowId:[[contactArray objectAtIndex:i] objectForKey:KID]];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Contact Blocked successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
        }
        else if([btnBlockUser tag]==101 && [str isEqualToString:[@(opponent.ID) stringValue]])
        {
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:opponent.fullName,kContactName,opponent.phone,KContactPhone,opponent.email,kContactEmail,@"1",kContactIsHolaout,[@(opponent.ID) stringValue],kContactHolaoutId,@"0",kISBlocked,@"1",kContactId, nil];
            [btnBlockUser setTitle:@"UnBlock" forState:UIControlStateNormal];
            [[QBChat instance] addUserToContactListRequest:opponent.ID];
            [[DataManager sharedDataManager] updateContactsData:dictionary forRowId:[[contactArray objectAtIndex:i] objectForKey:KID]];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Contact UnBlocked successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
    }
    settingView.hidden = YES;
}

- (IBAction)btnEditProfileClicked:(id)sender {
    settingView.hidden = YES;
    SettingsViewController *settingsViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        settingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController_iPhone" bundle:nil];
    }
    else{
        settingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController_iPad" bundle:nil];
    }
    [self presentViewController:settingsViewController animated:YES completion:nil];
}

-(IBAction) handleTapGesture:(UIGestureRecognizer *) sender {
    settingView.hidden = YES;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:@"0" forKey:kDestructTime];

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tapGesture.delegate = self;
    [settingView addGestureRecognizer:tapGesture];
    
    settingView.hidden = YES;
    self.messageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    lblUserName.text = opponent.fullName;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [LocalStorageService shared].chatDelegate = self;
    [[LocalStorageService shared] messageHistoryWithUserID:self.opponent.ID];
    
    [DataManager sharedDataManager].contactDelegate = self;
    [[DataManager sharedDataManager] getHolaoutContactsData:[[[NSUserDefaults standardUserDefaults] objectForKey:kStoredData] objectForKey:@"userId"]];
    // Set keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    // Set chat notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chatDidReceiveMessageNotification:)
                                                 name:kNotificationDidReceiveNewMessage object:nil];
    // Set title
    if(self.opponent != nil){
        self.title = self.opponent.login;
    }
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(checkForUpdate) userInfo:nil repeats:YES];
    
    [NSTimer scheduledTimerWithTimeInterval:30
                                     target:[QBChat instance] selector:@selector(sendPresence)
                                   userInfo:nil repeats:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if(timer){
        [timer invalidate];
        timer = nil;
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (IBAction)btnBackClicked:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)btnSettingsClicked:(id)sender{
    settingView.hidden = NO;
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"buttonIndex=%d",buttonIndex);
    if(buttonIndex == 0){
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
    else if(buttonIndex == 1){
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
    else if(buttonIndex == 2){
        DrawingViewController *drawingViewController;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            drawingViewController = [[DrawingViewController alloc] initWithNibName:@"DrawingViewController_iPhone" bundle:nil];
        }
        else{
            drawingViewController = [[DrawingViewController alloc] initWithNibName:@"DrawingViewController_iPad" bundle:nil];
        }
        drawingViewController.needToHideBottomView = YES;
        drawingViewController.selectedFriend = selectedFriend;
        [self presentViewController:drawingViewController animated:YES completion:nil];
    }
}
- (IBAction)btnAddClicked:(id)sender{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:kAppTitle
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Photo", @"Video", @"Drawing",nil];
    [actionSheet showInView:self.view];
    
}
- (IBAction)btnSendClicked:(id)sender{
    if([self.messageTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0 || !self.messageTextField.text){
        return;
    }
    [QBUsers userWithID:self.opponent.ID delegate:self];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *btnTitle = [alertView buttonTitleAtIndex:buttonIndex];

    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *destructValue;
    if ([btnTitle isEqualToString:@"1 minute"]) {
        destructValue = @"1";
        [prefs setObject:destructValue forKey:kDestructTime];
    } else if ([btnTitle isEqualToString:@"2 minutes"]) {
        destructValue = @"2";
        [prefs setObject:destructValue forKey:kDestructTime];
    } else if ([btnTitle isEqualToString:@"5 minutes"]) {
        destructValue = @"5";
        [prefs setObject:destructValue forKey:kDestructTime];
    } else if ([btnTitle isEqualToString:@"10 minutes"]) {
        destructValue = @"10";
        [prefs setObject:destructValue forKey:kDestructTime];
    }else {
        destructValue = @"0";
        [prefs setObject:destructValue forKey:kDestructTime];
        btnDestructSelected = false;
        [btnDestruct setBackgroundImage:[UIImage imageNamed:@"off.png"] forState:UIControlStateNormal];
    }
    [prefs synchronize];
}

- (IBAction)btnDestructClicked:(id)sender {
    if(!btnDestructSelected){
        btnDestructSelected = true;
        [btnDestruct setBackgroundImage:[UIImage imageNamed:@"on.png"] forState:UIControlStateNormal];
        
        UIAlertView *destructAlert = [[UIAlertView alloc] initWithTitle:@"Select Destruct Time" message:@"Time is in Minutes..." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"1 minute", @"2 minutes", @"5 minutes", @"10 minutes", nil];
        [destructAlert show];
    }
    else{
        btnDestructSelected = false;
        [btnDestruct setBackgroundImage:[UIImage imageNamed:@"off.png"] forState:UIControlStateNormal];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:@"0" forKey:kDestructTime];
        [prefs synchronize];
    }
}
- (void)completedWithResult:(Result *)result{
    if(result.success && [result isKindOfClass:QBMSendPushTaskResult.class]){
        NSLog(@"Push Send Successfully");
        
    }
    else if(result.success && [result isKindOfClass:[QBUUserResult class]]){
        QBUUserResult *userResult = (QBUUserResult *)result;
        self.opponent = userResult.user;
        NSInteger currentTimeInterval = [[NSDate date] timeIntervalSince1970];
        NSInteger userLastRequestAtTimeInterval   = [[opponent lastRequestAt] timeIntervalSince1970];
        if((currentTimeInterval - userLastRequestAtTimeInterval) > 5*60){
            NSLog(@"self.opponent.ID=%d",self.opponent.ID);
            [QBMessages TSendPushWithText:self.messageTextField.text toUsers:[NSString stringWithFormat:@"%d",self.opponent.ID] delegate:self];
            QBChatMessage *message = [[QBChatMessage alloc] init];
            message.recipientID = self.opponent.ID;
            NSLog(@"%d",[LocalStorageService shared].currentUser.ID);
            message.senderID = [LocalStorageService shared].currentUser.ID;
            message.text = self.messageTextField.text;
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            NSString *strDestruct = [prefs objectForKey:kDestructTime];
            message.customParameters = (NSMutableDictionary *)@{kDestructTime: strDestruct};
            [[LocalStorageService shared] saveMessageToHistory:message withUserID:message.recipientID];
            if(timer){
                [timer invalidate];
                timer = nil;
            }
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(checkForUpdate) userInfo:nil repeats:YES];
            [self.messageTableView reloadData];
            if(self.messages.count > 0){
                [self.messageTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.messages count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            }
            [self.messageTextField setText:nil];
            
        }else{
            QBChatMessage *message = [[QBChatMessage alloc] init];
            message.recipientID = self.opponent.ID;
            NSLog(@"%d",[LocalStorageService shared].currentUser.ID);
            message.senderID = [LocalStorageService shared].currentUser.ID;
            message.text = self.messageTextField.text;
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            NSString *strDestruct = [prefs objectForKey:kDestructTime];
            message.customParameters = (NSMutableDictionary *)@{kDestructTime: strDestruct};
            [[ChatService instance] sendMessage:message];
            [[LocalStorageService shared] saveMessageToHistory:message withUserID:message.recipientID];
            if(timer){
                [timer invalidate];
                timer = nil;
            }
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(checkForUpdate) userInfo:nil repeats:YES];

            [self.messageTableView reloadData];
            if(self.messages.count > 0){
                [self.messageTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.messages count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            }
            
            // Clean text field
            [self.messageTextField setText:nil];
        }
    }
    else{
        NSLog(@"errors=%@", result.errors);
    }
}

- (void)chatDidReceiveMessageNotification:(NSNotification *)notification{
    [self.messageTableView reloadData];
    if(self.messages.count > 0){
        [self.messageTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.messages count]-1 inSection:0]
                                      atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.messages count];
}

- (void)openImage:(id)sender{
    UIButton *button = (UIButton *)sender;
    if([button tag] == 102){
    }
    else{
    }
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ChatMessageCellIdentifier = @"ChatMessageCellIdentifier";
    ChatMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ChatMessageCellIdentifier];
    cell = nil;
    if(cell == nil){
        cell = [[ChatMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ChatMessageCellIdentifier];
    }
    NSDictionary *dict = self.messages[indexPath.row];
    if(![dict isKindOfClass:[QBChatMessage class]] && [dict objectForKey:@"image"]){
        [cell configureCellWithDictionary:dict is1To1Chat:self.opponent != nil  opponent:opponent.fullName];
    }
    else{
        QBChatMessage *message = (QBChatMessage *)self.messages[indexPath.row];
        [cell configureCellWithMessage:message is1To1Chat:self.opponent != nil    opponent:opponent.fullName];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = self.messages[indexPath.row];
    if(![dict isKindOfClass:[QBChatMessage class]] && [dict objectForKey:@"image"]){
        return 100;
    }
    else{
        QBChatMessage *chatMessage = (QBChatMessage *)[self.messages objectAtIndex:indexPath.row];
        CGFloat cellHeight = [ChatMessageTableViewCell heightForCellWithMessage:chatMessage is1To1Chat:self.opponent != nil];
        return cellHeight;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = self.messages[indexPath.row];
    if(![dict isKindOfClass:[QBChatMessage class]]){
        QBChatMessage *message = [dict objectForKey:kMessage];
        NSDictionary *customParamater = message.customParameters;
        if(customParamater[@"video"]){
            if (customParamater[@"isYouTubeVideo"]) {
                WebVideoViewController *imageViewController;
                if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
                    imageViewController = [[WebVideoViewController alloc] initWithNibName:@"WebVideoViewController_iPhone" bundle:nil];
                }
                else{
                    imageViewController = [[WebVideoViewController alloc] initWithNibName:@"WebVideoViewController_iPad" bundle:nil];
                }
                imageViewController.seledtedFriend = selectedFriend;
                imageViewController.strVideoID = customParamater[@"videoID"];
                imageViewController.hideSendBtn = YES;
                [self presentViewController:imageViewController animated:YES completion:nil];
            } else {
                PlayVideoViewController *imageViewController;
                if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
                    imageViewController = [[PlayVideoViewController alloc] initWithNibName:@"PlayVideoViewController_iPhone" bundle:nil];
                }
                else{
                    imageViewController = [[PlayVideoViewController alloc] initWithNibName:@"PlayVideoViewController_iPad" bundle:nil];
                }
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                NSString *yourArtPath = [NSString stringWithFormat:@"%@/%d.mp4",documentsDirectory,[[dict objectForKey:@"image"] intValue]];
                imageViewController.movieUrl = [NSURL fileURLWithPath:yourArtPath];
                imageViewController.hideSendButton = YES;
                imageViewController.selectedFriend = selectedFriend;
                [self presentViewController:imageViewController animated:YES completion:nil];
            }
        }
        else{
            ImageViewController *imageViewController;
            if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
                imageViewController = [[ImageViewController alloc] initWithNibName:@"ImageViewController_iPhone" bundle:nil];
            }
            else{
                imageViewController = [[ImageViewController alloc] initWithNibName:@"ImageViewController_iPad" bundle:nil];
            }
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *yourArtPath = [NSString stringWithFormat:@"%@/%d.png",documentsDirectory,[[dict objectForKey:@"image"] intValue]];
            imageViewController.image =  [UIImage imageWithContentsOfFile:yourArtPath];
            [self presentViewController:imageViewController animated:YES completion:nil];
        }
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
    
        NSLog(@"self.messages:%@",self.messages);

        NSString *rowID = [self.objDeleteIDsArray objectAtIndex:indexPath.row];
    
        // Remove the row from Web api
        [LocalStorageService shared].chatDelegate = self;
        [[LocalStorageService shared] clearChatHistoryByRowID:rowID];

        // Remove the row from data model
//        [self.messages removeObjectAtIndex:indexPath.row];
    
        // Request table view to reload
        [messageTableView reloadData];
    
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // no insertions!
	}

}

#pragma mark
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark
#pragma mark Keyboard notifications

- (void)keyboardWillShow:(NSNotification *)note
{
    [UIView animateWithDuration:0.3 animations:^{
		[self.messageTextField setFrame:CGRectMake(self.messageTextField.frame.origin.x, self.messageTextField.frame.origin.y-215,self.messageTextField.frame.size.width,self.messageTextField.frame.size.height)];
        [self.btnAdd setFrame:CGRectMake(self.btnAdd.frame.origin.x, self.btnAdd.frame.origin.y-215,self.btnAdd.frame.size.width,self.btnAdd.frame.size.height)];
        [self.btnSend setFrame:CGRectMake(self.btnSend.frame.origin.x, self.btnSend.frame.origin.y-215,self.btnSend.frame.size.width,self.btnSend.frame.size.height)];
        [self.lblDestruct setFrame:CGRectMake(self.lblDestruct.frame.origin.x, self.lblDestruct.frame.origin.y-215,self.lblDestruct.frame.size.width,self.lblDestruct.frame.size.height)];
        [self.btnDestruct setFrame:CGRectMake(self.btnDestruct.frame.origin.x, self.btnDestruct.frame.origin.y-215,self.btnDestruct.frame.size.width,self.btnDestruct.frame.size.height)];
        [self.messageTableView setFrame:CGRectMake(self.messageTableView.frame.origin.x,self.messageTableView.frame.origin.y,self.messageTableView.frame.size.width, self.messageTableView.frame.size.height-215)];
        if(self.messages.count > 0){
            NSLog(@"%d",self.messages.count);
            [self.messageTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.messages count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    }];
}

- (void)keyboardWillHide:(NSNotification *)note
{
    [UIView animateWithDuration:0.3 animations:^{
		[self.messageTextField setFrame:CGRectMake(self.messageTextField.frame.origin.x, self.messageTextField.frame.origin.y+215,self.messageTextField.frame.size.width,self.messageTextField.frame.size.height)];
        [self.btnAdd setFrame:CGRectMake(self.btnAdd.frame.origin.x, self.btnAdd.frame.origin.y+215,self.btnAdd.frame.size.width,self.btnAdd.frame.size.height)];
        [self.btnSend setFrame:CGRectMake(self.btnSend.frame.origin.x, self.btnSend.frame.origin.y+215,self.btnSend.frame.size.width,self.btnSend.frame.size.height)];
        [self.lblDestruct setFrame:CGRectMake(self.lblDestruct.frame.origin.x, self.lblDestruct.frame.origin.y+215,self.lblDestruct.frame.size.width,self.lblDestruct.frame.size.height)];
        [self.btnDestruct setFrame:CGRectMake(self.btnDestruct.frame.origin.x, self.btnDestruct.frame.origin.y+215,self.btnDestruct.frame.size.width,self.btnDestruct.frame.size.height)];
        [self.messageTableView setFrame:CGRectMake(self.messageTableView.frame.origin.x,self.messageTableView.frame.origin.y,self.messageTableView.frame.size.width, self.messageTableView.frame.size.height+215)];
        if(self.messages.count > 0){
            [self.messageTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.messages count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
    }];
}

@end
