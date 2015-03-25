//
//  ContactPickerViewController.h
//  Holaout
//
//  Created by Amit Parmar on 09/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"
#import "DataManager.h"

@interface ContactPickerViewController : UIViewController<MFMessageComposeViewControllerDelegate,QBActionStatusDelegate,ContactDelegate>

@property (nonatomic, strong) IBOutlet UIButton *btnSelectUnSelect;
@property (nonatomic, strong) IBOutlet UITableView *tblView;
@property (nonatomic, strong) IBOutlet UIButton *btnInviteOrSend;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) NSArray *contactArray;
@property (nonatomic) BOOL isAllSelected;
@property (nonatomic, strong) NSMutableArray *selectedArray;
@property (nonatomic, strong) UIImage *imageToSend;
@property (nonatomic, strong) UIImage *vidImgToSend;
@property (nonatomic, strong) NSString *vidIDString;
@property (nonatomic, strong) NSData *videoDataToSend;
@property (nonatomic) BOOL isVideo;
@property (nonatomic) BOOL isYTVideo;

- (IBAction)btnBackClicked:(id)sender;
- (IBAction)btnInviteClicked:(id)sender;
- (IBAction)btnSelectUnSelectClicked:(id)sender;

@end
