//
//  LoginViewController.m
//  CustomerLoyalty
//
//  Created by Amit Parmar on 13/02/14.
//  Copyright (c) 2014 N-Tech. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistrationViewController.h"
#import "DashBoardViewController.h"


@implementation LoginViewController

@synthesize txtFieldEmail;
@synthesize txtFieldPassword;
@synthesize btnLogin;
@synthesize btnRegistration;
@synthesize btnForgotPassword;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [txtFieldEmail setReturnKeyType:UIReturnKeyNext];
    [txtFieldPassword setReturnKeyType:UIReturnKeyDone];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (IBAction)loginButtonClicked:(id)sender{
    if([txtFieldEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Please enter email id" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([txtFieldPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAppTitle message:@"Please enter password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        DashBoardViewController *dashBoardViewController;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
           dashBoardViewController = [[DashBoardViewController alloc] initWithNibName:@"DashBoardViewController" bundle:nil];
        }
        else{
           dashBoardViewController = [[DashBoardViewController alloc] initWithNibName:@"DashBoardViewController_iPad" bundle:nil];
        }
        [self.navigationController pushViewController:dashBoardViewController animated:YES];
    }
}
- (IBAction)registrationButtonClicked:(id)sender{
    RegistrationViewController *registrationViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        registrationViewController = [[RegistrationViewController alloc] initWithNibName:@"RegistrationViewController" bundle:nil];
    }
    else{
        registrationViewController = [[RegistrationViewController alloc] initWithNibName:@"RegistrationViewController_iPad" bundle:nil];
    }
    [self.navigationController pushViewController:registrationViewController animated:YES];
}
- (IBAction)forgotPasswordButtonClicked:(id)sender{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == txtFieldEmail){
        [txtFieldEmail resignFirstResponder];
        [txtFieldPassword becomeFirstResponder];
    }
    else if(textField == txtFieldPassword){
        [txtFieldPassword resignFirstResponder];
    }
    return YES;
}
@end
