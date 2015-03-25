//
//  ViewController.m
//  Dialysis_New
//
//  Created by Amit Parmar on 27/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import "ViewController.h"
#import "AppConstant.h"
#import "InformationViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize tabBarController;
@synthesize firstViewController;
@synthesize graphViewController;
@synthesize editViewController;
@synthesize medicineViewController;


- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self performSelector:@selector(btnGoForAppClicked) withObject:nil afterDelay:3.0];
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(void)addTabbarController{
     if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
         self.editViewController = [[EditPersonalInfoViewController alloc] initWithNibName:@"EditPersonalInfoViewController_iPhone" bundle:nil];
         self.firstViewController = [[FirstViewController alloc] initWithNibName:@"FirstViewController_iPhone" bundle:nil];
         self.medicineViewController = [[MedicineViewController alloc] initWithNibName:@"MedicineViewController_iPhone" bundle:nil];
         self.graphViewController = [[GraphViewController alloc] initWithNibName:@"GraphViewController_iPhone" bundle:nil];
     }
     else{
         self.editViewController = [[EditPersonalInfoViewController alloc] initWithNibName:@"EditPersonalInfoViewController_iPad" bundle:nil];
         self.firstViewController = [[FirstViewController alloc] initWithNibName:@"FirstViewController_iPad" bundle:nil];
         self.medicineViewController = [[MedicineViewController alloc] initWithNibName:@"MedicineViewController_iPad" bundle:nil];
         self.graphViewController = [[GraphViewController alloc] initWithNibName:@"GraphViewController_iPad" bundle:nil];
     }
    
    
    UINavigationController *navController1 = [[UINavigationController alloc] initWithRootViewController:self.editViewController];
    [navController1 setNavigationBarHidden:YES animated:NO];
    
    UINavigationController *navController2 = [[UINavigationController alloc] initWithRootViewController:self.firstViewController];
    [navController2 setNavigationBarHidden:YES animated:NO];
    
    UINavigationController *navController3 = [[UINavigationController alloc] initWithRootViewController:self.medicineViewController];
    [navController3 setNavigationBarHidden:YES animated:NO];
    
    UINavigationController *navController4 = [[UINavigationController alloc] initWithRootViewController:self.graphViewController];
    [navController4 setNavigationBarHidden:YES animated:NO];
    
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:navController1,navController2,navController3,navController4, nil];
    self.tabBarController.selectedIndex = 1;
    self.tabBarController.view.autoresizesSubviews = YES;
    self.tabBarController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    if([[[UIDevice currentDevice] systemVersion] intValue] >= 7){
        [self.tabBarController.tabBar setBarTintColor:[UIColor colorWithRed:0.4863 green:0.0000 blue:0.0196 alpha:1.0]];
    }
}

- (void)btnGoForAppClicked{
    
}
@end
