//
//  HomeViewController.m
//  Holaout
//
//  Created by Amit Parmar on 04/12/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"

@implementation HomeViewController

@synthesize btnLogin;
@synthesize btnRegister;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnLoginClicked:(id)sender{
    LoginViewController *loginViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
       loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController_iPhone" bundle:nil];
    }
    else{
        loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController_iPad" bundle:nil];
    }
    [self.navigationController pushViewController:loginViewController animated:YES];
    
}
- (IBAction)btnRegisterClicked:(id)sender{
    RegisterViewController *registerViewController;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        registerViewController = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController_iPhone" bundle:nil];
    }
    else{
        registerViewController = [[RegisterViewController alloc] initWithNibName:@"RegisterViewController_iPad" bundle:nil];
    }
    [self.navigationController pushViewController:registerViewController animated:YES];
}

@end
