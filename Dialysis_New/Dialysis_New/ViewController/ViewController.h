//
//  ViewController.h
//  Dialysis_New
//
//  Created by Amit Parmar on 27/11/13.
//  Copyright (c) 2013 N-Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditPersonalInfoViewController.h"
#import "FirstViewController.h"
#import "MedicineViewController.h"
#import "GraphViewController.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIButton *btnGoForApp;
@property (nonatomic, strong) UITabBarController *tabBarController;
@property (nonatomic, strong) EditPersonalInfoViewController *editViewController;
@property (nonatomic, strong) FirstViewController *firstViewController;
@property (nonatomic, strong) MedicineViewController *medicineViewController;
@property (nonatomic, strong) GraphViewController *graphViewController;

- (void)btnGoForAppClicked;
@end
