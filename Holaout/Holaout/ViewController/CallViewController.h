//
//  CallViewController.h
//  Holaout
//
//  Created by Amit Parmar on 28/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CallViewController : UIViewController<QBChatDelegate>

@property (nonatomic, strong) IBOutlet UILabel *lblUserName;
@property (nonatomic, strong) IBOutlet UILabel *lblTime;
@property (nonatomic, strong) IBOutlet UILabel *lblDay;
@property (nonatomic, strong) IBOutlet UIImageView *userImageView;
@property (nonatomic, strong) NSDictionary *selectedFriend;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic) int count;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

- (IBAction)btnSpeakerClicked:(id)sender;
- (IBAction)btnMuteClicked:(id)sender;
- (IBAction)btnChatClicked:(id)sender;
- (IBAction)btnCallEndClicked:(id)sender;
- (IBAction)btnBackClicked:(id)sender;
- (IBAction)btnSettingsClicked:(id)sender;

@end
