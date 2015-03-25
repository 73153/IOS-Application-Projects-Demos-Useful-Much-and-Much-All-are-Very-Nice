//
//  HomeViewController.h
//  Holaout
//
//  Created by Amit Parmar on 04/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIButton *btnLogin;
@property (nonatomic, strong) IBOutlet UIButton *btnRegister;

- (IBAction)btnLoginClicked:(id)sender;
- (IBAction)btnRegisterClicked:(id)sender;
@end
