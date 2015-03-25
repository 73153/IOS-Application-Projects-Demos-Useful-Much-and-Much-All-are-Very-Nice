//
//  PlayVideoViewController.h
//  Holaout
//
//  Created by Amit Parmar on 10/01/14.
//  Copyright (c) 2014 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayVideoViewController : UIViewController<QBActionStatusDelegate>

@property (nonatomic, strong) IBOutlet UIButton *btnSend;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) MPMoviePlayerController *theMoviPlayer;
@property (nonatomic, strong) NSURL *movieUrl;
@property (nonatomic, strong) NSDictionary *selectedFriend;
@property (nonatomic, strong) NSArray *friendsOnHolaout;
@property (nonatomic) BOOL hideSendButton;

- (IBAction)btnSendClicked:(id)sender;
@end
