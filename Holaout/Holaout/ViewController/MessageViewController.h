//
//  MessageViewController.h
//  Holaout
//
//  Created by Amit Parmar on 12/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

@interface MessageViewController : UIViewController<QBActionStatusDelegate,chatDelegate,UIActionSheetDelegate,UIAlertViewDelegate,ContactDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) IBOutlet UIImageView *imgViewProfile;
@property (nonatomic, strong) IBOutlet UITableView *messageTableView;
@property (nonatomic, strong) IBOutlet UITextField *messageTextField;
@property (nonatomic, strong) IBOutlet UIButton *btnAdd;
@property (nonatomic, strong) IBOutlet UIButton *btnSend;
@property (nonatomic, strong) IBOutlet UIButton *btnDestruct;
@property (nonatomic, strong) IBOutlet UILabel  *lblDestruct;
@property (nonatomic, strong) IBOutlet UILabel  *lblUserName;
@property (nonatomic, strong) NSMutableArray *messages;
@property (nonatomic, strong) NSMutableArray *objDeleteIDsArray;
@property (nonatomic, strong) NSMutableArray *objDestructIDsArray;
@property (nonatomic, strong) QBUUser *opponent;
@property (nonatomic, strong) NSDictionary *selectedFriend;
@property (nonatomic) BOOL *btnDestructSelected;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray *contactArray;
@property (nonatomic, strong)  IBOutlet UIButton *btnClearHistory;
@property (nonatomic, strong)  IBOutlet UIButton *btnBlockUser;
@property (nonatomic, strong)  IBOutlet UIButton *btnEditProfile;
@property (nonatomic, strong)  IBOutlet UIView *settingView;

- (IBAction)btnClearHistoryClicked:(id)sender;
- (IBAction)btnBlockUserClicked:(id)sender;
- (IBAction)btnEditProfileClicked:(id)sender;
- (IBAction)btnBackClicked:(id)sender;
- (IBAction)btnSettingsClicked:(id)sender;
- (IBAction)btnAddClicked:(id)sender;
- (IBAction)btnSendClicked:(id)sender;
- (IBAction)btnDestructClicked:(id)sender;
- (void)keyboardWillShow:(NSNotification *)note;
- (void)keyboardWillHide:(NSNotification *)note;
- (void)chatDidReceiveMessageNotification:(NSNotification *)notification;
@end
