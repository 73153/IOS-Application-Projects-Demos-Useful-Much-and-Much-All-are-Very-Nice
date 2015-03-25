//
//  SettingsViewController.h
//  Holaout
//
//  Created by Amit Parmar on 06/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController<QBActionStatusDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) IBOutlet UITextField *txtFieldName;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldEmail;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldPhone;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldOldPassword;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldNewPassword;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldWebsite;
@property (nonatomic, strong) IBOutlet UILabel *lblUserName;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong)  IBOutlet UIButton *btnProfileIcon;
@property (nonatomic, strong)  IBOutlet UIButton *btnBack;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;

- (IBAction)backButtonClicked:(id)sender;
- (IBAction)saveButtonClicked:(id)sender;
- (IBAction)btnProfileIconClicked:(id)sender;

@end
