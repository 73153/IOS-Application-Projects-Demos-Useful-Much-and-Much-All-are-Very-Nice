//
//  WebVideoViewController.h
//  YTBrowser
//
//  Created by Marin Todorov on 09/01/2013.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"
#import "DataManager.h"

@interface WebVideoViewController : UIViewController <ContactDelegate,QBActionStatusDelegate>

@property (strong, nonatomic) VideoModel* video;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIButton *btnSend;
@property (nonatomic) BOOL hideSendBtn;
@property (strong, nonatomic) NSString *strVideoID;
@property (strong, nonatomic) NSString *resVideoID;
@property (nonatomic, strong) NSArray *friendsOnHolaout;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) NSDictionary *seledtedFriend;

- (IBAction)backButtonClicked:(id)sender;
- (IBAction)sendButtonClicked:(id)sender;

@end
