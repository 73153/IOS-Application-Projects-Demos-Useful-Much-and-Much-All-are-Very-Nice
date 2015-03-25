//
//  LoginViewController.h
//  CustomerLoyalty
//
//  Created by Amit Parmar on 13/02/14.
//  Copyright (c) 2014 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *txtFieldEmail;
@property (nonatomic, strong) IBOutlet UITextField *txtFieldPassword;
@property (nonatomic, strong) IBOutlet UIButton *btnLogin;
@property (nonatomic, strong) IBOutlet UIButton *btnRegistration;
@property (nonatomic, strong) IBOutlet UIButton *btnForgotPassword;


- (IBAction)loginButtonClicked:(id)sender;
- (IBAction)registrationButtonClicked:(id)sender;
- (IBAction)forgotPasswordButtonClicked:(id)sender;
@end
