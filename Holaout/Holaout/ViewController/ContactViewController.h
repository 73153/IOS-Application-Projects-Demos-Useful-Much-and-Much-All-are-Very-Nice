//
//  ContactViewController.h
//  Holaout
//
//  Created by Amit Parmar on 10/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

@interface ContactViewController : UIViewController<QBActionStatusDelegate,MFMessageComposeViewControllerDelegate,ContactDelegate>

@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) IBOutlet UITableView *tblView;
@property (nonatomic, strong) NSArray *friendsOnHolaOut;
@property (nonatomic, strong) NSArray *otherFriends;
@property (nonatomic, strong) NSMutableArray *imagesArray;
@property (nonatomic, strong) CALayer* containerLayer;

@property (nonatomic, strong) NSArray *searchedHolaoutFriend;
@property (nonatomic, strong) NSArray *searchedOtherFriend;

- (IBAction)backButtonClicked:(id)sender;

@end
