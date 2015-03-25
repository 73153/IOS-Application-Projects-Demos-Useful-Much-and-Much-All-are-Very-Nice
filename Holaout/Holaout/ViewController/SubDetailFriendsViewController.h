//
//  SubDetailFriendsViewController.h
//  Holaout
//
//  Created by Amit Parmar on 27/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubDetailFriendsViewController : UIViewController<QBChatDelegate,QBActionStatusDelegate>

@property (nonatomic, strong) NSDictionary *selectedFriend;
@property (nonatomic, strong) IBOutlet UILabel *lblUsername;
@property (nonatomic, strong) IBOutlet NZCircularImageView *userImageView;
@property (nonatomic, strong) IBOutlet UILabel *lblPlace;
@property (nonatomic, strong) IBOutlet UILabel *lblStatus;


- (IBAction)backButtonClicked:(id)sender;
- (IBAction)settingsClicked:(id)sender;
- (IBAction)btnVideoClicked:(id)sender;
- (IBAction)btnPhotoClicked:(id)sender;
- (IBAction)btnChatClicked:(id)sender;
- (IBAction)btnCallClicked:(id)sender;
- (IBAction)btnDrawingClicked:(id)sender;
//- (void) getCheckIns;
- (void) presentCallView:(NSDictionary *)data;
+(SubDetailFriendsViewController *)subdetail;
@end
