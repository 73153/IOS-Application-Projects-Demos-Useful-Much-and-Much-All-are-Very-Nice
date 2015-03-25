//
//  RegisterViewController.h
//  Holaout
//
//  Created by Amit Parmar on 05/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<QBActionStatusDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) IBOutlet UITextField *txtFieldUserName;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldEmail;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldPassword;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldReEnterPassword;
@property (nonatomic, strong) IBOutlet UITextField *txtPhone;
@property (nonatomic, strong) IBOutlet UIButton *btnChoose;
@property (nonatomic, strong) IBOutlet UIButton *btnRegister;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic) int userID;
@property (nonatomic, strong) UIImage *choosenImage;

- (IBAction)btnRegisterClicked:(id)sender;
- (IBAction)btnChooseClicked:(id)sender;
- (IBAction)backButtonClicked:(id)sender;
@end
