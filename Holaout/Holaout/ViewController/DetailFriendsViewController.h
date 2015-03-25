//
//  DetailFriendsViewController.h
//  Holaout
//
//  Created by Amit Parmar on 27/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailFriendsViewController : UIViewController<QBActionStatusDelegate>

@property (nonatomic, strong) IBOutlet UIButton *btnBack;
@property (nonatomic, strong) IBOutlet UIButton *btnInfo;
@property (nonatomic, strong) IBOutlet UILabel *lblUserName;
@property (nonatomic, strong) IBOutlet NZCircularImageView *userImageView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *friendsArray;
@property (nonatomic, strong) NSDictionary *selectedFriend;
@property (nonatomic, strong) IBOutlet UILabel *lblPlace;
@property (nonatomic, strong) IBOutlet UILabel *lblStatus;

- (IBAction)backButtonClicked:(id)sender;
- (IBAction)infoButtonClicked:(id)sender;
- (IBAction)settingsClicked:(id)sender;
- (void) getCheckIns;
@end
