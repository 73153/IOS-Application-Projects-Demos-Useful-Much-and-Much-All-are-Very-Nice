//
//  AddFriendViewController.h
//  Holaout
//
//  Created by Amit Parmar on 09/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddFriendViewController : UIViewController<MFMailComposeViewControllerDelegate,QBActionStatusDelegate,FBFriendPickerDelegate>

@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) IBOutlet UIButton *btnContactList;
@property (nonatomic, strong) IBOutlet UIButton *btnFacebook;
@property (nonatomic, strong) IBOutlet UIButton *btnByEmail;

@property (nonatomic, strong) IBOutlet UIButton *btnSyncAddressBook;
@property (nonatomic, strong) IBOutlet UIButton *btnSyncFacebook;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) FBFriendPickerViewController *friendPickerController;
@property (strong,nonatomic) NSArray *contactArray;



- (IBAction)btnContactListClicked:(id)sender;
- (IBAction)btnFacebookClicked:(id)sender;
- (IBAction)btnEmailClicked:(id)sender;
- (IBAction)btnSyncAddressBookClicked:(id)sender;
- (IBAction)btnSyncFacebookClicked:(id)sender;
- (IBAction)backButtonClicked:(id)sender;

@end
