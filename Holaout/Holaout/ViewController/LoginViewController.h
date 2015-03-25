//
//  LoginViewController.h
//  Holaout
//
//  Created by Amit Parmar on 05/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<QBActionStatusDelegate,UISplitViewControllerDelegate,CLLocationManagerDelegate>

@property (nonatomic, strong) IBOutlet UITextField *txtUserName;
@property (nonatomic, strong) IBOutlet UITextField *txtPassword;
@property (nonatomic, strong) IBOutlet UIButton *btnLogin;
@property (nonatomic, strong) IBOutlet UIButton *btnForgotPassword;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) CLLocationManager *locationManager;

- (IBAction)btnLoginClicked:(id)sender;
- (IBAction)btnForgotPasswordClicked:(id)sender;
- (IBAction)backButtonClicked:(id)sender;

@end
