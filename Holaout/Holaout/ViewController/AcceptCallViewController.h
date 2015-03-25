//
//  AcceptCallViewController.h
//  Holaout
//
//  Created by Amit Parmar on 09/01/14.
//  Copyright (c) 2014 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AcceptCallViewController : UIViewController<QBActionStatusDelegate>

@property (nonatomic, strong) IBOutlet UILabel *lblUserName;
@property (nonatomic, strong) IBOutlet UILabel *lblTime;
@property (nonatomic, strong) IBOutlet UILabel *lblDay;
@property (nonatomic, strong) IBOutlet UIImageView *userImageView;
@property (nonatomic, strong) NSString * sessionId;
@property (nonatomic) int userId;
@property (nonatomic, strong) NSDictionary *selectedFriend;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic) int count;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

- (IBAction)btnBackClicked:(id)sender;
- (IBAction)btnSettingsClicked:(id)sender;
- (IBAction)btnAcceptClicked:(id)sender;
- (IBAction)btnRejectClicked:(id)sender;
@end
