//
//  InvitationViewController.h
//  Holaout
//
//  Created by Amit Parmar on 09/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

@interface InvitationViewController : UIViewController<QBActionStatusDelegate,ContactDelegate>

@property (nonatomic, strong) IBOutlet UILabel *lblName;
@property (nonatomic, strong) IBOutlet UIImageView *profileImgView;
@property (nonatomic, strong) IBOutlet UIButton *btnsendMessage;
@property (nonatomic, strong) IBOutlet UIButton *btnAddToContact;
@property (nonatomic, strong) IBOutlet UIButton *btnBlock;
@property (nonatomic, strong) QBUUser *user;
@property (nonatomic, strong) NSData *imgData;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;
@property(nonatomic,strong) NSArray *contactArr;
@property(nonatomic,strong) NSString *currentUser;

- (IBAction)backButtonClicked:(id)sender;
- (IBAction)sendMessageButtonClicked:(id)sender;
- (IBAction)addToContactButtonClicked:(id)sender;
- (IBAction)blockUserButtonClicked:(id)sender;

@end
